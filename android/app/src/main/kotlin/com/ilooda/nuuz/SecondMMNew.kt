package com.ilooda.nuuz


import android.graphics.*
import android.util.Log
import android.widget.FrameLayout
import com.google.mediapipe.formats.proto.LandmarkProto
import com.google.mediapipe.solutions.facemesh.FaceMeshResult
import kotlin.math.sqrt


open abstract class BaseCare2mm (rowIndex: Int, colIndex: Int): BaseCareInterface(rowIndex, colIndex){
    override fun logNoseLandmark(result: FaceMeshResult, height: Int, width: Int, canvas: Canvas): MutableList<Float> {
        val points = mutableListOf<Float>()
        result?.let { handLandmarkerResult ->
            for (landmarks in handLandmarkerResult.multiFaceLandmarks()) {
                val (startX, startY) = calLandmark(
                    landmarks,
                    width,
                    height
                )
                if(startX>=0 && startY>=0) {
                    points.add(startX)
                    points.add(startY)
                }
            }
        }
        return points
    }
}

open class LeftNasolabialFolds2mm(rowIndex: Int, colIndex: Int) : BaseCare2mm(rowIndex, colIndex) {

    override fun calLandmark(
        landmarks: LandmarkProto.NormalizedLandmarkList,
        width: Int,
        height: Int
    ): Pair<Float, Float> {

        var startX = -1.0F
        var startY = -1.0F
        when (col) {
            1 -> {
                when (row) {

                    1->{
                        val(x,y)=    getPointOnLine(landmarks, getMap(143), getMap(117), 2, width, height)
                        startX=x
                        startY=y

                    }
                    2 -> {
                        startX =
                            landmarks.getLandmark(getMap(143)).x * width
                        startY =
                            landmarks.getLandmark(getMap(143)).y * height
                    }
                    3 -> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(143), getMap(116), 2, width, height)
                        startX=x
                        startY=y

                    }
                    4 -> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(215), getMap(177), 2, width, height)
                        startX=x
                        startY=y

                    }
                    5-> {
                        startX =
                            landmarks.getLandmark(getMap(215)).x * width
                        startY =
                            landmarks.getLandmark(getMap(215)).y * height

                    }
                    6-> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(215), getMap(214), 2, width, height)
                        startX=x
                        startY=y
                    }
                    7 -> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(215), getMap(214), 2, width, height)
                        startX=x
                        startY=y
                    }
                    8 -> {
                        startX =
                            landmarks.getLandmark(getMap(214)).x * width
                        startY =
                            landmarks.getLandmark(getMap(214)).y * height

                    }
                    9 -> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(214), getMap(121), 2, width, height)
                        startX=x
                        startY=y

                    }
                    10-> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(214), getMap(121), 2, width, height)
                        startX=x
                        startY=y


                    }
                    11-> {
                        startX =
                            landmarks.getLandmark(getMap(121)).x * width
                        startY =
                            landmarks.getLandmark(getMap(121)).y * height


                    }
                    12-> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(119), getMap(121), 2, width, height)
                        startX=x
                        startY=y


                    }
                    13 -> {
                        startX =
                            landmarks.getLandmark(getMap(119)).x * width
                        startY =
                            landmarks.getLandmark(getMap(119)).y * height
                    }
                    14 -> {
                        startX =
                            landmarks.getLandmark(getMap(117)).x * width
                        startY =
                            landmarks.getLandmark(getMap(117)).y * height
                    }
                    15 -> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(117), getMap(143), 2, width, height)
                        startX=x
                        startY=y
                    }
//                    16 -> {
//                        val(x,y)=    getPointOnLine(landmarks, getMap(117), getMap(143), 2, width, height)
//                        startX=x
//                        startY=y
//                    }
//                    17 -> {
//                        startX =
//                            landmarks.getLandmark(getMap(117)).x * width
//                        startY =
//                            landmarks.getLandmark(getMap(117)).y * height
//                    }
//                    18 -> {
//                        startX =
//                            landmarks.getLandmark(getMap(143)).x * width
//                        startY =
//                            landmarks.getLandmark(getMap(143)).y * height
//                    }
                    19 -> {

                    }
                }
            }

            else -> {
                startX = -1F
                startY = -1F
            }
        }


        return Pair(startX, startY)
    }
}


