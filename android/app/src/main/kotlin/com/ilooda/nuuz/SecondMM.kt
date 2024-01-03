package com.ilooda.nuuz


import android.util.Log
import android.view.View
import android.view.ViewGroup
import android.widget.FrameLayout
import android.widget.ImageView
import com.airbnb.lottie.LottieAnimationView
import com.airbnb.lottie.LottieDrawable
import com.google.mediapipe.solutioncore.SolutionGlSurfaceView
import com.google.mediapipe.solutions.facemesh.FaceMeshResult
import java.util.concurrent.atomic.AtomicBoolean
import kotlin.math.sqrt

abstract class Care2mInterface {
    abstract fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,
        layout: FrameLayout,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int>

    fun roate() {
//        if (countOfLandPoints == 0) {
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
        if (result == null || result.multiFaceLandmarks().size == 0) return

            if (imgShark == null) {
                if (isImage){
                    imgShark = ImageView(layout.context)
                    (imgShark as ImageView)?.setImageResource(R.drawable.launch_background)
                }else {
                    imgShark = LottieAnimationView(layout.context)

                    (imgShark as LottieAnimationView)?.scaleType = ImageView.ScaleType.FIT_XY


                    (imgShark as LottieAnimationView)?.setAnimation(animatSource)

                    imgShark?.visibility = View.GONE
                    if(hasBack)
                        (imgShark as LottieAnimationView)?.setBackgroundResource(R.drawable.launch_background)
                    (imgShark as LottieAnimationView)?.repeatCount = LottieDrawable.INFINITE
                    (imgShark as LottieAnimationView)?.playAnimation()
                }

                val size = 10
                layout.addView(imgShark)
////                imgShark?.setPivotX(0F);
////                imgShark?.setPivotY(0F);
                imgShark?.layoutParams = FrameLayout.LayoutParams(
                    size, size
                )
//                val param = imgShark!!.layoutParams as ViewGroup.MarginLayoutParams
//                param.marginStart = 200// Random.nextInt(0, layout.width - 200)
//                param.topMargin = 1300 //Random.nextInt(0, layout.height - 200)
//                imgShark?.layoutParams = param


            }

//        //index 109 left eye top
//        var noseLandmark = result.multiFaceLandmarks()[0].landmarkList[109]
//        var noseLandmark1 = result.multiFaceLandmarks()[0].landmarkList[332]
//        var noseLandmark2 = result.multiFaceLandmarks()[0].landmarkList[222]
//        var noseLandMarkLeft = result.multiFaceLandmarks()[0].landmarkList[103]
//        var noseLandMarkRight = result.multiFaceLandmarks()[0].landmarkList[332]


            // result.multiFaceLandmarks()[0].landmarkList.size
//        val allLandmarkPoiunt = result.multiFaceLandmarks()[0].landmarkList
            // For Bitmaps, show the pixel values. For texture inputs, show the normalized coordinates.
            imgShark?.let {

//                roate()
                //Rotation angle calculatioin

                var diffY =
                    result.multiFaceLandmarks()[0].landmarkList[1].y - result.multiFaceLandmarks()[0].landmarkList[0].y
                var diffX =
                    result.multiFaceLandmarks()[0].landmarkList[1].x - result.multiFaceLandmarks()[0].landmarkList[0].x
                rotateAngleFinal =
                    kotlin.math.atan2(diffY.toFloat() , diffX.toFloat()) * 180F / kotlin.math.PI.toFloat()
                if (result.multiFaceLandmarks()[0].landmarkList[10].y>0.1) {
                    diffY =
                        result.multiFaceLandmarks()[0].landmarkList[10].y - result.multiFaceLandmarks()[0].landmarkList[8].y
                    diffX =
                        result.multiFaceLandmarks()[0].landmarkList[10].x - result.multiFaceLandmarks()[0].landmarkList[8].x
                }else{
                    diffY =
                        result.multiFaceLandmarks()[0].landmarkList[16].y - result.multiFaceLandmarks()[0].landmarkList[17].y
                    diffX =
                        result.multiFaceLandmarks()[0].landmarkList[16].x - result.multiFaceLandmarks()[0].landmarkList[17].x
                }
                rotateAngleFinal +=
                    kotlin.math.atan2(diffY.toFloat() , diffX.toFloat()) * 180F / kotlin.math.PI.toFloat()
                rotateAngleFinal/=2
                Log.d("roated angle","$rotateAngleFinal")
                updateView(layout, result, glSurfaceView)





            }



    }

