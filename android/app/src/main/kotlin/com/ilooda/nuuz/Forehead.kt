package com.ilooda.nuuz


import android.util.Log
import android.view.ViewGroup
import android.widget.FrameLayout
import com.airbnb.lottie.LottieAnimationView
import com.airbnb.lottie.LottieDrawable
import com.google.mediapipe.solutioncore.SolutionGlSurfaceView
import com.google.mediapipe.solutions.facemesh.FaceMeshResult
import android.view.View

import java.util.concurrent.atomic.AtomicBoolean
import kotlin.collections.ArrayList


abstract class CareInterface {
    abstract fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int>

    fun roate() {
//        if (countOfLandPoints == 0 && rotateAngleFinalInit != 0.0F) {
//            countOfLandPoints++
//            imgShark?.let { it.animate().rotationBy(rotateAngleFinalInit) }
//
//        }
    }

    fun logNoseLandmark(
        result: FaceMeshResult,
        showPixelValues: Boolean,
        layout: FrameLayout,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ) {
        if( imgShark==null) {

            imgShark = LottieAnimationView(layout.context)
            val size = 400
            layout.post {
                layout.addView(imgShark)
                imgShark?.layoutParams = FrameLayout.LayoutParams(
                    size, size
                )

                val param = imgShark!!.layoutParams as ViewGroup.MarginLayoutParams
                param.marginStart = 200// Random.nextInt(0, layout.width - 200)
                param.topMargin = 1300 //Random.nextInt(0, layout.height - 200)
                //  imgShark?.setBackgroundResource(R.drawable.ic_launcher_background)
                //(imgShark as LottieAnimationView)?.scaleType = ImageView.ScaleType.FIT_XY
                imgShark?.setAnimation(this.animatSource)

                // imgShark?.setAnimation(R.raw.shotlocationv1)

//                imgShark?.visibility = View.VISIBLE
                imgShark?.repeatCount = LottieDrawable.INFINITE
                imgShark?.playAnimation()
                imgShark?.bringToFront()

            }
        }




        if (result == null || result.multiFaceLandmarks().size == 0) return


        //Rotation angle calculatioin

        var diffY =
            result.multiFaceLandmarks()[0].landmarkList[266].y - result.multiFaceLandmarks()[0].landmarkList[36].y
        var diffX =
            result.multiFaceLandmarks()[0].landmarkList[266].x - result.multiFaceLandmarks()[0].landmarkList[36].x
        rotateAngleFinalInit =
            kotlin.math.atan(diffY.toFloat() / diffX.toFloat()) * 180F / kotlin.math.PI.toFloat()

        //Rotate animation with given angle


        // result.multiFaceLandmarks()[0].landmarkList.size

        // For Bitmaps, show the pixel values. For texture inputs, show the normalized coordinates.
        if (showPixelValues) {
            val width = result.inputBitmap().width
            val height = result.inputBitmap().height

        } else {





        }
    }
    var sizeY = (120).toInt()//(((maxY - minY)) * 400  / 0.3 ).toInt()
    var sizeX = (120).toInt()//(((maxX - minX)) * 400 / 0.4 ).toInt()
    fun updateView(
        layout: FrameLayout,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ) {
        if (imgShark != null) {
            if( animatChange.getAndSet(true)){
                imgShark?.setAnimation(this.animatSource)
            }
            val allLandmarkPoiunt = result.multiFaceLandmarks()[0].landmarkList
            var minX = glSurfaceView!!.width.toFloat()
            var maxX = 0.0.toFloat()
            var minY = glSurfaceView!!.height.toFloat()
            var maxY = 0.0.toFloat()

            for (i in allLandmarkPoiunt) {
                if (minX > i.x) {
                    minX = i.x
                }
                if (maxX < i.x) {
                    maxX = i.x
                }
                if (minY > i.y) {
                    minY = i.y
                }
                if (maxY < i.y) {
                    maxY = i.y
                }


            }

            var minXF = glSurfaceView!!.width.toFloat()
            var maxXF = 0.0.toFloat()
            var minYF = glSurfaceView!!.height.toFloat()
            var maxYF = 0.0.toFloat()
            var scaleForX = 1.0// (maxY - minY) /  (maxYInit  - minYInit)
            var scalForY = 1.0
            val layout1 = layout
            if (isFirstFrame) {

                minXF = minX
                minYF = minY
                maxXF = maxX
                maxYF = maxY
                minXInit = minX.toDouble()
                minYInit = minY.toDouble()
                maxXInit = maxX.toDouble()
                maxYInit = maxY.toDouble()

                isFirstFrame = false

            }
            // val sizeY = 120//(((maxY - minY)) * 400  / 0.3 ).toInt()
            //val sizeX = 120 //(((maxX - minX)) * 400 / 0.4 ).toInt()
            // sizeXAnim = 120
            //sizeYAnim = 120
            layout1.post {
                imgShark?.layoutParams = FrameLayout.LayoutParams(
                    sizeX, sizeY
                )


                val param1 = imgShark!!.layoutParams as ViewGroup.MarginLayoutParams



                scaleForX = (maxY - minY) / (maxYInit - minYInit)
                scalForY = (maxY - minY) / (maxYInit - minYInit)


                /* Log.i(
                     TAG, String.format(
                         "rotaion angles   (value range: [0, 1]): diffX=%f, diffY=%f",
                         rotateAngleFinal, rotateAngleFinalInit
                     )

                 )*/
                //Apply rotation
                imgShark!!.animate().rotation(rotateAngleFinalInit).setDuration(1)
                //Apply scaling
                imgShark!!.animate().scaleY((scaleForX.toFloat())).setDuration(1)
                imgShark!!.animate().scaleX((scalForY.toFloat())).setDuration(1)
                val (marginStartInit, marginTopInit) = calculateAnimPosition(
                    row,col,
                    result,glSurfaceView
                )



                imgShark?.layoutParams = FrameLayout.LayoutParams(
                    sizeX, sizeY
                )

//                    countOfAnimationRow = countOfAnimationRow + 1


                param1.marginStart = (((marginStartInit).toInt() + (param1.width))).toInt()
                param1.topMargin = (((marginTopInit).toInt() - (param1.height))).toInt()
                imgShark?.layoutParams = param1

            }
        }
//        layout.post {
//            imgShark?.layoutParams = FrameLayout.LayoutParams(
//                sizeX, sizeY
//            )
//            if (animatChange.getAndSet(false) ) {
//                imgShark?.setAnimation(animatSource)
//                //                imgShark?.visibility = View.VISIBLE
//                imgShark?.repeatCount = LottieDrawable.INFINITE
//                imgShark?.playAnimation()
//            }
//            //                    imgShark!!.animate().rotationBy(rotateAngleFinal + rotateAngleFinalInit)
//            val param1 = imgShark!!.layoutParams as ViewGroup.MarginLayoutParams
//            //                    if ((noseLandmark.x * glSurfaceView!!.height - glSurfaceView!!.height / 3 + indexForCountHoriz).toInt() >
//            //                        (noseLandmark1.x * glSurfaceView!!.height - glSurfaceView!!.height / 3).toInt()
//            //                    ) {
//            //                        indexForCount = 0;
//            //                        indexForCountHoriz = 0;
//            //                    }
//            //  param1.marginStart = (noseLandmark.x *glSurfaceView!!.height - glSurfaceView!!.height/3 + indexForCountHoriz ).toInt() //( noseLandmark.x *glSurfaceView!!.height - 700   ).toInt() // Random.nextInt(0, layout.width - 200)
//            //  param1.topMargin = (noseLandmark.y * glSurfaceView!!.height - indexForCount   ).toInt()
//            //                    val marginStartInit = 0
//            //                    val marginTopInit = 0
//            val (marginStartInit, marginTopInit) = calculateAnimPosition(
//                row,
//                col,
//                result, glSurfaceView
//            )
//            param1.marginStart = getStart(marginStartInit, param1)
//            param1.topMargin = getTop(marginTopInit, param1)
//
//            imgShark?.layoutParams = param1
//
//        }
    }