open abstract class BaseGroup2mm:BaseGroupInterface(){
    init {
        rows = listOf(20)
    }
    override fun logNoseLandmark(
        bitmap: Bitmap,
        result: FaceMeshResult,
        height: Int,
        width: Int,
        layout: FrameLayout,
        view:OverlayView

    ) {
        Log.d("group","in override function")
//        if (isUpdate.get()   || result.multiFaceLandmarks().isEmpty()) return
        val th=0.01
        val canvas= Canvas(bitmap)
        try {

//            lastx=result.multiFaceLandmarks()[0].landmarkList[0].x
//            lasty=result.multiFaceLandmarks()[0].landmarkList[0].y
            var lines = mutableListOf<Float>()
            val points = mutableListOf<Float>()
            layout.post {
                //  if (careItems.isEmpty())layout.removeAllViews()
                var changerow = careItems.isEmpty()
                if (last_col != col) {
                    Log.d("group", "Move col")
                    // layout.removeAllViews()
                    careItems.clear()
                    changerow = true

                }
                if (false) {
                    changerow = careItems.isEmpty()
                    for (i in 0 until rows.size) {
                        for (j in 0 until rows[i]) {
                            val currentRow = j + 1
                            val currentCol = i + 1
                            var current: BaseCareInterface? = null
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
                            }

                        }
                    }
                    for (item in careItems) {
                        item.logNoseLandmark(result, height, width, canvas)
                    }
                } else {
                    for (j in 0 until rows[col - 1]) {
                        val currentRow = j + 1
                        val currentCol = col
                        var current: BaseCareInterface? = null
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
//                        if (careItems[j].animatSource != current.animatSource) {
//                            Log.d("change group", "${j},${col}")
//                            careItems[j].changeAnimatSource(current.animatSource)
//
//                        }
                        }
                        //  Log.d("group","${row},${col}")
                        val pts = (careItems[j].logNoseLandmark(result, height, width, canvas))
                        if (careItems[j].row == 1) {
                            points.addAll(pts)
                        }
//                        Log.d("group","${row},${col},${pts.size}")
                        lines.addAll(pts)
//                        lines.addAll(pts)
                    }
                }
//                if(lines.size>2) {
//                    lines.removeAt(0)
//                    lines.removeAt(0)
//                }
                Log.d("Lines size", "${lines.size}")
                if (lines.size > 2) {
//                    var expandlinesd = lines.map { it.toDouble() }.toDoubleArray()


                    //  expandlines = expandArray(expandlines)
//                    expandlinesd=roundCorners(expandlinesd,4.0)
//                    var expandlines=expandlinesd.map { it.toFloat() }.toFloatArray()
//                    lines.clear()
//                    for(i in expandlines.indices step 2){
//                        lines.add(expandlines[i])
//                        lines.add(expandlines[i+1])
////                        lines.add(expandlines[i])
////                        lines.add(expandlines[i+1])
//                    }
//                    lines.removeAt(0)
//                    lines.removeAt(0)
//                    for(i in 0..3)
//                    expandlines = expandArray(expandlines)
                    linePaint.color = Color.WHITE
                    linePaint.strokeWidth = 2F
                    linePaint.style = Paint.Style.FILL
//                    linePaint.isAntiAlias = true
                    lines=expandRound(lines)
                    if (lines.size > 5) {
                        var path = Path()
////
//////
                        path.fillType = Path.FillType.WINDING

                        linePaint.color = Color.parseColor("#44FCAEAD")
                        var last_idx=0
                        for (i in 0 until lines.size step 6) {
                            if (i + 5 < lines.size) {
                                if (i == 0)
                                    path.moveTo(lines[i + 0], lines[i + 1])
                                else
                                    path.lineTo(lines[i + 0], lines[i + 1])
//                            path.moveTo(lines[i + 0], lines[i + 1])
                                path.quadTo(
                                    lines[i + 2],
                                    lines[i + 3],
                                    lines[i + 4],
                                    lines[i + 5]
                                )
                                last_idx+=6
                            }
                        }
                        for (i in last_idx until lines.size -1){
                            if (i==lines.size-1){
                                path.lineTo(lines[i + 0], lines[0])
                            }else {
                                path.lineTo(lines[i + 0], lines[i + 1])
                            }
                        }
                        path.close()
                        canvas.drawPath(path, linePaint)
                        linePaint.style = Paint.Style.STROKE
                        linePaint.color = Color.WHITE
                        canvas.drawPath(path, linePaint)


//
                    }
//                canvas.drawLines(lines.toFloatArray(), linePaint)
//                canvas.drawPoints(points.toFloatArray(),pointPaint)

                }
                view.setResults(bitmap, result, width, height)
                last_col = col
            }

        } finally {
            isUpdate.set(false)
        }


    }

    var expand=false
    open fun expandRound(lines: MutableList<Float>): MutableList<Float>{


        if(expand){
            val result=mutableListOf<Float>()
            val points = lines.chunked(2).map { it[0] to it[1] }
            for(i in 0..points.size-1){
                val p1=
                    if (i==0){
                        points.last()
                    }else{
                        points[i-1]
                    }
                val p=points[i]
                val p2= if (i==points.size-1){
                    points.first()
                }else{
                    points[i+1]
                }
                result.addAll( careItems[0].getPointOnLine(p.first,p.second,p1.first,p1.second,8).toList())
                result.addAll( p.toList())
                result.addAll( careItems[0].getPointOnLine(p.first,p.second,p2.first,p2.second,8).toList())
            }
            return result
        }
        return lines

    }
}
open class LeftNasolabialFoldsGroup2mm() : BaseGroup2mm() {


