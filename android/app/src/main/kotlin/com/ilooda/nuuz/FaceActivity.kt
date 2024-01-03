package com.ilooda.nuuz

// ContentResolver dependency
import android.graphics.Bitmap
import android.graphics.Matrix
import android.os.Bundle
import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.exifinterface.media.ExifInterface
import com.airbnb.lottie.LottieAnimationView
import com.airbnb.lottie.LottieDrawable
import com.google.mediapipe.framework.TextureFrame
import com.google.mediapipe.solutioncore.CameraInput
import com.google.mediapipe.solutioncore.CameraInputFPS
import com.google.mediapipe.solutioncore.SolutionGlSurfaceView
import com.google.mediapipe.solutions.facemesh.FaceMesh
import com.google.mediapipe.solutions.facemesh.FaceMeshOptions
import com.google.mediapipe.solutions.facemesh.FaceMeshResult
import java.io.IOException
import java.io.InputStream
import java.util.concurrent.atomic.AtomicInteger
import java.util.concurrent.atomic.AtomicLong
import kotlin.random.Random


/** Main activity of MediaPipe Face Mesh app.  */
class FaceActivity : AppCompatActivity() {
    private var facemesh: FaceMesh? = null

    private enum class InputSource {
        UNKNOWN,  CAMERA
    }

    private var inputSource = InputSource.UNKNOWN