    open fun getStart(
        marginStartInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginStartInit).toInt() + ((param1.width)).toInt()

    open fun getTop(
        marginTopInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginTopInit).toInt() - (param1.height).toInt()

    fun setScale(x: Float, y: Float) {
        imgShark?.scaleX = (x)
        imgShark?.scaleY = (y)
    }

    fun close() {
        imgShark?.post {
            imgShark?.visibility = View.GONE
            imgShark?.parent?.let {
                (it as FrameLayout).removeView(imgShark)
            }


        }
    }

    fun active() {
        imgShark?.post {
            imgShark?.visibility = View.VISIBLE

        }
    }

    fun changeAnimatSource(animatSource: Int) {
        this.animatSource = animatSource
        animatChange.set(true)
    }


    var imgShark: LottieAnimationView? = null;

    var currentYPoint = 0
    var isFirstFrame = true
    var animatChange = AtomicBoolean(false)

    //    var indexForCount = 0
//    var indexForCountHoriz = 0
    var countOfLandPoints = 0
    var row = 1
    var col = 1
    var minXInit = 0.0
    var minYInit = 0.0
    var maxXInit = 0.0
    var maxYInit = 0.0
    var rotateAngleFinal = 0.0F
    var rotateAngleFinalInit = 0.0F
    var animatSource = R.raw.shotlocationv1
}

class LeftCheek : CareInterface {
    private val TAG = "LeftCheek"

    constructor() {
//        rotateAngleFinalInit = 20F
    }