    fun expandArray(arr: FloatArray): FloatArray {
        val expandedArray = FloatArray(arr.size * 2 - 2)
        for (i in 0 until arr.size step 2) {
            val x1 = arr[i]
            val y1 = arr[i + 1]
            if (i < arr.size - 2) {
                val x2 = arr[i + 2]
                val y2 = arr[i + 3]
                val midX = (x1 + x2) / 2
                val midY = (y1 + y2) / 2
                expandedArray[i * 2] = x1
                expandedArray[i * 2 + 1] = y1
                expandedArray[i * 2 + 2] = midX
                expandedArray[i * 2 + 3] = midY
            } else {
                expandedArray[i * 2] = x1
                expandedArray[i * 2 + 1] = y1
            }
        }
        return expandedArray
    }


    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftNasolabialFolds2mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftNasolabialFolds2mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftNasolabialFolds2mm(currentRow, currentCol)
    }
}

class RightNasolabialFolds2mm:LeftNasolabialFolds2mm{
    constructor(rowIndex: Int, colIndex: Int) : super(rowIndex, colIndex) {
        isRight=true

    }
}

class RightNasolabialFoldsGroup2mm() : LeftNasolabialFoldsGroup2mm() {

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightNasolabialFolds2mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightNasolabialFolds2mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightNasolabialFolds2mm(currentRow, currentCol)
    }
}
open class LeftFeet2mm(rowIndex: Int, colIndex: Int) : BaseCare2mm(rowIndex, colIndex) {

    override fun calLandmark(
        landmarks: LandmarkProto.NormalizedLandmarkList,
        width: Int,
        height: Int
    ): Pair<Float, Float> {

        var startX = -1.0F
        var startY = -1.0F
        when (col) {
            1 -> {
                when (row) {

                    1->{
                        val(x,y)=    getPointOnLine(landmarks, getMap(156), getMap(117), 2, width, height)
                        startX=x
                        startY=y

                    }
                    2 -> {
                        startX =
                            landmarks.getLandmark(getMap(156)).x * width
                        startY =
                            landmarks.getLandmark(getMap(156)).y * height
                    }
                    3 -> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(227), getMap(143), 8, width, height)
                        val zx =
                            landmarks.getLandmark(getMap(156)).x * width
                        val zy =
                            landmarks.getLandmark(getMap(156)).y * height
                        val(xx,yy)=    getPointOnLine(x,y,zx,zy, 10)
                        startX=xx
                        startY=yy

                    }
                    4 -> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(227), getMap(143), 8, width, height)
                        val zx =
                            landmarks.getLandmark(getMap(156)).x * width
                        val zy =
                            landmarks.getLandmark(getMap(156)).y * height
                        val(xx,yy)=    getPointOnLine(x,y,zx,zy, 10)
                        startX=xx
                        startY=yy
//                        val(x,y)=    getPointOnLine(landmarks, getMap(227), getMap(143), 4, width, height)
//                        startX=x
//                        startY=y

                    }
                    5-> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(227), getMap(143), 8, width, height)
                        startX=x
                        startY=y