    // Live camera demo UI and camera components.
    private var cameraInput: CameraInputFPS? = null
    private var glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>? = null
    private var face=CameraInputFPS.CameraFacing.FRONT
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_face)
        setupLiveDemoUiComponents()
        findViewById<FrameLayout>(R.id.preview_display_layout).setOnClickListener({if (face==CameraInputFPS.CameraFacing.FRONT)
            face=CameraInputFPS.CameraFacing.BACK else face=CameraInputFPS.CameraFacing.FRONT

            stopCurrentPipeline()
            setupStreamingModePipeline(InputSource.CAMERA)

        })
    }

    override fun onResume() {
        super.onResume()

        // Restarts the camera and the opengl surface rendering.
        cameraInput = CameraInputFPS(this)
        cameraInput!!.setNewFrameListener { textureFrame: TextureFrame? ->
            facemesh!!.send(
                textureFrame
            )
        }
        glSurfaceView!!.post { startCamera() }
        glSurfaceView!!.setVisibility(View.VISIBLE)

    }
    val frameCounter = AtomicInteger(0)
    val lastFpsTimestamp = AtomicLong(System.currentTimeMillis())
    private fun CountFPS(
        fpsView: TextView
    ) {
        // Compute the FPS of the entire pipeline
        val frameCount = 30
        if (frameCounter.incrementAndGet() % frameCount === 0) {
            frameCounter.set(0)
            val now = System.currentTimeMillis()
            val delta: Long = now - lastFpsTimestamp.get()
            val fps = (1000 * frameCount / delta).toFloat()
            fpsView.post {
                fpsView.text = String.format(
                    "Version %d, FPS: %.02f",
                    1,
                    fps
                )
            }
            Log.d(TAG, String.format("FPS: %.02f", fps))
            lastFpsTimestamp.set(now)
        }
    }

    override fun onPause() {
        super.onPause()

        glSurfaceView!!.visibility = View.GONE
        cameraInput!!.close()
        imgShark=null
        imgShark1=null
    }



    @Throws(IOException::class)
    private fun rotateBitmap(inputBitmap: Bitmap?, imageData: InputStream): Bitmap? {
        val orientation: Int = ExifInterface(imageData)
            .getAttributeInt(ExifInterface.TAG_ORIENTATION, ExifInterface.ORIENTATION_NORMAL)
        if (orientation == ExifInterface.ORIENTATION_NORMAL) {
            return inputBitmap
        }
        val matrix = Matrix()
        when (orientation) {
            ExifInterface.ORIENTATION_ROTATE_90 -> matrix.postRotate(90f)
            ExifInterface.ORIENTATION_ROTATE_180 -> matrix.postRotate(180f)
            ExifInterface.ORIENTATION_ROTATE_270 -> matrix.postRotate(270f)
            else -> matrix.postRotate(0f)
        }
        return Bitmap.createBitmap(
            inputBitmap!!, 0, 0, inputBitmap.width, inputBitmap.height, matrix, true
        )
    }


    /** Sets up the UI components for the live demo with camera input.  */
    private fun setupLiveDemoUiComponents() {
        stopCurrentPipeline()
        setupStreamingModePipeline(InputSource.CAMERA)
    }

    /** Sets up core workflow for streaming mode.  */
    private fun setupStreamingModePipeline(inputSource: InputSource) {
        this.inputSource = inputSource
        // Initializes a new MediaPipe Face Mesh solution instance in the streaming mode.
        facemesh = FaceMesh(
            this,
            FaceMeshOptions.builder()
                .setStaticImageMode(false)
                .setRefineLandmarks(true)
                .setRunOnGpu(RUN_ON_GPU)
                .build()
        )
        facemesh!!.setErrorListener { message: String, e: RuntimeException? ->
            Log.e(
                TAG,
                "MediaPipe Face Mesh error:$message"
            )
        }

        cameraInput = CameraInputFPS(this)
        cameraInput!!.setNewFrameListener { textureFrame: TextureFrame? ->
            facemesh!!.send(
                textureFrame
            )
        }

        val fpsView=findViewById<TextView>(R.id.fps)
        // Initializes a new Gl surface view with a user-defined FaceMeshResultGlRenderer.
        glSurfaceView = SolutionGlSurfaceView(this, facemesh!!.glContext, facemesh!!.glMajorVersion)
        glSurfaceView!!.setSolutionResultRenderer(FaceMeshResultGlRenderer())
        glSurfaceView!!.setRenderInputImage(true)
        facemesh!!.setResultListener { faceMeshResult: FaceMeshResult ->
            CountFPS(fpsView)
            logNoseLandmark(faceMeshResult,  /*showPixelValues=*/false)
            glSurfaceView!!.setRenderData(faceMeshResult)
            glSurfaceView!!.requestRender()
        }

        // The runnable to start camera after the gl surface view is attached.
        // For video input source, videoInput.start() will be called when the video uri is available.

        glSurfaceView!!.post { startCamera() }


        // Updates the preview layout.
        val frameLayout = findViewById<FrameLayout>(R.id.preview_display_layout)

        frameLayout.removeAllViewsInLayout()
        frameLayout.addView(glSurfaceView)
        glSurfaceView!!.visibility = View.VISIBLE
        frameLayout.requestLayout()
    }

    private fun startCamera() {
        cameraInput!!.start(
            this,
            facemesh!!.glContext,
            face,
            glSurfaceView!!.width,
            glSurfaceView!!.height
        )

    }

    private fun stopCurrentPipeline() {
        if (cameraInput != null) {
            cameraInput!!.setNewFrameListener(null)
            cameraInput!!.close()
        }

        if (glSurfaceView != null) {
            glSurfaceView!!.visibility = View.GONE
        }
        if (facemesh != null) {
            facemesh!!.close()
        }
        imgShark=null
        imgShark1=null
    }
    var  imgShark: LottieAnimationView? =null ;
    var  imgShark1: LottieAnimationView? =null ;
    var currentYPoint = 0
    var isFirstFrame = true
    var indexForCount = 100
    private fun logNoseLandmark(result: FaceMeshResult, showPixelValues: Boolean) {
        if( imgShark==null) {
            val layout = findViewById<FrameLayout>(R.id.preview_display_layout)
            imgShark = LottieAnimationView(this)
            val size = 400
            layout.post {
                layout.addView(imgShark)
                imgShark?.layoutParams = FrameLayout.LayoutParams(
                    size, size
                )
                val param = imgShark!!.layoutParams as ViewGroup.MarginLayoutParams
                param.marginStart = 200// Random.nextInt(0, layout.width - 200)
                param.topMargin = 1300 //Random.nextInt(0, layout.height - 200)
                imgShark?.layoutParams = param
                imgShark?.setAnimation(R.raw.shotlocationv1)
//                imgShark?.visibility = View.VISIBLE
                imgShark?.repeatCount = LottieDrawable.INFINITE
                imgShark?.playAnimation()

                imgShark?.bringToFront()
            }
        } else {


        }
        if( result==null || result.multiFaceLandmarks().size==0)return
        var noseLandmark = result.multiFaceLandmarks()[0].landmarkList[10]

        // var imageSizeWidth = result.inputBitmap().width
        // var imageSizeHeight = result.inputBitmap().height
        val countOfLandPoints =     result.multiFaceLandmarks()[0].landmarkList.size
        val allLandmarkPoiunt   = result.multiFaceLandmarks()[0].landmarkList
        // For Bitmaps, show the pixel values. For texture inputs, show the normalized coordinates.
        if (showPixelValues) {
            val width = result.inputBitmap().width
            val height = result.inputBitmap().height
            Log.i(
                TAG, String.format(
                    "MediaPipe Face Mesh nose coordinates (pixel values): x=%f, y=%f",
                    noseLandmark.x * width, noseLandmark.y * height
                )
            )
        } else {
            var minX = glSurfaceView!!.width.toFloat()
            var maxX = 0.0.toFloat()
            var minY = glSurfaceView!!.height.toFloat()
            var maxY = 0.0.toFloat()
            var minXF = glSurfaceView!!.width.toFloat()
            var maxXF = 0.0.toFloat()
            var minYF = glSurfaceView!!.height.toFloat()
            var maxYF = 0.0.toFloat()

            for (i in  allLandmarkPoiunt ) {
                if (minX > i.x){
                    minX = i.x
                }
                if (maxX < i.x){
                    maxX = i.x
                }
                if (minY > i.y){
                    minY = i.y
                }
                if (maxY < i.y){
                    maxY = i.y
                }


            }
            if (isFirstFrame) {
                minXF = minX
                minYF = minY
                maxXF = maxX
                maxYF = maxY
                isFirstFrame = false
            }
            if( imgShark1==null) {
                val layout1 = findViewById<FrameLayout>(R.id.preview_display_layout)
                //noseLandmark.x = (minX + maxX)/2
                // noseLandmark.y = (minY + maxY)/2
                val sizeY = (((maxY - minY)) * 400  / 0.3 ).toInt()
                val sizeX = (((maxX - minX)) * 400 / 0.4 ).toInt()
                layout1.post {
                    imgShark?.layoutParams = FrameLayout.LayoutParams(
                        sizeX, sizeY
                    )
                    val param1 = imgShark!!.layoutParams as ViewGroup.MarginLayoutParams

                    param1.marginStart = (noseLandmark.x *glSurfaceView!!.height - glSurfaceView!!.height/3 ).toInt() //( noseLandmark.x *glSurfaceView!!.height - 700   ).toInt() // Random.nextInt(0, layout.width - 200)
                    param1.topMargin = (noseLandmark.y * glSurfaceView!!.height   ).toInt()
                    /*if (currentYPoint == 0) {
                        currentYPoint =  ( noseLandmark.y *glSurfaceView!!.height).toInt() // -  400 ).toInt()
                        param1.topMargin = currentYPoint - 400
                    } else {
                        currentYPoint =  ( noseLandmark.y *glSurfaceView!!.height).toInt() // -  400 ).toInt()
                        param1.topMargin = currentYPoint - 400



                    }*/

                    // param1.leftMargin = (noseLandmark.x *glSurfaceView!!.height/10).toInt()
                    //param1.setMargins((noseLandmark.x *glSurfaceView!!.height).toInt(), (noseLandmark.x *glSurfaceView!!.height).toInt(), 1400,1400);
                    imgShark?.layoutParams = param1

                }
            }
            Log.i(
                TAG, String.format(
                    "MediaPipe Face Mesh nose normalized coordinates (value range: [0, 1]): x=%f, y=%f",
                    maxX - minX, maxXF - minXF
                )

            )
            // indexForCount = indexForCount + 10
            // val param = imgShark!!.layoutParams as ViewGroup.MarginLayoutParams
            //param.marginStart =  600 //(noseLandmark.x * 1088).roundToInt()
            //param.topMargin =  100 //+  indexForCount//(noseLandmark.y * 1088).roundToInt()
        }
    }


    companion object {
        private const val TAG = "MainActivity"

        // Run the pipeline and the model inference on GPU or CPU.
        private const val RUN_ON_GPU = true
    }
}