    var scaleForX = 1.0
    var scalForY = 1.0
    var viewHeight = 140//(((maxY - minY)) * 400  / 0.3 ).toInt()
    var viewWidth = 140//(((maxX - minX)) * 400 / 0.4 ).toInt()
    var enableRotate=true
    private fun updateView(
        layout: FrameLayout,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ) {

        imgShark?.layoutParams = FrameLayout.LayoutParams(
            viewWidth, viewHeight
        )

        if (animatChange.getAndSet(false)) {

            if( isImage){
                (imgShark as ImageView)?.setImageResource(R.drawable.launch_background)
            }else {

                (imgShark as LottieAnimationView)?.setBackgroundResource(R.drawable.launch_background)
                (imgShark as LottieAnimationView)?.setAnimation(animatSource)
                (imgShark as LottieAnimationView)?.scaleType = ImageView.ScaleType.FIT_XY
                imgShark?.visibility = View.VISIBLE
                (imgShark as LottieAnimationView)?.repeatCount = LottieDrawable.INFINITE
                (imgShark as LottieAnimationView)?.playAnimation()
            }
        }

        if(imgShark?.visibility == View.GONE) {
            imgShark?.visibility = View.VISIBLE
            imgShark?.bringToFront()
        }
        val param1 = imgShark!!.layoutParams as ViewGroup.MarginLayoutParams
        val (marginStartInit, marginTopInit) = calculateAnimPosition(
            row,
            col,layout,
            result, glSurfaceView
        )
        imgShark?.x= getStart(marginStartInit, param1).toFloat()
        imgShark?.y= getTop(marginTopInit, param1).toFloat()

//        param1.leftMargin = getStart(marginStartInit, param1)
//        param1.topMargin = getTop(marginTopInit, param1)
//
//        imgShark?.layoutParams = param1
        imgShark?.let {
            if (enableRotate) {

                it.rotation = (rotateAngleFinal + rotateAngleFinalInit + 90)
            }
        }
        Log.d("forhead", "${param1.marginStart}, ${param1.topMargin} ")
        Log.d("currentwidth and height", "${imgShark?.width}, ${param1?.height} ")
//        imgShark?.updateLayoutParams<ViewGroup.MarginLayoutParams> {
//                setMargins(marginStartInit, marginTopInit, 0, 0)
//            }

    }

    open abstract fun getStart(
        marginStartInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ):Int

    open abstract fun getTop(
        marginTopInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ):Int

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
        imgShark=null
    }
    var sizex= arrayOf(6,33)
    var sizey=arrayOf(23,223)
    fun getSize(
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ) {
        val max_size= glSurfaceView!!.height.coerceAtLeast(glSurfaceView!!.width)
        val x1 = result.multiFaceLandmarks()[0].landmarkList[sizex[0]].x
        val x2 = result.multiFaceLandmarks()[0].landmarkList[sizex[1]].x
        val y1 = result.multiFaceLandmarks()[0].landmarkList[sizex[0]].y
        val y2 = result.multiFaceLandmarks()[0].landmarkList[sizex[1]].y
        this.viewWidth =
            (sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)) * max_size).toInt()
        val x3 = result.multiFaceLandmarks()[0].landmarkList[sizey[0]].x
        val x4 = result.multiFaceLandmarks()[0].landmarkList[sizey[1]].x
        val y3 = result.multiFaceLandmarks()[0].landmarkList[sizey[0]].y
        val y4 = result.multiFaceLandmarks()[0].landmarkList[sizey[1]].y
        this.viewHeight =
            (sqrt((x3 - x4) * (x3 - x4) + (y3 - y4) * (y3 - y4)) * max_size).toInt()
    }
    fun changeAnimatSource(animatSource: Int) {
        this.animatSource = animatSource
        animatChange.set(true)
    }

    fun findTopLeft(
        layout: FrameLayout,
        result: FaceMeshResult,
        top: Int,
        left: Int
    ): Pair<Int, Int> {
        val cropDistance = (Math.max(layout!!.height, layout!!.width) - Math.min(
            layout!!.height,
            layout!!.width
        )) / 2
        var calWidth = 0
        var calHeight = 0
        if (layout!!.height > layout!!.width) {
            calWidth = cropDistance
        } else {
            calHeight = cropDistance
        }

        val imageSize = Math.max(layout!!.height, layout!!.width)
        var marginTopStartInit =
            (result.multiFaceLandmarks()[0].landmarkList[top].y * imageSize-calHeight ).toInt()
        var marginStartInit =
            ((result.multiFaceLandmarks()[0].landmarkList[left].x) * imageSize-calWidth).toInt()
        return Pair( marginStartInit,marginTopStartInit)
    }
    var imgShark: View? = null;

    var currentYPoint = 0
    var isFirstFrame = true
    var animatChange = AtomicBoolean(false)

    //    var indexForCount = 0