//                        val(x,y)=    getPointOnLine(landmarks, getMap(227), getMap(127), 4, width, height)
//                        startX=x
//                        startY=y

                    }

                    6-> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(227), getMap(123), 10, width, height)
                        startX=x
                        startY=y
                    }
                    //bottom
                    7-> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(227), getMap(123), 10, width, height)
                        startX=x
                        startY=y

                    }
                    8-> {
                        startX =
                            landmarks.getLandmark(getMap(147)).x * width
                        startY =
                            landmarks.getLandmark(getMap(147)).y * height


                    }
                    9-> {
//                        val(x,y)=    getPointOnLine(landmarks, getMap(50), getMap(36), 4, width, height)
//                        startX=x
//                        startY=y
                        startX =
                            landmarks.getLandmark(getMap(205)).x * width
                        startY =
                            landmarks.getLandmark(getMap(205)).y * height
                    }
//                    10 -> {
//                        val(x,y)=    getPointOnLine(landmarks, getMap(50), getMap(36), 2, width, height)
//                        startX=x
//                        startY=y
//
//                    }
//                   11  -> {
//                       val(x,y)=    getPointOnLine(landmarks, getMap(50), getMap(36), 2, width, height)
//                       startX=x
//                       startY=y
//
//                    }
//                    12 -> {
////
//                        val(x,y)=    getPointOnLine(landmarks, getMap(120), getMap(205), 2, width, height)
//                        startX=x
//                        startY=y
//                    }

                    13-> {
//                        val(x,y)=    getPointOnLine(landmarks, getMap(50), getMap(36), 4, width, height)
//                        startX=x
//                        startY=y
//                        startX =
//                            landmarks.getLandmark(getMap(205)).x * width
//                        startY =
//                            landmarks.getLandmark(getMap(205)).y * height
                        val(x,y)=    getPointOnLine(landmarks, getMap(205), getMap(36), 6, width, height)
                        startX=x
                        startY=y
                    }
                    14-> {
                        startX =
                            landmarks.getLandmark(getMap(120)).x * width
                        startY =
                            landmarks.getLandmark(getMap(120)).y * height

                    }
                    15 -> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(120), getMap(118), 3, width, height)
                        startX=x
                        startY=y
                    }
                    16-> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(120), getMap(118), 3, width, height)
                        startX=x
                        startY=y

                    }
                    17 -> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(118), getMap(123), 3, width, height)
                        startX=x
                        startY=y
                    }
                    18 -> {
                        val(x,y)=    getPointOnLine(landmarks, getMap(156), getMap(117), 2, width, height)
                        startX=x
                        startY=y
                    }

//                    19 -> {
//
//                    }
                }
            }

            else -> {
                startX = -1F
                startY = -1F
            }
        }


        return Pair(startX, startY)
    }
}

open class LeftFeetGroup2mm() : BaseGroup2mm() {

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftFeet2mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftFeet2mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftFeet2mm(currentRow, currentCol)
    }
}

class RightFeet2mm:LeftFeet2mm{
    constructor(rowIndex: Int, colIndex: Int) : super(rowIndex, colIndex) {
        isRight=true

    }
}

class RightFeetGroup2mm() : LeftFeetGroup2mm() {

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightFeet2mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightFeet2mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightFeet2mm(currentRow, currentCol)
    }
}