    constructor(rowIndex: Int, colIndex: Int) {
        row = rowIndex
        col = colIndex
//        rotateAngleFinalInit = 20F
    }

    override fun getStart(
        marginStartInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginStartInit).toInt() + ((param1.width)).toInt()

    override fun getTop(
        marginTopInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (1.0 * marginTopInit).toInt() - param1.height

    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        var marginStartInit = 0
        var marginTopStartInit = 0
        var diffInX =
            (result.multiFaceLandmarks()[0].landmarkList[282].x - result.multiFaceLandmarks()[0].landmarkList[52].x) / 3.5
        if (colIndex == 1) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[149].y - result.multiFaceLandmarks()[0].landmarkList[203].y) / 9
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[149].y * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].y - diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].y - 2 * diffInY) * glSurfaceView!!.height).toInt()
            }

            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].y - 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].y - 4 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].y - 5 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].y - 6 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].y - 7 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].y - 8 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 10) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[149].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[203].y * glSurfaceView!!.height).toInt()
            }


        }
        if (colIndex == 2) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[150].y - result.multiFaceLandmarks()[0].landmarkList[36].y) / 9
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[150].y * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].y - diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].y - 2 * diffInY) * glSurfaceView!!.height).toInt()
            }

            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].y - 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].y - 4 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].y - 5 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].y - 6 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].y - 7 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].y - 8 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 10) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[150].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[36].y * glSurfaceView!!.height).toInt()
            }
        }
        if (colIndex == 3) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[136].y - result.multiFaceLandmarks()[0].landmarkList[101].y) / 9
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[136].y * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].y - diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].y - 2 * diffInY) * glSurfaceView!!.height).toInt()
            }

            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].y - 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].y - 4 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].y - 5 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].y - 6 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].y - 7 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].y - 8 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 10) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[136].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[101].y * glSurfaceView!!.height).toInt()
            }

        }
        if (colIndex == 4) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[172].y - result.multiFaceLandmarks()[0].landmarkList[119].y) / 9
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[172].y * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].y - diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].y - 2 * diffInY) * glSurfaceView!!.height).toInt()
            }

            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].y - 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].y - 4 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].y - 5 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].y - 6 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].y - 7 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].y - 8 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 10) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[172].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[119].y * glSurfaceView!!.height).toInt()
            }

        }

        return Pair(marginStartInit, marginTopStartInit)
    }

//    override fun roate() {
//        if ( countOfLandPoints == 0 ){
//            imgShark!!.animate().rotationBy(20F)
//
//        }
//        countOfLandPoints = 1
//    }

}

class RightCheek : CareInterface {
    private val TAG = "RightCheek"

    constructor() {
//        rotateAngleFinalInit = -20F
    }

    constructor(rowIndex: Int, colIndex: Int) {
        row = rowIndex
        col = colIndex
//        rotateAngleFinalInit = -20F
    }

    override fun getStart(
        marginStartInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginStartInit).toInt() + ((param1.width)).toInt()

    override fun getTop(
        marginTopInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (1.0 * marginTopInit).toInt() - param1.height

    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        var marginStartInit = 0
        var marginTopStartInit = 0
        var diffInX =
            (result.multiFaceLandmarks()[0].landmarkList[282].x - result.multiFaceLandmarks()[0].landmarkList[52].x) / 3
        if (colIndex == 1) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[378].y - result.multiFaceLandmarks()[0].landmarkList[423].y) / 9
            if (rowIndex == 1) {

                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[378].y * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].y - diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].y - 2 * diffInY) * glSurfaceView!!.height).toInt()
            }

            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].y - 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].y - 4 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].y - 5 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].y - 6 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].y - 7 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].y - 8 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 10) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[378].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[423].y * glSurfaceView!!.height).toInt()
            }


        }
        if (colIndex == 2) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[379].y - result.multiFaceLandmarks()[0].landmarkList[266].y) / 9
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[379].y * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].y - diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].y - 2 * diffInY) * glSurfaceView!!.height).toInt()
            }

            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].y - 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].y - 4 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].y - 5 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].y - 6 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].y - 7 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].y - 8 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 10) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[379].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[266].y * glSurfaceView!!.height).toInt()
            }
        }
        if (colIndex == 3) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[365].y - result.multiFaceLandmarks()[0].landmarkList[330].y) / 9
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[365].y * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].y - diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].y - 2 * diffInY) * glSurfaceView!!.height).toInt()
            }

            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].y - 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].y - 4 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].y - 5 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].y - 6 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].y - 7 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].y - 8 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 10) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[365].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[330].y * glSurfaceView!!.height).toInt()
            }

        }
        if (colIndex == 4) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[397].y - result.multiFaceLandmarks()[0].landmarkList[348].y) / 9
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[397].y * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].y - diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].y - 2 * diffInY) * glSurfaceView!!.height).toInt()
            }

            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].y - 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].y - 4 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].y - 5 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].y - 6 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].y - 7 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].y - 8 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 10) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[397].x + diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[348].y * glSurfaceView!!.height).toInt()
            }

        }




        return Pair(marginStartInit, marginTopStartInit)
    }