//    var indexForCountHoriz = 0
    var isImage=false

    var countOfLandPoints = 0
    var row = 1
    var col = 1
    var minXInit = 0.0
    var minYInit = 0.0
    var maxXInit = 0.0
    var maxYInit = 0.0
    var rotateAngleFinal = 0.0F
    var rotateAngleFinalInit = 0.0F
    var animatSource = R.raw.foreheadhorizontalleft
    var  hasBack=false
}
abstract class Care2mGroup: GroupInterface() {
    override fun changePosition(rowIndex: Int, colIndex: Int) {

    }
    override fun close(){
        currentItem?.close()
    }
    override fun active(){
        currentItem?.active()
    }
    override fun logNoseLandmark(
        result: FaceMeshResult,
        showPixelValues: Boolean,
        layout: FrameLayout,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ) {
        if (isUpdate.get() || result.multiFaceLandmarks().isEmpty()) return
        val th = 0.01
        //stop shake
//        if ((result.multiFaceLandmarks()[0].landmarkList[0].x - lastx) * (result.multiFaceLandmarks()[0].landmarkList[0].x - lastx) + (result.multiFaceLandmarks()[0].landmarkList[0].y - lasty) * (result.multiFaceLandmarks()[0].landmarkList[0].y - lasty) < th * th) return
        isUpdate.set(true)
        try {
            lastx = result.multiFaceLandmarks()[0].landmarkList[0].x
            lasty = result.multiFaceLandmarks()[0].landmarkList[0].y
            var firstRun=false
            if (currentItem==null){
                firstRun=true
                currentItem = createItem()
            }
            layout.post {
                if (firstRun) {
                    layout.removeAllViews()
                }

                currentItem?.logNoseLandmark( result,false,layout, glSurfaceView)

                last_col = col
            }

//                Log.d("group","updated")
        } finally {
            isUpdate.set(false)
        }
    }
    private var currentItem:Care2mInterface?=null
    abstract fun createItem(): Care2mInterface
}
class ForeheadHorizontalGroup:Care2mGroup(){
    override fun createItem(): Care2mInterface {
        return ForeheadLeftHorizontal()
    }

}
class ForeheadVerticalGroup:Care2mGroup(){
    override fun createItem(): Care2mInterface {
        return ForeheadLeftVertical()
    }

}
class ForeheadRightVerticalGroup:Care2mGroup(){
    override fun createItem(): Care2mInterface {
        return ForeheadRightVertical()
    }
}

class ForeheadRightHorizontalGroup:Care2mGroup(){
    override fun createItem(): Care2mInterface {
        return ForeheadRightHorizontal()
    }
}
class NeckLeftGroup:Care2mGroup(){
    override fun createItem(): Care2mInterface {
        return NeckLeft()
    }
}

class NeckRightGroup:Care2mGroup(){
    override fun createItem(): Care2mInterface {
        return NeckRight()
    }
}