open class LeftForeheadVertical2mm(rowIndex: Int, colIndex: Int) : BaseCare2mm(rowIndex, colIndex) {

    override fun calLandmark(
        landmarks: LandmarkProto.NormalizedLandmarkList,
        width: Int,
        height: Int
    ): Pair<Float, Float> {

        var startX = -1.0F
        var startY = -1.0F
        when (col) {
            1 -> {
                var diffY =
                    landmarks.landmarkList[9].y - landmarks.landmarkList[10].y
                var diffX =
                    landmarks.landmarkList[9].x - landmarks.landmarkList[10].x

                val rotateAngle =
                    kotlin.math.atan2(
                        diffY.toFloat(),
                        diffX.toFloat()
                    ) * 180F / kotlin.math.PI.toFloat()

                var distance= sqrt(diffY*diffY+diffX*diffX).toFloat()
                var basePoint=getMap(104)
                var base2Point=getMap(63)
                if(isRight)Log.d("right LeftForeheadVertical2mm","LeftForeheadVertical2mm $basePoint,$base2Point")

                val (x,y)= getPointOnLine(landmarks, base2Point, basePoint, 2, width, height)
                when (row) {

                    1 -> {
                        //left top
                        startX =x
                        startY =landmarks.getLandmark(basePoint).y * height
                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*600F)
                        startX=endX
                        startY=endY

                    }
                    2-> {
                        startX =x
                        startY =landmarks.getLandmark(basePoint).y * height
                    }

                    3  -> {
                        startX =x
                        startY =landmarks.getLandmark(basePoint).y * height
                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle-90,distance*1200F)
                        startX=landmarks.getLandmark(getMap(107)).x * width
                        startY=endY

                    }
                    4 -> {
                        startX=landmarks.getLandmark(getMap(107)).x * width
                        startY =landmarks.getLandmark(getMap(107)).y * height
                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*1600F)
                        startX=endX
                        startY=endY
                    }
                }
            }

            else -> {
                startX = -1F
                startY = -1F
            }
        }


        return Pair(startX, startY)
    }
}

open class LeftForeheadVerticalGroup2mm : BaseGroup2mm {
    constructor():super(){
        expand=true
    }
    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftForeheadVertical2mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftForeheadVertical2mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftForeheadVertical2mm(currentRow, currentCol)
    }
}
class RightForeheadVertical2mm:LeftForeheadVertical2mm{
    constructor(rowIndex: Int, colIndex: Int) : super(rowIndex, colIndex) {

        isRight=true

    }

    override fun calLandmark(
        landmarks: LandmarkProto.NormalizedLandmarkList,
        width: Int,
        height: Int
    ): Pair<Float, Float> {

        var startX = -1.0F
        var startY = -1.0F
        when (col) {
            1 -> {
                var diffY =
                    landmarks.landmarkList[9].y - landmarks.landmarkList[10].y
                var diffX =
                    landmarks.landmarkList[9].x - landmarks.landmarkList[10].x

                val rotateAngle =
                    kotlin.math.atan2(
                        diffY.toFloat(),
                        diffX.toFloat()
                    ) * 180F / kotlin.math.PI.toFloat()
//                diffY =
//                    landmarks.landmarkList[getMap(109)].y - landmarks.landmarkList[getMap(105)].y
//                diffX =
//                    landmarks.landmarkList[getMap(109)].x - landmarks.landmarkList[getMap(105)].x
                var distance= sqrt(diffY*diffY+diffX*diffX).toFloat()
                var basePoint=getMap(104)
                var base2Point=getMap(63)
                if(isRight)Log.d("right LeftForeheadVertical2mm","LeftForeheadVertical2mm $basePoint,$base2Point")

                val (x,y)= getPointOnLine(landmarks, base2Point, basePoint, 2, width, height)
                when (row) {

                    1 -> {
                        //right top
                        startX =x
                        startY =landmarks.getLandmark(basePoint).y * height
                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*600F)
                        startX=endX
                        startY=endY

                    }
                    2-> {
                        startX =x
                        startY =landmarks.getLandmark(basePoint).y * height
                    }

                    3  -> {
                        startX =x
                        startY =landmarks.getLandmark(basePoint).y * height
                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle-90,-distance*1200F)
                        startX=landmarks.getLandmark(getMap(107)).x * width
                        startY=endY

                    }
                    4 -> {
                        startX=landmarks.getLandmark(getMap(107)).x * width
                        startY =landmarks.getLandmark(getMap(107)).y * height
                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*1600F)
                        startX=endX
                        startY=endY
                    }
                }
            }

            else -> {
                startX = -1F
                startY = -1F
            }
        }


        return Pair(startX, startY)
    }

}

