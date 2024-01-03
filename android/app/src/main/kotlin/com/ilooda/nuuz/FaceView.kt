package com.ilooda.nuuz


import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.graphics.Matrix
import android.graphics.drawable.Drawable
import android.util.AttributeSet
import android.util.Log
import android.util.Size
import android.view.View
import android.widget.FrameLayout
import androidx.appcompat.widget.AppCompatDrawableManager
import androidx.camera.core.*
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.core.content.ContextCompat
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import com.google.mediapipe.solutions.facemesh.FaceMesh
import com.google.mediapipe.solutions.facemesh.FaceMeshOptions
import com.google.mediapipe.solutions.facemesh.FaceMeshResult
import java.util.ArrayDeque
import java.util.concurrent.ExecutorService
import java.util.concurrent.Executors
import java.util.concurrent.atomic.AtomicBoolean


class FaceView : FrameLayout, DefaultLifecycleObserver {
    private val TAG = "FaceView"
    private var facemesh: FaceMesh? = null
    private lateinit var imageView: OverlayView
    private lateinit var subview: FrameLayout
    private val isRun=AtomicBoolean(false)
    private enum class InputSource {
        UNKNOWN, CAMERA
    }

    private var inputSource = InputSource.UNKNOWN
    private val RUN_ON_GPU = true


    // Live camera demo UI and camera components.
//    private var cameraInput: CameraInputFPS? = null
//    private var glSurfaceView: PreviewView? = null

    constructor(context: Context, attrs: AttributeSet, defStyleAttr: Int, defStyleRes: Int) : super(
        context,
        attrs,
        defStyleAttr,
        defStyleRes
    ) {
        this.start()
        (context as LifecycleOwner).lifecycle.addObserver(
            this
        )
    }

    constructor(context: Context, attrs: AttributeSet?) : super(context, attrs) {
        this.start()
        (context as LifecycleOwner).lifecycle.addObserver(
            this
        )
    }

    fun start() {
        setupLiveDemoUiComponents()
    }

    /** Sets up the UI components for the live demo with camera input.  */
    fun setupLiveDemoUiComponents() {
        stopCurrentPipeline()
        setupStreamingModePipeline(InputSource.CAMERA)
        startCamera()
    }

    /** Sets up core workflow for streaming mode.  */