//    override fun roate() {
//        if (countOfLandPoints == 0) {
//            imgShark!!.animate().rotationBy(-20F)
//
//        }
//        countOfLandPoints = 1
//    }

}

class BeforeProcess : Forehead {
    constructor(x: Int, y: Int) {
        row = x
        col = y
        animatSource = R.raw.beforeprocessv1
    }
}

class DoneProcess : Forehead {
    constructor(x: Int, y: Int) {
        row = x
        col = y
        animatSource = R.raw.donev1
    }

}

abstract class GroupInterface {
    var row = 1
    var col = 1
    var lastx = 1.0F
    var lasty = 1.0F
    var last_col = 1
    val isUpdate = AtomicBoolean(false)
    var rows = listOf(5, 10, 5)
    var careItems = ArrayList<CareInterface>()
    open fun close() {
        careItems.clear()
    }

    fun addRow() {
        changePosition(row + 1, col)
    }

    abstract fun changePosition(rowIndex: Int, colIndex: Int)
    open fun active() {
//        layout.removeAllViews()
//         careItems.clear()
    }

    open fun logNoseLandmark(
        result: FaceMeshResult,
        showPixelValues: Boolean,
        layout: FrameLayout,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ) {
        if (isUpdate.get() || result.multiFaceLandmarks().isEmpty()) return
        val th = 0.01
        //stop shake
        if ((result.multiFaceLandmarks()[0].landmarkList[0].x - lastx) * (result.multiFaceLandmarks()[0].landmarkList[0].x - lastx) + (result.multiFaceLandmarks()[0].landmarkList[0].y - lasty) * (result.multiFaceLandmarks()[0].landmarkList[0].y - lasty) < th * th) return
        isUpdate.set(true)
        try {
            lastx = result.multiFaceLandmarks()[0].landmarkList[0].x
            lasty = result.multiFaceLandmarks()[0].landmarkList[0].y
            layout.post {
                if (careItems.isEmpty()) layout.removeAllViews()
                var changerow = careItems.isEmpty()
                if (last_col != col) {
                    Log.d("group", "Move col")
                    layout.removeAllViews()
                    careItems.clear()
                    changerow = true

                }

                for (j in 0 until rows[col - 1]) {
                    val currentRow = j + 1
                    val currentCol = col
                    var current: CareInterface? = null
                    current = if (currentRow == row) {
                        createShot(currentRow, currentCol)
                    } else
                        if (currentRow < row) {
//                        Log.d("group", "done $currentRow")
                            createDone(currentRow, currentCol)
                        } else
                            createBefore(currentRow, currentCol)

                    if (changerow) careItems.add(current)
                    else {
                        if (careItems[j].animatSource != current.animatSource) {
                            Log.d("change group", "${j},${col}")
                            careItems[j].changeAnimatSource(current.animatSource)

                        }
                    }
                    //  Log.d("group","${row},${col}")
                    careItems[j].logNoseLandmark(result, showPixelValues, layout, glSurfaceView)
                }

                for (item in careItems) {
                    item.updateView(layout, result, glSurfaceView)
                }
                last_col = col
            }

//                Log.d("group","updated")
        } finally {
            isUpdate.set(false)
        }


    }

    open fun createShot(currentRow: Int, currentCol: Int): CareInterface {
        return Forehead(currentRow, currentCol)
    }

    open fun createDone(currentRow: Int, currentCol: Int): CareInterface {
        return DoneProcess(currentRow, currentCol)
    }

    open fun createBefore(currentRow: Int, currentCol: Int): CareInterface {
        return BeforeProcess(currentRow, currentCol)
    }
}

class ForeheadGroup : GroupInterface {
    constructor() {
        rows = listOf(5, 10, 10, 10, 10, 10, 10, 5)
    }

    override fun changePosition(rowIndex: Int, colIndex: Int) {
        var testrow = rowIndex
        var testcol = colIndex
        if (testcol == 1 || testcol == 8) {
            if (testrow > 5) {
                testcol++;
                testrow = 1;
            }
        } else if (testrow > 10) {
            testcol++;
            testrow = 1;
        }

        if (testcol > 8) testcol = 1;
        col = testcol
        row = testrow
        lastx = 1.0F
        lasty = 1.0F
    }
}

class LeftCheekGroup : GroupInterface {
    constructor() {
        rows = listOf(10, 10, 10, 10)
    }