class FoldsLeftGroup:Care2mGroup(){
    override fun createItem(): Care2mInterface {
        return FoldsLeft()
    }
}
class FoldsRightGroup:Care2mGroup(){
    override fun createItem(): Care2mInterface {
        return FoldsRight()
    }
}
class FeetLeftGroup:Care2mGroup(){
    override fun createItem(): Care2mInterface {
        return FeetLeft()
    }
}
class FeetRightGroup:Care2mGroup(){
    override fun createItem(): Care2mInterface {
        return FeetRight()
    }
}
open class ForeheadLeftHorizontal : Care2mInterface {
    constructor() : super() {
        this.animatSource = R.raw.foreheadhorizontalleft
        this.viewHeight=200
        this.viewWidth=200
//        this.hasBack=true
        sizex= arrayOf(6,33)
        sizey=arrayOf(23,223)

//        enableRotate=false
//        this.rotateAngleFinalInit=180f
    }

    override fun getStart(
        marginStartInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginStartInit-param1.width*0.2).toInt()

    override fun getTop(
        marginTopInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginTopInit-param1.height*1.2).toInt()

    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,

        layout: FrameLayout,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        var (marginStartInit,marginTopStartInit) = findTopLeft(layout, result, 63, 130)
        val rmarginTopStartInit=marginTopStartInit//-Math.abs(marginTopStartInit*0.1*Math.sin(Math.toRadians((rotateAngleFinal+90).toDouble()))).toInt()
        val rmarginStartInit=marginStartInit
        //+(marginStartInit*Math.sin(Math.toRadians((rotateAngleFinal+90).toDouble()))).toInt()
        Log.d("cos","="+Math.sin(Math.toRadians((rotateAngleFinal+90).toDouble())))
//        val r=Math.toRadians((rotateAngleFinal+rotateAngleFinalInit+90).toDouble())
//        val rmarginStartInit=-(marginStartInit*Math.cos(r)+marginTopStartInit*Math.sin(
//            r)
//        ).toInt()
//        val  rmarginTopStartInit=(marginStartInit*Math.sin(r)+marginTopStartInit*Math.cos(
//            r)).toInt()


        getSize(result, glSurfaceView)
        this.viewHeight=(this.viewHeight*1.1).toInt()
//        this.viewWidth=(this.viewWidth).toInt()
//        rmarginTopStartInit-=this.viewHeight
//        if(result.multiFaceLandmarks()[0].landmarkList[0].y>result.multiFaceLandmarks()[0].landmarkList[2].y){
//            rmarginTopStartInit-=this.viewHeight
//        }else{
//         //   rmarginTopStartInit+=this.viewHeight
//        }


//        Log.d("test","${result.multiFaceLandmarks()[0].landmarkList[6].x} abc")
//        Log.d("test","${result.multiFaceLandmarks()[0].landmarkList[33].y} def")
        Log.d("test", "$rmarginTopStartInit $rmarginStartInit rotate ${rotateAngleFinal+rotateAngleFinalInit+90} with $viewWidth,$viewHeight")
        Log.d("test", "${layout!!.height} ${layout!!.width} with ${glSurfaceView!!.height},${glSurfaceView!!.width}")
        this.scalForY = 1.0
        this.scaleForX = 1.0
        return Pair(rmarginStartInit, rmarginTopStartInit)
    }




}
class ForeheadLeftVertical:ForeheadLeftHorizontal{
    constructor() : super() {
        this.animatSource = R.raw.foreheadverticalleft
        this.viewHeight=200
        this.viewWidth=200
        sizex= arrayOf(8,293)
        sizey=arrayOf(9,10)
    }

    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,

        layout: FrameLayout,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        val (marginStartInit,marginTopStartInit) =findTopLeft(layout,result,66,105)
//        val marginTopStartInit =
//            (result.multiFaceLandmarks()[0].landmarkList[10].y * glSurfaceView!!.height).toInt()
//        val marginStartInit =( result.multiFaceLandmarks()[0].landmarkList[33].x*  glSurfaceView!!.width).roundToInt()
        getSize(result, glSurfaceView)
//        this.viewHeight =
//            ((result.multiFaceLandmarks()[0].landmarkList[8].y - result.multiFaceLandmarks()[0].landmarkList[10].y) * glSurfaceView!!.height).toInt()
//        this.viewWidth =
//            ((result.multiFaceLandmarks()[0].landmarkList[10].x - result.multiFaceLandmarks()[0].landmarkList[33].x) * glSurfaceView!!.width*1.10).toInt()
//        Log.d("test","${result.multiFaceLandmarks()[0].landmarkList[10].x} abc")
//        Log.d("test", "$marginTopStartInit $marginStartInit with $viewWidth,$viewHeight")
//        Log.d("test", "${layout!!.height} ${layout!!.width} with ${glSurfaceView!!.height},${glSurfaceView!!.width}")
        this.scalForY = 1.0
        this.scaleForX = 1.0
        return Pair(marginStartInit, marginTopStartInit)
    }
}