class RightForeheadVerticalGroup2mm : LeftForeheadVerticalGroup2mm {
    constructor():super(){
        expand=true

    }
    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        Log.d("RightForeheadVerticalGroup2mm","RightForeheadVerticalGroup2mm")
        return RightForeheadVertical2mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightForeheadVertical2mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightForeheadVertical2mm(currentRow, currentCol)
    }
}

open class LeftForeheadHorizontal2mm(rowIndex: Int, colIndex: Int) : BaseCare2mm(rowIndex, colIndex) {

    override fun calLandmark(
        landmarks: LandmarkProto.NormalizedLandmarkList,
        width: Int,
        height: Int
    ): Pair<Float, Float> {

        var startX = -1.0F
        var startY = -1.0F
        when (col) {
            1 -> {
                var diffY =
                    landmarks.landmarkList[9].y - landmarks.landmarkList[10].y
                var diffX =
                    landmarks.landmarkList[9].x - landmarks.landmarkList[10].x

                val rotateAngle =
                    kotlin.math.atan2(
                        diffY.toFloat(),
                        diffX.toFloat()
                    ) * 180F / kotlin.math.PI.toFloat()
//                diffY =
//                    landmarks.landmarkList[getMap(109)].y - landmarks.landmarkList[getMap(105)].y
//                diffX =
//                    landmarks.landmarkList[getMap(109)].x - landmarks.landmarkList[getMap(105)].x
                var distance= sqrt(diffY*diffY+diffX*diffX).toFloat()
                var basePoint=getMap(104)
                var base2Point=getMap(63)
                if(isRight)Log.d("right LeftForeheadVertical2mm","LeftForeheadVertical2mm $basePoint,$base2Point")

                val (x,y)= getPointOnLine(landmarks, base2Point, basePoint, 2, width, height)
                when (row) {

                    1 -> {
                        //left top
                        startX =x
                        startY =landmarks.getLandmark(basePoint).y * height
                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*600F)
                        startX=endX
                        startY=endY

                    }
                    2-> {
                        startX =x
                        startY =landmarks.getLandmark(basePoint).y * height
                    }

                    3  -> {
                        startX =x
                        startY =landmarks.getLandmark(basePoint).y * height
                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle-90,distance*1200F)
                        startX=landmarks.getLandmark(getMap(107)).x * width
                        startY=endY

                    }
                    4 -> {
                        startX=landmarks.getLandmark(getMap(107)).x * width
                        startY =landmarks.getLandmark(getMap(107)).y * height
                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*1400F)
                        startX=endX
                        startY=endY
                    }
                    5 -> {
//                        startX=landmarks.getLandmark(getMap(107)).x * width
//                        startY =landmarks.getLandmark(getMap(107)).y * height
//                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*1400F)

//                        startY=endY
                        val (x,y)= getPointOnLine(landmarks, getMap(69),getMap(104), 3, width, height)
                        val (fx,fy)=this.getPointCoordinates(x,y,rotateAngle,-distance*900F)
                        startX=fx
                        startY=fy

                    }
                }
            }

            else -> {
                startX = -1F
                startY = -1F
            }
        }


        return Pair(startX, startY)
    }
}

