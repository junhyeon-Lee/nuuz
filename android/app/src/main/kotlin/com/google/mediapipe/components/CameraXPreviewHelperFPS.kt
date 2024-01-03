//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//
package com.google.mediapipe.components

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.graphics.SurfaceTexture
import android.hardware.camera2.*
import android.opengl.GLES20
import android.os.Handler
import android.os.HandlerThread
import android.os.SystemClock
import android.util.Log
import android.util.Range
import android.util.Size
import android.view.Surface
import androidx.camera.camera2.internal.compat.CameraManagerCompat
import androidx.camera.camera2.interop.Camera2Interop
import androidx.camera.core.*
import androidx.camera.core.SurfaceRequest.TransformationInfo
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.content.ContextCompat
import androidx.lifecycle.LifecycleOwner
import com.google.mediapipe.glutil.EglManager
import java.io.File
import java.util.*
import java.util.concurrent.Executor
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import java.util.concurrent.RejectedExecutionException
import javax.annotation.Nonnull


class CameraXPreviewHelperFPS : CameraHelper() {
    private val renderExecutor = SingleThreadHandlerExecutor("RenderThread", 0)
    private var cameraProvider: ProcessCameraProvider? = null
    private var preview: Preview? = null
    private var imageCapture: ImageCapture? = null
    private var imageCaptureBuilder: ImageCapture.Builder? = null
    private var imageCaptureExecutorService: ExecutorService? = null
    private var camera: Camera? = null
    private var textures: IntArray? = null
    var frameSize: Size? = null
        private set
    private var frameRotation = 0
    private var isImageCaptureEnabled = false
    private var cameraCharacteristics: CameraCharacteristics? = null
    var focalLengthPixels = Float.MIN_VALUE
        private set
    private var cameraTimestampSource = 0
    override fun startCamera(
        activity: Activity,
        cameraFacing: CameraFacing,
        surfaceTexture: SurfaceTexture?
    ) {
        this.startCamera(
            activity as Context,
            activity as LifecycleOwner,
            cameraFacing,
            surfaceTexture,
            TARGET_SIZE
        )
    }

    fun startCamera(
        activity: Context,
        cameraFacing: CameraFacing,
        surfaceTexture: SurfaceTexture?,
        targetSize: Size?
    ) {
        this.startCamera(
            activity as Context,
            activity as LifecycleOwner,
            cameraFacing,
            surfaceTexture,
            targetSize
        )
    }

    fun startCamera(
        activity: Context,
        imageCaptureBuilder: ImageCapture.Builder,
        cameraFacing: CameraFacing,
        targetSize: Size?
    ) {
        this.imageCaptureBuilder = imageCaptureBuilder
        this.startCamera(activity as Context, activity as LifecycleOwner, cameraFacing, targetSize)
    }

    fun startCamera(
        activity: Context,
        imageCaptureBuilder: ImageCapture.Builder,
        cameraFacing: CameraFacing,
        surfaceTexture: SurfaceTexture?,
        targetSize: Size?
    ) {
        this.imageCaptureBuilder = imageCaptureBuilder
        this.startCamera(
            activity as Context,
            activity as LifecycleOwner,
            cameraFacing,
            surfaceTexture,
            targetSize
        )
    }

    fun startCamera(
        context: Context,
        lifecycleOwner: LifecycleOwner?,
        cameraFacing: CameraFacing,
        targetSize: Size?
    ) {
        this.startCamera(context, lifecycleOwner, cameraFacing, null as SurfaceTexture?, targetSize)
    }