    override fun changePosition(rowIndex: Int, colIndex: Int) {
        var testrow = rowIndex
        var testcol = colIndex
        if (testrow > 10) {
            testcol++;
            testrow = 1;
        }

        if (testcol > 4) testcol = 1;
        col = testcol
        row = testrow
        lastx = 1.0F
        lasty = 1.0F
    }

    override fun createShot(currentRow: Int, currentCol: Int): CareInterface {
        return LeftCheek(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): CareInterface {
        val f = LeftCheek(currentRow, currentCol)
        f.animatSource = R.raw.donev1
        return f

    }

    override fun createBefore(currentRow: Int, currentCol: Int): CareInterface {

        val f = LeftCheek(currentRow, currentCol)
        f.animatSource = R.raw.beforeprocessv1
        return f
    }
}

class RightCheekGroup : GroupInterface {
    constructor() {
        rows = listOf(10, 10, 10, 10)
    }

    override fun changePosition(rowIndex: Int, colIndex: Int) {
        var testrow = rowIndex
        var testcol = colIndex
        if (testrow > 10) {
            testcol++;
            testrow = 1;
        }

        if (testcol > 4) testcol = 1;
        col = testcol
        row = testrow
        lastx = 1.0F
        lasty = 1.0F
    }

    override fun createShot(currentRow: Int, currentCol: Int): CareInterface {
        return RightCheek(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): CareInterface {
        val f = RightCheek(currentRow, currentCol)
        f.animatSource = R.raw.donev1
        return f

    }

    override fun createBefore(currentRow: Int, currentCol: Int): CareInterface {

        val f = RightCheek(currentRow, currentCol)
        f.animatSource = R.raw.beforeprocessv1
        return f
    }
}

class LeftNasolabialGroup : GroupInterface {
    constructor() {
        rows = listOf(3, 3, 3, 3, 3)
    }

    override fun changePosition(rowIndex: Int, colIndex: Int) {
        var testrow = rowIndex
        var testcol = colIndex
        if (testrow > 3) {
            testcol++;
            testrow = 1;
        }

        if (testcol > 5) testcol = 1;
        col = testcol
        row = testrow
        lastx = 1.0F
        lasty = 1.0F
    }

    override fun createShot(currentRow: Int, currentCol: Int): CareInterface {
        return LeftNasolabial(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): CareInterface {
        val f = LeftNasolabial(currentRow, currentCol)
        f.animatSource = R.raw.donev1
        return f

    }

    override fun createBefore(currentRow: Int, currentCol: Int): CareInterface {

        val f = LeftNasolabial(currentRow, currentCol)
        f.animatSource = R.raw.beforeprocessv1
        return f
    }
}

class RightNasolabialGroup : GroupInterface {
    constructor() {
        rows = listOf(3, 3, 3, 3, 3)
    }

    override fun changePosition(rowIndex: Int, colIndex: Int) {
        var testrow = rowIndex
        var testcol = colIndex
        if (testrow > 3) {
            testcol++;
            testrow = 1;
        }

        if (testcol > 5) testcol = 1;
        col = testcol
        row = testrow
        lastx = 1.0F
        lasty = 1.0F
    }

    override fun createShot(currentRow: Int, currentCol: Int): CareInterface {
        return RightNasolabial(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): CareInterface {
        val f = RightNasolabial(currentRow, currentCol)
        f.animatSource = R.raw.donev1
        return f

    }

    override fun createBefore(currentRow: Int, currentCol: Int): CareInterface {

        val f = RightNasolabial(currentRow, currentCol)
        f.animatSource = R.raw.beforeprocessv1
        return f
    }
}

class LeftTearGroup : GroupInterface {
    constructor() {
        rows = listOf(1, 1, 1, 1, 1, 1, 1, 1)
    }

    override fun changePosition(rowIndex: Int, colIndex: Int) {
        var testrow = rowIndex
        var testcol = colIndex
        if (testrow > 1) {
            testcol++;
            testrow = 1;
        }

        if (testcol > 8) testcol = 1;
        col = testcol
        row = testrow
        lastx = 1.0F
        lasty = 1.0F
    }

    override fun createShot(currentRow: Int, currentCol: Int): CareInterface {
        return LeftTear(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): CareInterface {
        val f = LeftTear(currentRow, currentCol)
        f.animatSource = R.raw.donev1
        return f

    }

    override fun createBefore(currentRow: Int, currentCol: Int): CareInterface {

        val f = LeftTear(currentRow, currentCol)
        f.animatSource = R.raw.beforeprocessv1
        return f
    }
}

class RightTearGroup : GroupInterface {
    constructor() {
        rows = listOf(1, 1, 1, 1, 1, 1, 1, 1)
    }

    override fun changePosition(rowIndex: Int, colIndex: Int) {
        var testrow = rowIndex
        var testcol = colIndex
        if (testrow > 1) {
            testcol++;
            testrow = 1;
        }

        if (testcol > 8) testcol = 1;
        col = testcol
        row = testrow
        lastx = 1.0F
        lasty = 1.0F
    }