    private fun setupStreamingModePipeline(inputSource: InputSource) {
        this.inputSource = inputSource

        // Initializes a new MediaPipe Face Mesh solution instance in the streaming mode.
        facemesh = FaceMesh(
            this.context,
            FaceMeshOptions.builder()
                .setStaticImageMode(false)
                .setMaxNumFaces(1)
                .setRefineLandmarks(true)
                .setRunOnGpu(RUN_ON_GPU)
                .build()
        )
        facemesh!!.setErrorListener { message: String, e: RuntimeException? ->
            Log.e(
                "CAMERAVIEW",
                "MediaPipe Face Mesh error:$message"
            )
        }


//        if(glSurfaceView==null) {
//            // Initializes a new Gl surface view with a user-defined FaceMeshResultGlRenderer.
//
//            glSurfaceView = PreviewView(this.context)
//            glSurfaceView?.alpha=0.0F
//            //glSurfaceView?.scaleType=PreviewView.ScaleType.FILL_CENTER
//
//
//        }
        //SolutionGlSurfaceView(this.context, facemesh!!.glContext, facemesh!!.glMajorVersion)
//        glSurfaceView!!.setSolutionResultRenderer(FaceMeshResultGlRenderer())
//        glSurfaceView!!.setRenderInputImage(true)
        facemesh!!.setResultListener { faceMeshResult: FaceMeshResult ->
//            faceMeshResult.inputBitmap()?.let {
//                Log.d(
//                    TAG,
//                    "${faceMeshResult.inputBitmap().height},${faceMeshResult.inputBitmap().width} faceMeshResult.inputBitmap ${faceMeshResult.multiFaceLandmarks().size}"
//                )
//            }
            // Keep track of frames analyzed
            val currentTime = System.currentTimeMillis()
            frameTimestamps.push(currentTime)

            // Compute the FPS using a moving average
            while (frameTimestamps.size >= frameRateWindow) frameTimestamps.removeLast()
            val timestampFirst = frameTimestamps.peekFirst() ?: currentTime
            val timestampLast = frameTimestamps.peekLast() ?: currentTime
            val framesPerSecond = 1.0 / ((timestampFirst - timestampLast) /
                    frameTimestamps.size.coerceAtLeast(1).toDouble()) * 1000.0
            Log.d("FPS","fps=$framesPerSecond")
            rotatedBitmap?.let {
                val bitmap = it.copy(
                    it.config,
                    true
                )//faceMeshResult.inputBitmap().copy(faceMeshResult.inputBitmap().config,true)//Bitmap.createBitmap(faceMeshResult.inputBitmap().width,faceMeshResult.inputBitmap().height,faceMeshResult.inputBitmap().config,) //faceMeshResult.inputBitmap().copy(faceMeshResult.inputBitmap().config,true)//faceMeshResult.inputBitmap().copy(faceMeshResult.inputBitmap().config,true)//
//                imageView.setResults(
//                    bitmap,
//                    faceMeshResult,
//                    bitmap.height,
//                    bitmap.width,
//
//                )
                activeCare?.logNoseLandmark(bitmap,faceMeshResult,bitmap.height,bitmap.width, this.subview,imageView)
            }

            //  logNoseLandmark(faceMeshResult,faceMeshResult.inputBitmap().height,faceMeshResult.inputBitmap().width)
//            glSurfaceView!!.setRenderData(faceMeshResult)
//            glSurfaceView!!.requestRender()
        }

        // The runnable to start camera after the gl surface view is attached.
        // For video input source, videoInput.start() will be called when the video uri is available.

        this!!.post { startCamera() }


        // Updates the preview layout.
        val frameLayout =
            this// findViewById<FrameLayout>(com.nuuz.facemesh.R.id.preview_display_layout)

        frameLayout.removeAllViewsInLayout()
//        frameLayout.addView(glSurfaceView)
        if(!::subview.isInitialized ) {
            imageView= OverlayView(frameLayout.context,null) //ImageView(frameLayout.context)

            frameLayout.addView(imageView)
            subview = FrameLayout(frameLayout.context)
            frameLayout.addView(subview)

        }
//        glSurfaceView!!.alpha=0F
//        glSurfaceView!!.visibility = View.VISIBLE
//        glSurfaceView!!.invalidate()
//        glSurfaceView!!.bringToFront()
        frameLayout.requestLayout()
    }

//    private fun logNoseLandmark(faceMeshResult: FaceMeshResult, height: Int, width: Int) {
//        activeCare?.logNoseLandmark(faceMeshResult, height,width, subview, glSurfaceView,localMatrix)
//    }

    fun addRow() {
        activeCare?.addRow()
    }
    var is3mm=false
    var cameraProvider: ProcessCameraProvider?=null
    private  var backgroundExecutor: ExecutorService= Executors.newSingleThreadExecutor()
    @SuppressLint("RestrictedApi")
    private fun startCamera() {
        isRun.set(true)
        val cameraProviderFuture = ProcessCameraProvider.getInstance(this.context)

        cameraProviderFuture.addListener({
            // Used to bind the lifecycle of cameras to the lifecycle owner
            cameraProvider= cameraProviderFuture.get()

            // Preview
//            val preview = Preview.Builder()
////                .setTargetAspectRatio(AspectRatio.RATIO_4_3)
//               .setTargetRotation(this.display.rotation)
//                .build()
//                .also {
//                    it.setSurfaceProvider(glSurfaceView?.surfaceProvider)
//                }
//            val builder = ImageCapture.Builder()
//            val previewHeight = preview.attachedSurfaceResolution?.height ?: 0
//            val previewWidth = preview.attachedSurfaceResolution?.width ?: 0
//
//            builder.setDefaultResolution(Size(previewWidth, previewHeight))

            // Select back camera as a default
            val cameraSelector = CameraSelector.DEFAULT_FRONT_CAMERA
            val imageAnalysis = ImageAnalysis.Builder()
//                .setTargetAspectRatio(AspectRatio.RATIO_4_3)
                .setTargetRotation(this.display.rotation)
                .setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
                .setOutputImageFormat(ImageAnalysis.OUTPUT_IMAGE_FORMAT_RGBA_8888)
                .setTargetResolution(Size(1024, 768))
                .build().also {
                    it.setAnalyzer(backgroundExecutor) { image ->
                        detectFace(image)
                        image.close()
                    }
                }
            try {
                // Unbind use cases before rebinding
                cameraProvider?.unbindAll()

                // Bind use cases to camera
                cameraProvider?.bindToLifecycle(
                    this.context  as LifecycleOwner, cameraSelector, imageAnalysis)

            } catch(exc: Exception) {
                Log.e(TAG, "Use case binding failed", exc)
            }

        }, ContextCompat.getMainExecutor(this.context))
//        var width=320
//        var height=240
////        if(is3mm){
//            width=         glSurfaceView!!.width
//            height=         glSurfaceView!!.height
////        }
//        cameraInput!!.start(
//            this.context,
//            facemesh!!.glContext,
//            CameraInputFPS.CameraFacing.FRONT,
//            width,height
//
//        )
    }
    private lateinit var bitmapBuffer: Bitmap