    private fun startCamera(
        context: Context,
        lifecycleOwner: LifecycleOwner?,
        cameraFacing: CameraFacing,
        surfaceTexture: SurfaceTexture?,
        targetSize: Size?
    ) {
        var targetSize = targetSize
        val mainThreadExecutor = ContextCompat.getMainExecutor(context)
        val cameraProviderFuture = ProcessCameraProvider.getInstance(context)
        val isSurfaceTextureProvided = surfaceTexture != null
        val selectedLensFacing = if (cameraFacing == CameraFacing.FRONT) 0 else 1
        cameraCharacteristics = getCameraCharacteristics(context, selectedLensFacing)
        targetSize = getOptimalViewSize(targetSize)
        if (targetSize == null) {
            targetSize = TARGET_SIZE
        }
        val rotatedSize = Size(targetSize.height, targetSize.width)
        cameraProviderFuture.addListener({
            try {
                cameraProvider = cameraProviderFuture.get() as ProcessCameraProvider
            } catch (var9: Exception) {
                if (var9 is InterruptedException) {
                    Thread.currentThread().interrupt()
                }
                Log.e("CameraXPreviewHelper", "Unable to get ProcessCameraProvider: ", var9)
                return@addListener
            }
            val build = Preview.Builder().setTargetResolution(rotatedSize)
            try {
                setHighFPS(build, context)
            } catch (e: Exception) {
            }
            preview = build.build()
            val cameraSelector =
                if (cameraFacing == CameraFacing.FRONT) CameraSelector.DEFAULT_FRONT_CAMERA else CameraSelector.DEFAULT_BACK_CAMERA
            preview!!.setSurfaceProvider(renderExecutor) { request: SurfaceRequest ->
                frameSize = request.resolution
                Log.d(
                    "CameraXPreviewHelper",
                    String.format(
                        "Received surface request for resolution %dx%d",
                        frameSize!!.width,
                        frameSize!!.height
                    )
                )
                val previewFrameTexture =
                    if (isSurfaceTextureProvided) surfaceTexture else createSurfaceTexture()
                previewFrameTexture!!.setDefaultBufferSize(frameSize!!.width, frameSize!!.height)
                request.setTransformationInfoListener(renderExecutor) { transformationInfo: TransformationInfo ->
                    frameRotation = transformationInfo.rotationDegrees
                    updateCameraCharacteristics()
                    if (!isSurfaceTextureProvided) {
                        previewFrameTexture.detachFromGLContext()
                    }
                    val listener = onCameraStartedListener
                    if (listener != null) {
                        ContextCompat.getMainExecutor(context)
                            .execute { listener.onCameraStarted(previewFrameTexture) }
                    }
                }
                val surface = Surface(previewFrameTexture)
                Log.d("CameraXPreviewHelper", "Providing surface")
                request.provideSurface(surface, renderExecutor) { result: SurfaceRequest.Result ->
                    Log.d("CameraXPreviewHelper", "Surface request result: $result")
                    if (textures != null) {
                        GLES20.glDeleteTextures(1, textures, 0)
                    }
                    if (!isSurfaceTextureProvided) {
                        previewFrameTexture.release()
                    }
                    surface.release()
                }
            }
            cameraProvider!!.unbindAll()
            if (imageCaptureBuilder != null) {
                imageCapture = imageCaptureBuilder!!.build()
                camera = cameraProvider!!.bindToLifecycle(
                    lifecycleOwner!!, cameraSelector, *arrayOf(
                        preview, imageCapture
                    )
                )
                imageCaptureExecutorService = Executors.newSingleThreadExecutor()
                isImageCaptureEnabled = true
            } else {
                camera = cameraProvider!!.bindToLifecycle(lifecycleOwner!!, cameraSelector, preview)
            }
        }, mainThreadExecutor)
    }