open class LeftForeheadHorizontalGroup2mm : BaseGroup2mm {
    constructor():super(){
        expand=true
    }
    override fun expandRound(lines: MutableList<Float>): MutableList<Float>{


        if(expand){
            val result=mutableListOf<Float>()
            val points = lines.chunked(2).map { it[0] to it[1] }
            for(i in 0..points.size-2){
                val p1=
                    if (i==0){
                        points.last()
                    }else{
                        points[i-1]
                    }
                val p=points[i]
                val p2= if (i==points.size-1){
                    points.first()
                }else{
                    points[i+1]
                }
                result.addAll( careItems[0].getPointOnLine(p.first,p.second,p1.first,p1.second,10).toList())
                result.addAll( p.toList())
                result.addAll( careItems[0].getPointOnLine(p.first,p.second,p2.first,p2.second,10).toList())
            }

            result.addAll(points.last().toList())

            return result
        }
        return lines

    }
    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftForeheadHorizontal2mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftForeheadHorizontal2mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftForeheadHorizontal2mm(currentRow, currentCol)
    }
}
class RightForeheadHorizontal2mm:LeftForeheadHorizontal2mm{
    constructor(rowIndex: Int, colIndex: Int) : super(rowIndex, colIndex) {

        isRight=true

    }

    override fun calLandmark(
        landmarks: LandmarkProto.NormalizedLandmarkList,
        width: Int,
        height: Int
    ): Pair<Float, Float> {

        var startX = -1.0F
        var startY = -1.0F
        when (col) {
            1 -> {
                var diffY =
                    landmarks.landmarkList[9].y - landmarks.landmarkList[10].y
                var diffX =
                    landmarks.landmarkList[9].x - landmarks.landmarkList[10].x

                val rotateAngle =
                    kotlin.math.atan2(
                        diffY.toFloat(),
                        diffX.toFloat()
                    ) * 180F / kotlin.math.PI.toFloat()
//                diffY =
//                    landmarks.landmarkList[getMap(109)].y - landmarks.landmarkList[getMap(105)].y
//                diffX =
//                    landmarks.landmarkList[getMap(109)].x - landmarks.landmarkList[getMap(105)].x
                var distance= sqrt(diffY*diffY+diffX*diffX).toFloat()
                var basePoint=getMap(104)
                var base2Point=getMap(63)
                if(isRight)Log.d("right LeftForeheadVertical2mm","LeftForeheadVertical2mm $basePoint,$base2Point")

                val (x,y)= getPointOnLine(landmarks, base2Point, basePoint, 2, width, height)
                when (row) {

                    1 -> {
                        //left top
                        startX =x
                        startY =landmarks.getLandmark(basePoint).y * height
                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*600F)
                        startX=endX
                        startY=endY

                    }
                    2-> {
                        startX =x
                        startY =landmarks.getLandmark(basePoint).y * height
                    }

                    3  -> {
                        startX =x
                        startY =landmarks.getLandmark(basePoint).y * height
                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle-90,-distance*1200F)
                        startX=landmarks.getLandmark(getMap(107)).x * width
                        startY=endY

                    }
                    4 -> {
                        startX=landmarks.getLandmark(getMap(107)).x * width
                        startY =landmarks.getLandmark(getMap(107)).y * height
                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*1400F)
                        startX=endX
                        startY=endY
                    }
                    5 -> {

                        val (x,y)= getPointOnLine(landmarks, getMap(69),getMap(104), 3, width, height)
                        val (fx,fy)=this.getPointCoordinates(x,y,rotateAngle,-distance*900F)
                        startX=fx
                        startY=fy

                    }
                }
            }

            else -> {
                startX = -1F
                startY = -1F
            }
        }


        return Pair(startX, startY)
    }
}

class RightForeheadHorizontalGroup2mm : LeftForeheadHorizontalGroup2mm {
    constructor():super(){
        expand=true

    }
    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        Log.d("RightForeheadVerticalGroup2mm","RightForeheadVerticalGroup2mm")
        return RightForeheadHorizontal2mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightForeheadHorizontal2mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightForeheadHorizontal2mm(currentRow, currentCol)
    }
}


open class LeftNeck2mm(rowIndex: Int, colIndex: Int) : BaseCare2mm(rowIndex, colIndex) {