    override fun createShot(currentRow: Int, currentCol: Int): CareInterface {
        return RightTear(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): CareInterface {
        val f = RightTear(currentRow, currentCol)
        f.animatSource = R.raw.donev1
        return f

    }

    override fun createBefore(currentRow: Int, currentCol: Int): CareInterface {

        val f = RightTear(currentRow, currentCol)
        f.animatSource = R.raw.beforeprocessv1
        return f
    }
}

open class Forehead : CareInterface {
    constructor() {

    }

    constructor(x: Int, y: Int) {
        row = x
        col = y
    }

    private val TAG = "Forehead"


    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        var marginStartInit = 0
        var marginTopStartInit = 0
        var diffInX =
            (result.multiFaceLandmarks()[0].landmarkList[282].x - result.multiFaceLandmarks()[0].landmarkList[52].x) / 7

        if (colIndex == 1) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[224].y - result.multiFaceLandmarks()[0].landmarkList[103].y) / 4
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[223].x + 1.2 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[103].y) * glSurfaceView!!.height).toInt()

            }
            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[223].x + 1.2 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[103].y + diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[223].x + 1.2 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[103].y + 2 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[223].x + 1.2 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[103].y + 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[223].x + 1.2 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[224].y * glSurfaceView!!.height).toInt()
                //marginStartInit = ((result.multiFaceLandmarks()[0].landmarkList[223].x*glSurfaceView!!.height)).toInt()
                //marginTopStartInit = ((result.multiFaceLandmarks()[0].landmarkList[224].y*glSurfaceView!!.height)).toInt()
            }
            //marginStartInit = (result.multiFaceLandmarks()[0].landmarkList[8].x *glSurfaceView!!.height - glSurfaceView!!.height/2.6   ).toInt()
            //marginTopStartInit = (result.multiFaceLandmarks()[0].landmarkList[8].y * glSurfaceView!!.height  ).toInt()
        }
        if (colIndex == 2) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[222].y - result.multiFaceLandmarks()[0].landmarkList[67].y) / 9
            if (rowIndex == 10) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 1.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[67].y * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 1.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[67].y + diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 1.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[67].y + 2 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 1.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[67].y + 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 1.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[67].y + 4 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 1.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[67].y + 5 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 1.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[67].y + 6 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 1.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[67].y + 7 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 1.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[67].y + 8 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 1.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[222].y) * glSurfaceView!!.height).toInt()
            }


        }
        //Column 3
        if (colIndex == 3) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[221].y - result.multiFaceLandmarks()[0].landmarkList[109].y) / 9
            if (rowIndex == 10) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 2.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[109].y * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 2.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[109].y + diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 2.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[109].y + 2 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 2.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[109].y + 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 2.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[109].y + 4 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 2.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[109].y + 5 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 2.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[109].y + 6 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 2.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[109].y + 7 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 2.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[109].y + 8 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 2.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[221].y) * glSurfaceView!!.height).toInt()
            }


        }
        //Column 4
        if (colIndex == 4) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[168].y - result.multiFaceLandmarks()[0].landmarkList[10].y) / 9
            if (rowIndex == 10) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 3.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[10].y * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 3.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 3.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + 2 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 3.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 3.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + 4 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 3.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + 5 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 3.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + 6 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 3.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + 7 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 3.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + 8 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 3.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[168].y) * glSurfaceView!!.height).toInt()
            }


        }
        //Column 5
        if (colIndex == 5) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[168].y - result.multiFaceLandmarks()[0].landmarkList[10].y) / 9
            if (rowIndex == 10) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 4.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[10].y * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 4.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 4.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + 2 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 4.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 4.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + 4 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 4.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + 5 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 4.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + 6 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 4.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + 7 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 4.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[10].y + 8 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 4.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[168].y) * glSurfaceView!!.height).toInt()
            }


        }

        //Column 6
        if (colIndex == 6) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[441].y - result.multiFaceLandmarks()[0].landmarkList[338].y) / 9
            if (rowIndex == 10) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 5.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[338].y * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 5.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[338].y + diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 5.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[338].y + 2 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 5.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[338].y + 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 5.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[338].y + 4 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 5.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[338].y + 5 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 5.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[338].y + 6 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 5.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[338].y + 7 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 5.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[338].y + 8 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 5.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[441].y) * glSurfaceView!!.height).toInt()
            }


        }

        //Column 7
        if (colIndex == 7) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[443].y - result.multiFaceLandmarks()[0].landmarkList[297].y) / 9
            if (rowIndex == 10) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 6.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[297].y * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 6.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[297].y + diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 6.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[297].y + 2 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 6.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[297].y + 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 6.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[297].y + 4 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 6.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[297].y + 5 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 6.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[297].y + 6 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 6.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[297].y + 7 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 6.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[297].y + 8 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[52].x + 6.7 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[443].y) * glSurfaceView!!.height).toInt()
            }


        }

        if (colIndex == 8) {
            var diffInY =
                (result.multiFaceLandmarks()[0].landmarkList[444].y - result.multiFaceLandmarks()[0].landmarkList[332].y) / 4
            if (rowIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[282].x + 1.2 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[332].y * glSurfaceView!!.height).toInt()

            }
            if (rowIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[282].x + 1.2 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[332].y + diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[282].x + 1.2 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[332].y + 2 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[282].x + 1.2 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[332].y + 3 * diffInY) * glSurfaceView!!.height).toInt()
            }
            if (rowIndex == 1) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[282].x + +1.2 * diffInX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    (result.multiFaceLandmarks()[0].landmarkList[444].y * glSurfaceView!!.height).toInt()
            }

        }


        return Pair(marginStartInit, marginTopStartInit)
    }


}