    @Throws(CameraAccessException::class)
    private fun setHighFPS(builder: Preview.Builder, context: Context) {
        @SuppressLint("RestrictedApi") val cameraManager =
            CameraManagerCompat.from(context).unwrap()
        val ids = cameraManager.cameraIdList
        var mCameraId: String?
        Log.d("setHighFPS", "setHighFpse")
        val cameraSelector =
            if (cameraFacing == CameraFacing.FRONT) CameraCharacteristics.LENS_FACING_FRONT else CameraSelector.LENS_FACING_BACK
        for (id in ids) {
            val c = cameraManager.getCameraCharacteristics(id)
            val lensFacing = c.get(CameraCharacteristics.LENS_FACING)
            if (lensFacing != null &&
                lensFacing == cameraSelector
            ) {
                mCameraId = id
                val characteristics = cameraManager.getCameraCharacteristics(mCameraId)
                val fpsRange =
                    characteristics.get(CameraCharacteristics.CONTROL_AE_AVAILABLE_TARGET_FPS_RANGES)
                if (fpsRange != null && fpsRange.size > 0) {
                    var maxFps = fpsRange[0]
                    for (aFpsRange in fpsRange) {
                        if (maxFps.lower * maxFps.upper < aFpsRange.lower * aFpsRange.upper) {
                            maxFps = aFpsRange
                        }
                    }
                    val fps = Range(30, 60)
                    val ext = Camera2Interop.Extender(builder)
                    ext
                        .setCaptureRequestOption(
                            CaptureRequest.CONTROL_AWB_MODE,
                            CameraMetadata.CONTROL_AWB_MODE_OFF
                        )
                        .setCaptureRequestOption(CaptureRequest.CONTROL_AE_TARGET_FPS_RANGE, fps)
                    Log.d("setHighFPS", "setHighFpse$maxFps")
                }
            }
        }
    }

    fun takePicture(outputFile: File?, onImageSavedCallback: ImageCapture.OnImageSavedCallback?) {
        if (isImageCaptureEnabled) {
            val outputFileOptions = ImageCapture.OutputFileOptions.Builder(
                outputFile!!
            ).build()
            imageCapture!!.takePicture(
                outputFileOptions,
                imageCaptureExecutorService!!,
                onImageSavedCallback!!
            )
        }
    }

    override fun isCameraRotated(): Boolean {
        return frameRotation % 180 == 90
    }

    override fun computeDisplaySizeFromViewSize(viewSize: Size): Size {
        return frameSize!!
    }