    override fun calLandmark(
        landmarks: LandmarkProto.NormalizedLandmarkList,
        width: Int,
        height: Int
    ): Pair<Float, Float> {

        var startX = -1.0F
        var startY = -1.0F
        when (col) {
            1 -> {
                var diffY =
                    landmarks.landmarkList[200].y - landmarks.landmarkList[152].y
                var diffX =
                    landmarks.landmarkList[200].x - landmarks.landmarkList[152].x

                val rotateAngle =
                    kotlin.math.atan2(
                        diffY.toFloat(),
                        diffX.toFloat()
                    ) * 180F / kotlin.math.PI.toFloat()

                var basePoint=getMap(148)
                var base2Point=getMap(176)
                diffY =
                    landmarks.landmarkList[basePoint].y - landmarks.landmarkList[base2Point].y
                diffX =
                    landmarks.landmarkList[basePoint].x - landmarks.landmarkList[base2Point].x
                var distance= sqrt(diffY*diffY+diffX*diffX)*2.toFloat()

                //  val (x,y)= getPointOnLine(landmarks, base2Point, basePoint, 2, width, height)
                when (row) {

                    1 -> {
                        //Right top
                        startX =landmarks.getLandmark(getMap(150)).x*width
                        startY =landmarks.getLandmark(basePoint).y * height
                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*300F)
                        startX=endX
                        startY=endY

                    }
                    2-> {
                        startX =landmarks.getLandmark(getMap(150)).x*width
                        startY =landmarks.getLandmark(basePoint).y * height
                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*1400F)
                        startX=endX
                        startY=endY
                    }

                    3  -> {
                        val v= if(isRight)-1 else 1
                        startX =landmarks.getLandmark(getMap(172)).x*width
                        startY =landmarks.getLandmark(getMap(172)).y * height
                        diffY =
                            landmarks.landmarkList[getMap(172)].y - landmarks.landmarkList[getMap(136)].y
                        diffX =
                            landmarks.landmarkList[getMap(172)].x - landmarks.landmarkList[getMap(136)].x
                        var distancea= sqrt(diffY*diffY+diffX*diffX)*2.toFloat()
                        val (x,y1)=this.getPointCoordinates(startX,startY,rotateAngle+90,-distancea*500F*v)
                        val y =landmarks.getLandmark(getMap(172)).y*height
                        val (endX,endY)=this.getPointCoordinates(x,y,rotateAngle,-distance*1400F)
                        startX=endX
                        startY=endY


                    }
                    4 -> {
                        val v= if(isRight)-1 else 1
                        startX =landmarks.getLandmark(getMap(172)).x*width
                        startY =landmarks.getLandmark(getMap(172)).y * height
                        diffY =
                            landmarks.landmarkList[getMap(172)].y - landmarks.landmarkList[getMap(136)].y
                        diffX =
                            landmarks.landmarkList[getMap(172)].x - landmarks.landmarkList[getMap(136)].x
                        var distancea= sqrt(diffY*diffY+diffX*diffX)*2.toFloat()
                        val (x,y1)=this.getPointCoordinates(startX,startY,rotateAngle+90,-distancea*500F*v)
                        val y =landmarks.getLandmark(getMap(172)).y*height
                        val (endX,endY)=this.getPointCoordinates(x,y,rotateAngle,-distance*400F)
                        startX=endX
                        startY=endY

                    }
                }
            }

            else -> {
                startX = -1F
                startY = -1F
            }
        }


        return Pair(startX, startY)
    }
}

open class LeftNeckGroup2mm : BaseGroup2mm {
    constructor():super(){
        expand=true
    }
    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftNeck2mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftNeck2mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftNeck2mm(currentRow, currentCol)
    }
}
class RightNeck2mm:LeftNeck2mm{
    constructor(rowIndex: Int, colIndex: Int) : super(rowIndex, colIndex) {

        isRight=true

    }



}

class RightNeckGroup2mm : LeftForeheadVerticalGroup2mm {
    constructor():super(){
        expand=true

    }
    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {

        return RightNeck2mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightNeck2mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightNeck2mm(currentRow, currentCol)
    }
}