class ForeheadRightHorizontal:ForeheadLeftHorizontal{
    constructor() : super() {
        this.animatSource = R.raw.foreheadhorizontalright
        this.viewHeight=200
        this.viewWidth=200
        sizex= arrayOf(8,293)
        sizey=arrayOf(9,10)
//        this.rotateAngleFinalInit=180F
    }

    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,

        layout: FrameLayout,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        val (marginStartInit,marginTopStartInit) =findTopLeft(layout,result,296,441)
        getSize(result, glSurfaceView)
        Log.d("test","${result.multiFaceLandmarks()[0].landmarkList[10].x} abc")
        Log.d("test", "$marginTopStartInit $marginStartInit with $viewWidth,$viewHeight")
        Log.d("test", "${layout!!.height} ${layout!!.width} with ${glSurfaceView!!.height},${glSurfaceView!!.width}")
        this.scalForY = 1.0
        this.scaleForX = 1.0
        return Pair(marginStartInit, marginTopStartInit)
    }
    override fun getStart(
        marginStartInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginStartInit).toInt()
}
class ForeheadRightVertical:ForeheadLeftHorizontal{
    constructor() : super() {
        this.animatSource = R.raw.foreheadverticalright
        this.viewHeight=200
        this.viewWidth=200
        sizex= arrayOf(8,293)
        sizey=arrayOf(9,10)
//        this.hasBack=true
    }

    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,

        layout: FrameLayout,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        val (marginStartInit,marginTopStartInit) =findTopLeft(layout,result,296,441)
        getSize(result, glSurfaceView)
        Log.d("test","${result.multiFaceLandmarks()[0].landmarkList[10].x} abc")
        Log.d("test", "$marginTopStartInit $marginStartInit with $viewWidth,$viewHeight")
        Log.d("test", "${layout!!.height} ${layout!!.width} with ${glSurfaceView!!.height},${glSurfaceView!!.width}")
        this.scalForY = 1.0
        this.scaleForX = 1.0
        return Pair(marginStartInit, marginTopStartInit)
    }


}

class NeckLeft:ForeheadLeftHorizontal{
    constructor() : super() {
        this.animatSource = R.raw.neckverticalleft
        this.viewHeight=200
        this.viewWidth=200
        sizex= arrayOf(151,1)
        sizey=arrayOf(152,200)//172
//        this.hasBack=true
    }
    override fun getStart(
        marginStartInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginStartInit-param1.width).toInt()

    override fun getTop(
        marginTopInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginTopInit).toInt()
    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,

        layout: FrameLayout,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        val (marginStartInit,marginTopStartInit) =findTopLeft(layout,result,170,150)
        getSize(result, glSurfaceView)
        this.viewHeight*=2
//                this.viewHeight =
//            ((result.multiFaceLandmarks()[0].landmarkList[150].y - result.multiFaceLandmarks()[0].landmarkList[1].y) * glSurfaceView!!.height).toInt()
//        this.viewWidth =
//            ((result.multiFaceLandmarks()[0].landmarkList[152].x - result.multiFaceLandmarks()[0].landmarkList[172].x) * glSurfaceView!!.width).toInt()
        Log.d("test","${result.multiFaceLandmarks()[0].landmarkList[10].x} abc")
        Log.d("test", "$marginTopStartInit $marginStartInit with $viewWidth,$viewHeight")
        Log.d("test", "${layout!!.height} ${layout!!.width} with ${glSurfaceView!!.height},${glSurfaceView!!.width}")
        this.scalForY = 1.0
        this.scaleForX = 1.0
        return Pair(marginStartInit, marginTopStartInit)
    }
}