    private fun getOptimalViewSize(targetSize: Size?): Size? {
        return if (targetSize != null && cameraCharacteristics != null) {
            val outputSizes =
                cameraCharacteristics!!.get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP)!!
                    .getOutputSizes(
                        SurfaceTexture::class.java
                    )
            var optimalSize: Size? = null
            val targetRatio = targetSize.width.toDouble() / targetSize.height.toDouble()
            Log.d(
                "CameraXPreviewHelper",
                String.format(
                    "Camera target size ratio: %f width: %d",
                    targetRatio,
                    targetSize.width
                )
            )
            var minCost = Double.MAX_VALUE
            val var10 = outputSizes.size
            for (var11 in 0 until var10) {
                val size = outputSizes[var11]
                val aspectRatio = size.width.toDouble() / size.height.toDouble()
                val ratioDiff = Math.abs(aspectRatio - targetRatio)
                val cost =
                    (if (ratioDiff > 0.25) 10000.0 + ratioDiff * targetSize.height.toDouble() else 0.0) + Math.abs(
                        size.width - targetSize.width
                    ).toDouble()
                Log.d(
                    "CameraXPreviewHelper",
                    String.format(
                        "Camera size candidate width: %d height: %d ratio: %f cost: %f",
                        size.width,
                        size.height,
                        aspectRatio,
                        cost
                    )
                )
                if (cost < minCost) {
                    optimalSize = size
                    minCost = cost
                }
            }
            if (optimalSize != null) {
                Log.d(
                    "CameraXPreviewHelper",
                    String.format(
                        "Optimal camera size width: %d height: %d",
                        optimalSize.width,
                        optimalSize.height
                    )
                )
            }
            optimalSize
        } else {
            null
        }
    }

    val timeOffsetToMonoClockNanos: Long
        get() = if (cameraTimestampSource == 1) offsetFromRealtimeTimestampSource else offsetFromUnknownTimestampSource

    private fun updateCameraCharacteristics() {
        if (cameraCharacteristics != null) {
            cameraTimestampSource =
                cameraCharacteristics!!.get(CameraCharacteristics.SENSOR_INFO_TIMESTAMP_SOURCE)!!
            focalLengthPixels = calculateFocalLengthInPixels()
        }
    }

    private fun calculateFocalLengthInPixels(): Float {
        val focalLengthMm =
            cameraCharacteristics!!.get(CameraCharacteristics.LENS_INFO_AVAILABLE_FOCAL_LENGTHS)!![0]
        val sensorWidthMm =
            cameraCharacteristics!!.get(CameraCharacteristics.SENSOR_INFO_PHYSICAL_SIZE)!!.width
        return frameSize!!.width.toFloat() * focalLengthMm / sensorWidthMm
    }

    private fun createSurfaceTexture(): SurfaceTexture {
        val eglManager = EglManager(null as Any?)
        val tempEglSurface =
            eglManager.createOffscreenSurface(1, 1)
        eglManager.makeCurrent(tempEglSurface, tempEglSurface)
        textures = IntArray(1)
        GLES20.glGenTextures(1, textures, 0)
        return SurfaceTexture(textures!![0])
    }

    private class SingleThreadHandlerExecutor internal constructor(
        threadName: String?,
        priority: Int
    ) : Executor {
        private val handlerThread: HandlerThread
        private val handler: Handler

        init {
            handlerThread = HandlerThread(threadName, priority)
            handlerThread.start()
            handler = Handler(handlerThread.looper)
        }

        override fun execute(command: Runnable) {
            if (!handler.post(command)) {
                throw RejectedExecutionException(handlerThread.name + " is shutting down.")
            }
        }

        fun shutdown(): Boolean {
            return handlerThread.quitSafely()
        }
    }

    companion object {
        private const val TAG = "CameraXPreviewHelper"
        private val TARGET_SIZE = Size(1280, 720)
        private const val ASPECT_TOLERANCE = 0.25
        private const val ASPECT_PENALTY = 10000.0
        private const val CLOCK_OFFSET_CALIBRATION_ATTEMPTS = 3
        private val offsetFromUnknownTimestampSource: Long
            private get() = 0L
        private val offsetFromRealtimeTimestampSource: Long
            private get() {
                var offset = Long.MAX_VALUE
                var lowestGap = Long.MAX_VALUE
                for (i in 0..2) {
                    val startMonoTs = System.nanoTime()
                    val realTs = SystemClock.elapsedRealtimeNanos()
                    val endMonoTs = System.nanoTime()
                    val gapMonoTs = endMonoTs - startMonoTs
                    if (gapMonoTs < lowestGap) {
                        lowestGap = gapMonoTs
                        offset = (startMonoTs + endMonoTs) / 2L - realTs
                    }
                }
                return offset
            }

        private fun getCameraCharacteristics(
            context: Context,
            lensFacing: Int
        ): CameraCharacteristics? {
            val cameraManager = context.getSystemService(android.content.Context.CAMERA_SERVICE) as CameraManager
            try {
                val cameraList = Arrays.asList(*cameraManager.cameraIdList)
                val var4: Iterator<*> = cameraList.iterator()
                while (var4.hasNext()) {
                    val availableCameraId = var4.next() as String
                    val availableCameraCharacteristics =
                        cameraManager.getCameraCharacteristics(availableCameraId)
                    val availableLensFacing =
                        availableCameraCharacteristics.get(CameraCharacteristics.LENS_FACING)
                    if (availableLensFacing != null && availableLensFacing == lensFacing) {
                        return availableCameraCharacteristics
                    }
                }
            } catch (var8: CameraAccessException) {
                Log.e("CameraXPreviewHelper", "Accessing camera ID info got error: $var8")
            }
            return null
        }
    }
}