open class LeftNasolabial : CareInterface {
    constructor() {
        sizeY = 120
        sizeX = 120

    }

    constructor(x: Int, y: Int) {
        row = x
        col = y
        sizeY = 120
        sizeX = 120
    }

    private val TAG = "LeftNasolabials"


    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        var marginStartInit = 0
        var marginTopStartInit = 0
        var diffInY =
            (result.multiFaceLandmarks()[0].landmarkList[98].y - result.multiFaceLandmarks()[0].landmarkList[100].y) / 4
        var diffInX =
            (result.multiFaceLandmarks()[0].landmarkList[2].x - result.multiFaceLandmarks()[0].landmarkList[100].x) / 4
        if (rowIndex == 1) {

            if (colIndex == 1) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[97].x) - diffInX / 10) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[98].y - 0.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 2) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[97].x) - diffInX / 5) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[98].y - 1 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 3) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[97].x) - diffInX / 1) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[98].y - 1.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
        }

        if (rowIndex == 2) {

            if (colIndex == 1) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[98].x) - diffInX / 10) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[92].y - 0.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 2) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[98].x) - diffInX / 5) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[92].y - 1.0 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 3) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[98].x) - diffInX / 1) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[92].y - 1.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
        }
        if (rowIndex == 3) {

            if (colIndex == 1) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[203].x) - diffInX / 10) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[91].y - 0.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 2) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[203].x) - diffInX / 5) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[91].y - 1.0 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 3) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[203].x) - diffInX / 1) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[91].y - 1.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
        }
        if (rowIndex == 4) {

            if (colIndex == 1) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[36].x) - diffInX / 10) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[204].y - 0.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 2) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[36].x) - diffInX / 5) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[204].y - 1.0 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 3) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[36].x) - diffInX / 1) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[204].y - 1.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
        }

        if (rowIndex == 5) {

            if (colIndex == 1) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[36].x) + diffInX / 10) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[32].y + 0.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 2) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[36].x) + diffInX / 5) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[32].y + 1.0 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 3) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[36].x) + diffInX / 1) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[32].y + 1.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
        }


        val rotAngle = -65 + rotateAngleFinalInit
        imgShark!!.animate().rotation(rotAngle).setDuration(1)
        return Pair(marginStartInit, marginTopStartInit)
    }
}

open class RightNasolabial : CareInterface {
    constructor() {
        sizeY = 120
        sizeX = 120
    }

    constructor(x: Int, y: Int) {
        row = x
        col = y
        sizeY = 120
        sizeX = 120
    }

    private val TAG = "RightNasolabials"


    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        var marginStartInit = 0
        var marginTopStartInit = 0
        var diffInY =
            (result.multiFaceLandmarks()[0].landmarkList[98].y - result.multiFaceLandmarks()[0].landmarkList[100].y) / 4
        var diffInX =
            (result.multiFaceLandmarks()[0].landmarkList[2].x - result.multiFaceLandmarks()[0].landmarkList[100].x) / 4
        if (rowIndex == 1) {

            if (colIndex == 1) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[427].x) + diffInX / 10) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[327].y - 0.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 2) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[427].x) + diffInX / 5) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[327].y - 1 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 3) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[427].x) + diffInX / 1) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[327].y - 1.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
        }

        if (rowIndex == 2) {

            if (colIndex == 1) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[280].x) + diffInX / 10) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[322].y - 0.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 2) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[280].x) + diffInX / 5) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[322].y - 1.0 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 3) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[280].x) + diffInX / 1) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[322].y - 1.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
        }
        if (rowIndex == 3) {

            if (colIndex == 1) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[411].x) + diffInX / 10) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[321].y - 0.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 2) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[411].x) + diffInX / 5) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[321].y - 1.0 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 3) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[411].x) + diffInX / 1) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[321].y - 1.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
        }
        if (rowIndex == 4) {

            if (colIndex == 1) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[433].x) + diffInX / 10) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[424].y - 0.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 2) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[433].x) + diffInX / 5) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[424].y - 1.0 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 3) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[433].x) + diffInX / 1) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[424].y - 1.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
        }

        if (rowIndex == 5) {

            if (colIndex == 1) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[433].x) - diffInX / 10) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[262].y + 0.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 2) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[433].x) - diffInX / 5) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[262].y + 1.0 * diffInY) * glSurfaceView!!.height).toInt()

            }
            if (colIndex == 3) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[433].x) - diffInX / 1) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[262].y + 1.5 * diffInY) * glSurfaceView!!.height).toInt()

            }
        }


        val rotAngle = 65 + rotateAngleFinalInit
        imgShark!!.animate().rotation(rotAngle).setDuration(1)
        return Pair(marginStartInit, marginTopStartInit)
    }
}