class NeckRight:ForeheadLeftHorizontal{
    constructor() : super() {
        this.animatSource = R.raw.neckverticalright
        this.viewHeight=200
        this.viewWidth=200
        sizex= arrayOf(151,1)
        sizey=arrayOf(152,200)//379

//        this.hasBack=true
    }
    override fun getStart(
        marginStartInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginStartInit).toInt()

    override fun getTop(
        marginTopInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginTopInit).toInt()
    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,
        layout: FrameLayout,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        val (marginStartInit,marginTopStartInit) =findTopLeft(layout,result,395,379)
        getSize(result, glSurfaceView)
        this.viewHeight*=2
//        this.viewHeight =
//            ((result.multiFaceLandmarks()[0].landmarkList[150].y - result.multiFaceLandmarks()[0].landmarkList[1].y) * glSurfaceView!!.height).toInt()
//        this.viewWidth =
//            ((result.multiFaceLandmarks()[0].landmarkList[379].x - result.multiFaceLandmarks()[0].landmarkList[152].x) * glSurfaceView!!.width).toInt()
        Log.d("test","${result.multiFaceLandmarks()[0].landmarkList[10].x} abc")
        Log.d("test", "$marginTopStartInit $marginStartInit with $viewWidth,$viewHeight")
        Log.d("test", "${layout!!.height} ${layout!!.width} with ${glSurfaceView!!.height},${glSurfaceView!!.width}")
        this.scalForY = 1.0
        this.scaleForX = 1.0
        return Pair(marginStartInit, marginTopStartInit)
    }
}

class FoldsLeft:ForeheadLeftHorizontal{
    constructor() : super() {
        this.animatSource = R.raw.nasolabialfoldsleft
        this.viewHeight=200
        this.viewWidth=200
        sizex= arrayOf(227,47)
        sizey=arrayOf(210,130)
//        hasBack=true
//        this.isImage=true
//        this.rotateAngleFinalInit=12F
    }
    override fun getStart(
        marginStartInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginStartInit-param1.width*0.8).toInt()

    override fun getTop(
        marginTopInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginTopInit).toInt()

    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,

        layout: FrameLayout,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        val (marginStartInit,marginTopStartInit) =findTopLeft(layout,result,226,205)
        getSize(result, glSurfaceView)
//        val marginTopStartInit =
//            (result.multiFaceLandmarks()[0].landmarkList[113].y * glSurfaceView!!.height).toInt()
//        val marginStartInit =( result.multiFaceLandmarks()[0].landmarkList[130].x*  glSurfaceView!!.width).roundToInt()

//        this.viewHeight =
//            ((result.multiFaceLandmarks()[0].landmarkList[57].y - result.multiFaceLandmarks()[0].landmarkList[130].y) * glSurfaceView!!.height).toInt()
//        this.viewWidth =
//            ((result.multiFaceLandmarks()[0].landmarkList[119].x - result.multiFaceLandmarks()[0].landmarkList[124].x) * glSurfaceView!!.width*2.5).toInt()

        Log.d("test","${result.multiFaceLandmarks()[0].landmarkList[10].x} abc")
        Log.d("test", "$marginTopStartInit $marginStartInit with $viewWidth,$viewHeight")
        Log.d("test", "${layout!!.height} ${layout!!.width} with ${glSurfaceView!!.height},${glSurfaceView!!.width}")
        this.scalForY = 1.0
        this.scaleForX = 1.0
        return Pair(marginStartInit, marginTopStartInit)
    }
}


class FoldsRight:ForeheadLeftHorizontal{
    constructor() : super() {
        this.animatSource = R.raw.nasolabialfoldsright
        this.viewHeight=200
        this.viewWidth=200
        sizex= arrayOf(266,366)
        sizey=arrayOf(430,263)
//        hasBack=true

    }
    override fun getStart(
        marginStartInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginStartInit).toInt()

    override fun getTop(
        marginTopInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginTopInit).toInt()
    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,