    private var imageRotationDegrees: Int = 0
    fun getCorrectionMatrix(imageProxy: ImageProxy) : Matrix {
        val matrix = Matrix()
        // Rotate the frame received from the camera to be in the same direction as it'll be shown
        matrix.postRotate(imageProxy.imageInfo.rotationDegrees.toFloat())

        // flip image if user use front camera
//
        matrix.postScale(
            -1f,
            1f,
            imageProxy.width.toFloat()/2,
            imageProxy.height.toFloat()/2
        )


        return matrix
    }
    lateinit var  localMatrix:Matrix
    private val frameTimestamps = ArrayDeque<Long>(5)
    private val frameRateWindow = 8
    private  var rotatedBitmap:Bitmap?=null
    private fun detectFace(image: ImageProxy) {



        if (!::bitmapBuffer.isInitialized && image.image!=null) {
            // The image rotation and RGB image buffer are initialized only once
            // the analyzer has started running
            imageRotationDegrees = image.imageInfo.rotationDegrees
            bitmapBuffer = Bitmap.createBitmap(
                image.image!!.planes[0].getRowStride() / 4, image.height, Bitmap.Config.ARGB_8888)
            localMatrix=getCorrectionMatrix(image)
        }



//        Log.d(TAG,"input ${image.width}, ${image.height} rotate ${imageRotationDegrees}")
        // Copy out RGB bits to our shared buffer
        image.image?.let {
            // Copy out RGB bits to our shared buffer
            image.use { bitmapBuffer.copyPixelsFromBuffer(image.planes[0].buffer)  }
//            rotatedBitmap?.recycle()
            rotatedBitmap = Bitmap.createBitmap(
                bitmapBuffer, 0, 0, bitmapBuffer.width, bitmapBuffer.height,
                localMatrix, true
            )
//            imageView.post{
////
//                imageView.setImageBitmap(rotatedBitmap)}


//            yuvConvter.yuvToRgb(it, bitmapBuffer)
            // image.use { bitmapBuffer.copyPixelsFromBuffer(image.planes[0].buffer)  }
            try {
                if(isRun.get())
                    facemesh?.send(rotatedBitmap, System.currentTimeMillis())
            }catch (exc: Exception){

            }
        }

    }

    private fun stopCurrentPipeline() {
//        if (glSurfaceView != null) {
//            glSurfaceView!!.visibility = View.GONE
//        }
        isRun.set(false)
        cameraProvider?.unbindAll()
        cameraProvider?.shutdown()
        facemesh?.close()
        facemesh=null


    }

    override fun onResume(owner: LifecycleOwner) {
        // Restarts the camera and the opengl surface rendering.
//        glSurfaceView?.post { startCamera()
//            glSurfaceView?.setVisibility(View.VISIBLE)
//        }

    }

    override fun onPause(owner: LifecycleOwner) {
//        Log.d(TAG, "camera pause")
//        glSurfaceView?.visibility = View.GONE

    }