open class LeftTear : CareInterface {
    constructor() {
        sizeY = 100
        sizeX = 100
    }

    constructor(x: Int, y: Int) {
        row = x
        col = y
        sizeY = 100
        sizeX = 100
    }

    private val TAG = "LeftTear"


    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        var marginStartInit = 0
        var marginTopStartInit = 0
        var diffX =
            (result.multiFaceLandmarks()[0].landmarkList[8].x - result.multiFaceLandmarks()[0].landmarkList[229].x) / 9
        var diffY =
            (result.multiFaceLandmarks()[0].landmarkList[8].y - result.multiFaceLandmarks()[0].landmarkList[229].y) / 9
        if (rowIndex == 1) {
            if (colIndex == 1) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[5].x)) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].y) * glSurfaceView!!.height).toInt()
                val rotAngle = 65 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)
            }
            if (colIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].x - 1.4 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].y - 1.0 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = 70 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }
            if (colIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].x - 1.6 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].y - 1.0 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = 75 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }
            if (colIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].x - 2.4 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].y - 1.2 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = 80 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }
            if (colIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].x - 3.2 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].y - 1.4 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = 93 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }
            if (colIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].x - 4 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].y - 1.6 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = 97 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }
            if (colIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].x - 4.4 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].y - 1.8 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = 97 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }
            if (colIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].x - 4.7 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].y - 1.9 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = 100 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }

            if (colIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].x - 5 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[5].y - 2.1 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = 105 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }

            if (colIndex == 10) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[229].x)) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[229].y) * glSurfaceView!!.height).toInt()
                val rotAngle = -220 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }
        }
        return Pair(marginStartInit, marginTopStartInit)
    }
}

open class RightTear : CareInterface {
    constructor() {
        sizeY = 100
        sizeX = 100
    }

    constructor(x: Int, y: Int) {
        row = x
        col = y
        sizeY = 100
        sizeX = 100
    }

    private val TAG = "RightTear"


    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        var marginStartInit = 0
        var marginTopStartInit = 0
        var diffX =
            (result.multiFaceLandmarks()[0].landmarkList[8].x - result.multiFaceLandmarks()[0].landmarkList[149].x) / 9
        var diffY =
            (result.multiFaceLandmarks()[0].landmarkList[8].y - result.multiFaceLandmarks()[0].landmarkList[149].y) / 9
        if (rowIndex == 1) {
            if (colIndex == 1) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[266].x + 3.5 * diffX)) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].y + 0.1 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = -250 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)
            }
            if (colIndex == 2) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].x + 4.5 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].y + 0.2 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = -265 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }
            if (colIndex == 3) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].x + 5.5 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].y + 0.3 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = -267 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }
            if (colIndex == 4) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].x + 6.5 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].y + 0.4 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = -270 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }
            if (colIndex == 5) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].x + 7.5 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].y + 0.5 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = -275 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }
            if (colIndex == 6) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].x + 8.5 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].y + 0.6 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = -280 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }
            if (colIndex == 7) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].x + 9.5 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].y + 0.7 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = -290 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }
            if (colIndex == 8) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].x + 10.5 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].y + 0.8 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = -295 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }

            if (colIndex == 9) {
                marginStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].x + 811.5 * diffX) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].y + 0.9 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = -300 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }

            if (colIndex == 10) {
                marginStartInit =
                    (((result.multiFaceLandmarks()[0].landmarkList[266].x + 12.5 * diffX)) * glSurfaceView!!.height - glSurfaceView!!.height / 2.6).toInt()
                marginTopStartInit =
                    ((result.multiFaceLandmarks()[0].landmarkList[266].y + 1 * diffY) * glSurfaceView!!.height).toInt()
                val rotAngle = -305 + rotateAngleFinalInit
                imgShark!!.animate().rotation(rotAngle).setDuration(1)

            }
        }


        return Pair(marginStartInit, marginTopStartInit)
    }
}