        layout: FrameLayout,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        val (marginStartInit,marginTopStartInit) =findTopLeft(layout,result,261,425)
        getSize(result, glSurfaceView)
//                this.viewHeight =
//            ((result.multiFaceLandmarks()[0].landmarkList[138].y - result.multiFaceLandmarks()[0].landmarkList[139].y) * glSurfaceView!!.height).toInt()
//        this.viewWidth =
//            ((result.multiFaceLandmarks()[0].landmarkList[121].x - result.multiFaceLandmarks()[0].landmarkList[139].x) * glSurfaceView!!.width).toInt()
        Log.d("test","${result.multiFaceLandmarks()[0].landmarkList[10].x} abc")
        Log.d("test", "$marginTopStartInit $marginStartInit with $viewWidth,$viewHeight")
        Log.d("test", "${layout!!.height} ${layout!!.width} with ${glSurfaceView!!.height},${glSurfaceView!!.width}")
        this.scalForY = 1.0
        this.scaleForX = 1.0
        return Pair(marginStartInit, marginTopStartInit)
    }
}

class FeetLeft:ForeheadLeftHorizontal{
    constructor() : super() {
        this.animatSource = R.raw.crowsfeetleft
        this.viewHeight=200
        this.viewWidth=200
        this.isImage=false
        sizex= arrayOf(121,139)
        sizey=arrayOf(138,139)
//        hasBack=true
    }
    override fun getStart(
        marginStartInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginStartInit).toInt()

    override fun getTop(
        marginTopInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginTopInit).toInt()
    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,

        layout: FrameLayout,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        val (marginStartInit,marginTopStartInit) =findTopLeft(layout,result,31,139)
        getSize(result, glSurfaceView)

//        this.viewHeight =
//            ((result.multiFaceLandmarks()[0].landmarkList[138].y - result.multiFaceLandmarks()[0].landmarkList[139].y) * glSurfaceView!!.height).toInt()
//        this.viewWidth =
//            ((result.multiFaceLandmarks()[0].landmarkList[121].x - result.multiFaceLandmarks()[0].landmarkList[139].x) * glSurfaceView!!.width).toInt()
        Log.d("test","${result.multiFaceLandmarks()[0].landmarkList[10].x} abc")
        Log.d("test", "$marginTopStartInit $marginStartInit with $viewWidth,$viewHeight")
        Log.d("test", "${layout!!.height} ${layout!!.width} with ${glSurfaceView!!.height},${glSurfaceView!!.width}")
        this.scalForY = 1.0
        this.scaleForX = 1.0
        return Pair(marginStartInit, marginTopStartInit)
    }
}
class FeetRight:ForeheadLeftHorizontal{
    constructor() : super() {
        this.animatSource = R.raw.crowsfeetright
        this.viewHeight=200
        this.viewWidth=200
        this.isImage=false
//        hasBack=true
        sizex= arrayOf(350,368)
        sizey=arrayOf(367,368)

    }
    override fun getStart(
        marginStartInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginStartInit).toInt()

    override fun getTop(
        marginTopInit: Int,
        param1: ViewGroup.MarginLayoutParams
    ) = (marginTopInit).toInt()
    override fun calculateAnimPosition(
        rowIndex: Int,
        colIndex: Int,

        layout: FrameLayout,
        result: FaceMeshResult,
        glSurfaceView: SolutionGlSurfaceView<FaceMeshResult>?
    ): Pair<Int, Int> {
        val (marginStartInit,marginTopStartInit) =findTopLeft(layout,result,261,423)
        getSize(result, glSurfaceView)

//        this.viewHeight =
//            ((result.multiFaceLandmarks()[0].landmarkList[138].y - result.multiFaceLandmarks()[0].landmarkList[139].y) * glSurfaceView!!.height).toInt()
//        this.viewWidth =
//            ((result.multiFaceLandmarks()[0].landmarkList[121].x - result.multiFaceLandmarks()[0].landmarkList[139].x) * glSurfaceView!!.width).toInt()
        Log.d("test","${result.multiFaceLandmarks()[0].landmarkList[10].x} abc")
        Log.d("test", "$marginTopStartInit $marginStartInit with $viewWidth,$viewHeight")
        Log.d("test", "${layout!!.height} ${layout!!.width} with ${glSurfaceView!!.height},${glSurfaceView!!.width}")
        this.scalForY = 1.0
        this.scaleForX = 1.0
        return Pair(marginStartInit, marginTopStartInit)
    }
}