    private val region = mapOf(
//        "2mm forehead left horizontal" to ForeheadHorizontalGroup(),"2mm forehead left vertical" to ForeheadVerticalGroup(),
//        "2mm forehead right horizontal" to ForeheadRightHorizontalGroup(),"2mm forehead right vertical" to ForeheadRightVerticalGroup(),
//        "2mm left neck" to NeckLeftGroup(),"2mm right neck" to NeckRightGroup(),
//        "2mm left feet" to FeetLeftGroup(),"2mm right feet" to FeetRightGroup(),
//        "3mm Forehead" to ForeheadGroup3mm(),
//        "2mm Left Cheek A" to LeftCheekGroup(),
//        "2mm Right Cheek A" to RightCheekGroup(),
        "2mm Left Forehead Horizontal" to LeftForeheadHorizontalGroup2mm(),
        "2mm Right Forehead Horizontal" to RightForeheadHorizontalGroup2mm(),

        "2mm Left Neck" to LeftNeckGroup2mm(),
        "2mm Right Neck" to RightNeckGroup2mm(),
        "2mm Left Forehead Vertical" to LeftForeheadVerticalGroup2mm(),
        "2mm Right Forehead Vertical" to RightForeheadVerticalGroup2mm(),
        "2mm Left Feet" to LeftFeetGroup2mm(),
        "2mm Right Feet" to RightFeetGroup2mm(),
        "2mm Left Nasolabial" to LeftNasolabialFoldsGroup2mm(),
        "2mm Right Nasolabial" to RightNasolabialFoldsGroup2mm(),
//        "3mm Left Tear" to LeftTearGroup(),"3mm Right Tear" to RightTearGroup()
        "3mm Forehead" to ForeheadGroup3mm(),
        "3mm Left Nasolabial" to LeftNasolabialGroup3mm(),
        "3mm Right Nasolabial" to RightNasolabialGroup3mm(),
        "3mm Left Tear" to LeftTearGroup3mm(),
        "3mm Right Tear" to RightTearGroup3mm(),
        "3mm Left Feet Vertical" to LeftFeetVerticalGroup3mm(),
        "3mm Right Feet Vertical" to RightFeetVerticalGroup3mm(),
        "3mm Left Cheek A" to LeftCheekGroup3mm(),
        "3mm Right Cheek A" to RightCheekGroup3mm(),
        "3mm Left Cheek Horizontal" to LeftCheekHorizontalGroup3mm(),
        "3mm Right Cheek Horizontal" to RightCheekHorizontalGroup3mm(),
        "3mm Left Feet Horizontal" to LeftFeetHorizontalGroup3mm(),
        "3mm Right Feet Horizontal" to RightFeetHorizontalGroup3mm(),
    )
    private var activeCare: BaseGroupInterface? = LeftCheekGroup3mm()

    fun nextRow() {
        activeCare?.addRow()

    }
    var currentRegion=0
    fun nextRegion() {
        if((++currentRegion)>=region.size)currentRegion=0
        changeRegion(region.keys.elementAt(currentRegion),1,1)
    }
    fun changeRegion(key: String, range: Int, column: Int) {
        if (region.containsKey(key) && activeCare != region[key]) {
            activeCare?.close()
            activeCare = region[key]
            activeCare?.active()
        }
        activeCare?.changePosition (range,column)

    }

    //    private fun createPreviewImpl(context: Context): PreviewImpl {
//        val preview: PreviewImpl
//        if (Build.VERSION.SDK_INT >= 23) {
//            preview = SurfaceViewPreview(context, this)
//        } else {
//            preview = TextureViewPreview(context, this)
//        }
//        return preview
//    }
    //for flutter
    fun stop() {
        Log.d(TAG, "camera on pause")
//        glSurfaceView?.visibility = View.GONE


    }

    fun dispose() {
        Log.d("disposed","dispose in face view")
        stop()
        stopCurrentPipeline()

    }

    fun restart() {

        this?.post { startCamera()
//                glSurfaceView?.setVisibility(View.VISIBLE)
        }


    }
}