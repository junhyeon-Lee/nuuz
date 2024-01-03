package com.ilooda.nuuz


import android.graphics.*
import android.util.Log
import com.google.mediapipe.formats.proto.LandmarkProto
import com.google.mediapipe.solutions.facemesh.FaceMeshResult
import kotlin.math.sqrt


class Forehead3mm(rowIndex: Int,colIndex: Int) : BaseCareInterface(rowIndex,colIndex) {




    override fun calLandmark(
        landmarks: LandmarkProto.NormalizedLandmarkList,
        width: Int,
        height: Int
    ): Pair<Float, Float> {

        var startX = -1.0F
        var startY = -1.0F
        var diffY =
            landmarks.landmarkList[9].y - landmarks.landmarkList[10].y
        var diffX =
            landmarks.landmarkList[9].x - landmarks.landmarkList[10].x
        var distance=sqrt(diffY*diffY+diffX*diffX).toFloat()
        val rotateAngle =
            kotlin.math.atan2(
                diffY.toFloat(),
                diffX.toFloat()
            ) * 180F / kotlin.math.PI.toFloat()
        when (col) {
            1 ,8-> {
                var basePoint=104
                var base2Point=63
                if(col==8){


                    basePoint=getMap(basePoint,true)
                    base2Point=getMap(base2Point,true)

                }
                val (x,y)= getPointOnLine(landmarks, basePoint, base2Point, 2, width, height)
                startX =x
                startY =landmarks.getLandmark(basePoint).y * height
                when (row) {
                    1 -> {


                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*800F)
                        startX=endX
                        startY=endY

                    }
                    2 -> {


                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*600F)
                        startX=endX
                        startY=endY

                    }
                    3 -> {


                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*400F)
                        startX=endX
                        startY=endY
                    }
                    4 -> {



                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*200F)
                        startX=endX
                        startY=endY
                    }
                    5 -> {

                    }

                }
            }
            3,6 -> {
                var start=66
                var end=108
                if (col==6) {
                    start = 296
                    end=337
                }

                val (x, y) = getPointOnLine(landmarks, start, end, 4, width, height)

                startX = x
                val (rx, ry) = getPointOnLine(landmarks, end, start, 4, width, height)
                startY = ry

                val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*1200F)

                when (row) {
                    1 -> {

//                        val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*1200F)

                        startX=endX
                        startY=endY

                    }
                    2-> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,8/9F)
                        startX=newx
                        startY=newy

                    }

                    3 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,7/9F)
                        startX=newx
                        startY=newy
                    }
                    4 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,6/9F)
                        startX=newx
                        startY=newy
                    }
                    5 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,5/9F)
                        startX=newx
                        startY=newy

                    }
                    6 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,4/9F)
                        startX=newx
                        startY=newy
                    }
                    7 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,3/9F)
                        startX=newx
                        startY=newy
                    }
                    8 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,2/9F)
                        startX=newx
                        startY=newy
                    }
                    9 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/9F)
                        startX=newx
                        startY=newy
                    }
                    10 -> {

                    }

                }
            }
            2 ,7-> {
                var start=105
                var end=69
                if (col==7) {
                    start = 334
                    end=299
                }
                val (x, y) = getPointOnLine(landmarks, start, end, 3, width, height)

                startX = x
                val (rx, ry) = getPointOnLine(landmarks, end, start, 4, width, height)
                startY = ry
                val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*1000F)
                when (row) {
                    1 -> {


                        startX=endX
                        startY=endY

                    }

                    2-> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,8/9F)
                        startX=newx
                        startY=newy

                    }

                    3 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,7/9F)
                        startX=newx
                        startY=newy
                    }
                    4 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,6/9F)
                        startX=newx
                        startY=newy
                    }
                    5 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,5/9F)
                        startX=newx
                        startY=newy

                    }
                    6 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,4/9F)
                        startX=newx
                        startY=newy
                    }
                    7 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,3/9F)
                        startX=newx
                        startY=newy
                    }
                    8 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,2/9F)
                        startX=newx
                        startY=newy
                    }
                    9 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/9F)
                        startX=newx
                        startY=newy
                    }
                    10 -> {

                    }
                }
            }
            4 ,5-> {
                var start=107
                var end=151
                if (col==5) {
                    start = 336
                    end=151
                }

                val (x, y) = getPointOnLine(landmarks, start, end, 3, width, height)
                startX = x
                val (rx, ry) = getPointOnLine(landmarks, end, start, 8, width, height)
                startY = ry
                val (endX,endY)=this.getPointCoordinates(startX,startY,rotateAngle,-distance*1400F)
                when (row) {
                    1 -> {


                        startX=endX
                        startY=endY

                    }
                    2-> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,8/9F)
                        startX=newx
                        startY=newy

                    }

                    3 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,7/9F)
                        startX=newx
                        startY=newy
                    }
                    4 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,6/9F)
                        startX=newx
                        startY=newy
                    }
                    5 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,5/9F)
                        startX=newx
                        startY=newy

                    }
                    6 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,4/9F)
                        startX=newx
                        startY=newy
                    }
                    7 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,3/9F)
                        startX=newx
                        startY=newy
                    }
                    8 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,2/9F)
                        startX=newx
                        startY=newy
                    }
                    9 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/9F)
                        startX=newx
                        startY=newy
                    }
                    10 -> {

                    }
                }
            }


            else -> {

            }
        }


        return Pair(startX, startY)
    }


}

open class LeftCheek3mm (rowIndex: Int,colIndex: Int) : BaseCareInterface(rowIndex,colIndex){




    override fun calLandmark(
        landmarks: LandmarkProto.NormalizedLandmarkList,
        width: Int,
        height: Int
    ): Pair<Float, Float> {

        var startX = -1.0F
        var startY = -1.0F
        when (col) {
            1 -> {
                startX =
                    landmarks.getLandmark(getMap(210)).x * width
                startY =
                    landmarks.getLandmark(getMap(210)).y * height
                val (endX, endY) = getPointOnLine(landmarks, getMap(118), getMap(100), 3, width, height)

                when (row) {
                    1 -> {


                        startX=endX
                        startY=endY

                    }
                    2-> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,8/9F)
                        startX=newx
                        startY=newy

                    }

                    3 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,7/9F)
                        startX=newx
                        startY=newy
                    }
                    4 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,6/9F)
                        startX=newx
                        startY=newy
                    }
                    5 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,5/9F)
                        startX=newx
                        startY=newy

                    }
                    6 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,4/9F)
                        startX=newx
                        startY=newy
                    }
                    7 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,3/9F)
                        startX=newx
                        startY=newy
                    }
                    8 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,2/9F)
                        startX=newx
                        startY=newy
                    }
                    9 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/9F)
                        startX=newx
                        startY=newy
                    }
                    10 -> {

                    }

                }
            }
            2 -> {
                val (x, y) = getPointOnLine(landmarks, getMap(135), getMap(214), 2, width, height)
                startX = x
                startY = y
                val (endX, endY) = getPointOnLine(landmarks, getMap(117), getMap(101), 4, width, height)
                when (row) {
                    1 -> {


                        startX=endX
                        startY=endY

                    }
                    2-> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,8/9F)
                        startX=newx
                        startY=newy

                    }

                    3 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,7/9F)
                        startX=newx
                        startY=newy
                    }
                    4 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,6/9F)
                        startX=newx
                        startY=newy
                    }
                    5 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,5/9F)
                        startX=newx
                        startY=newy

                    }
                    6 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,4/9F)
                        startX=newx
                        startY=newy
                    }
                    7 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,3/9F)
                        startX=newx
                        startY=newy
                    }
                    8 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,2/9F)
                        startX=newx
                        startY=newy
                    }
                    9 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/9F)
                        startX=newx
                        startY=newy
                    }
                    10 -> {

                    }

                }
            }
            3 -> {
                val (x, y) = getPointOnLine(landmarks, getMap(138), getMap(214), 3, width, height)
                startX = x
                startY = y
                val (endX, endY) = getPointOnLine(landmarks, getMap(117), getMap(116), 3, width, height)

//                val endY =
//                    getPointOnLine(landmarks, getMap(123), getMap(116), 2, width, height).second
                when (row) {
                    1 -> {


                        startX=endX
                        startY=endY

                    }
                    2-> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,8/9F)
                        startX=newx
                        startY=newy

                    }

                    3 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,7/9F)
                        startX=newx
                        startY=newy
                    }
                    4 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,6/9F)
                        startX=newx
                        startY=newy
                    }
                    5 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,5/9F)
                        startX=newx
                        startY=newy

                    }
                    6 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,4/9F)
                        startX=newx
                        startY=newy
                    }
                    7 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,3/9F)
                        startX=newx
                        startY=newy
                    }
                    8 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,2/9F)
                        startX=newx
                        startY=newy
                    }
                    9 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/9F)
                        startX=newx
                        startY=newy
                    }
                    10 -> {

                    }
                }
            }
            4 -> {
                val (x, y) = getPointOnLine(landmarks, getMap(58), getMap(192), 2, width, height)
                startX = x
                startY = y
                val endX =
                    landmarks.getLandmark(getMap(116)).x * width
                val endY =
                    landmarks.getLandmark(getMap(116)).y * height
                when (row) {
                    1 -> {


                        startX=endX
                        startY=endY

                    }
                    2-> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,8/9F)
                        startX=newx
                        startY=newy

                    }

                    3 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,7/9F)
                        startX=newx
                        startY=newy
                    }
                    4 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,6/9F)
                        startX=newx
                        startY=newy
                    }
                    5 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,5/9F)
                        startX=newx
                        startY=newy

                    }
                    6 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,4/9F)
                        startX=newx
                        startY=newy
                    }
                    7 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,3/9F)
                        startX=newx
                        startY=newy
                    }
                    8 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,2/9F)
                        startX=newx
                        startY=newy
                    }
                    9 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/9F)
                        startX=newx
                        startY=newy
                    }
                    10 -> {

                    }
                }
            }
            else -> {

            }
        }


        return Pair(startX, startY)
    }


}

class LeftCheekGroup3mm() : BaseGroupInterface() {
    init {
        rows = listOf(10, 10, 10, 10)
    }

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftCheek3mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftCheek3mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftCheek3mm(currentRow, currentCol)
    }
}


class RightCheek3mm : LeftCheek3mm {

    constructor(rowIndex: Int, colIndex: Int) : super(rowIndex, colIndex) {
        isRight=true

    }



}

class RightCheekGroup3mm() : BaseGroupInterface() {
    init {
        rows = listOf(10, 10, 10, 10)
    }

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightCheek3mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightCheek3mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightCheek3mm(currentRow, currentCol)
    }
}

open class LeftCheekHorizontal3mm(rowIndex: Int,colIndex: Int) : BaseCareInterface(rowIndex,colIndex) {




    override fun calLandmark(
        landmarks: LandmarkProto.NormalizedLandmarkList,
        width: Int,
        height: Int
    ): Pair<Float, Float> {

        var startX = -1.0F
        var startY = -1.0F
        when (col) {
            1 -> {
                val (x, y) = getPointOnLine(
                    landmarks,
                    getMap(36),
                    getMap(118),
                    6,
                    width,
                    height
                )
                startX = x
                startY = y
                val (endX, endY) = getPointOnLine(
                    landmarks,
                    getMap(116),
                    getMap(123),
                    3,
                    width,
                    height
                )
                when (row) {

                    1 -> {


                        startX=endX
                        startY=endY

                    }
                    2-> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,8/9F)
                        startX=newx
                        startY=newy

                    }

                    3 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,7/9F)
                        startX=newx
                        startY=newy
                    }
                    4 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,6/9F)
                        startX=newx
                        startY=newy
                    }
                    5 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,5/9F)
                        startX=newx
                        startY=newy

                    }
                    6 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,4/9F)
                        startX=newx
                        startY=newy
                    }
                    7 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,3/9F)
                        startX=newx
                        startY=newy
                    }
                    8 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,2/9F)
                        startX=newx
                        startY=newy
                    }
                    9 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/9F)
                        startX=newx
                        startY=newy
                    }
                    10 -> {

                    }

                }
            }
            2 -> {
                val (x, y) = getPointOnLine(
                    landmarks,
                    getMap(205),
                    getMap(206),
                    3,
                    width,
                    height
                )
                startX=x
                startY=y
                val (endX, endY) = getPointOnLine(
                    landmarks,
                    getMap(123),
                    getMap(137),
                    3,
                    width,
                    height
                )
                when (row) {
                    1 -> {


                        startX=endX
                        startY=endY

                    }
                    2-> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,8/9F)
                        startX=newx
                        startY=newy

                    }

                    3 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,7/9F)
                        startX=newx
                        startY=newy
                    }
                    4 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,6/9F)
                        startX=newx
                        startY=newy
                    }
                    5 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,5/9F)
                        startX=newx
                        startY=newy

                    }
                    6 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,4/9F)
                        startX=newx
                        startY=newy
                    }
                    7 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,3/9F)
                        startX=newx
                        startY=newy
                    }
                    8 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,2/9F)
                        startX=newx
                        startY=newy
                    }
                    9 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/9F)
                        startX=newx
                        startY=newy
                    }
                    10 -> {

                    }
                }
            }
            3 -> {
                val (x, y) = getPointOnLine(
                    landmarks,
                    getMap(216),
                    getMap(207),
                    3,
                    width,
                    height
                )
                startX = x
                startY = y
                val endY=landmarks.getLandmark(getMap(147)).y * height
                val (endX, ry) = getPointOnLine(
                    landmarks,
                    getMap(137),
                    getMap(147),
                    3,
                    width,
                    height
                )
                when (row) {
                    1 -> {


                        startX=endX
                        startY=endY

                    }
                    2-> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,8/9F)
                        startX=newx
                        startY=newy

                    }

                    3 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,7/9F)
                        startX=newx
                        startY=newy
                    }
                    4 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,6/9F)
                        startX=newx
                        startY=newy
                    }
                    5 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,5/9F)
                        startX=newx
                        startY=newy

                    }
                    6 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,4/9F)
                        startX=newx
                        startY=newy
                    }
                    7 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,3/9F)
                        startX=newx
                        startY=newy
                    }
                    8 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,2/9F)
                        startX=newx
                        startY=newy
                    }
                    9 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/9F)
                        startX=newx
                        startY=newy
                    }
                    10 -> {

                    }
                }
            }
            4 -> {
                val (x, y) = getPointOnLine(
                    landmarks,
                    getMap(214),
                    getMap(216),
                    2,
                    width,
                    height
                )
                startX = x
                startY = y
                val (endX, endY) = getPointOnLine(
                    landmarks,
                    getMap(177),
                    getMap(215),
                    3,
                    width,
                    height
                )
                when (row) {
                    1 -> {


                        startX=endX
                        startY=endY

                    }
                    2-> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,8/9F)
                        startX=newx
                        startY=newy

                    }

                    3 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,7/9F)
                        startX=newx
                        startY=newy
                    }
                    4 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,6/9F)
                        startX=newx
                        startY=newy
                    }
                    5 -> {

                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,5/9F)
                        startX=newx
                        startY=newy

                    }
                    6 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,4/9F)
                        startX=newx
                        startY=newy
                    }
                    7 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,3/9F)
                        startX=newx
                        startY=newy
                    }
                    8 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,2/9F)
                        startX=newx
                        startY=newy
                    }
                    9 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/9F)
                        startX=newx
                        startY=newy
                    }
                    10 -> {

                    }
                }
            }
            else -> {

            }
        }


        return Pair(startX, startY)
    }



}

class LeftCheekHorizontalGroup3mm() : BaseGroupInterface() {
    init {
        rows = listOf(10, 10,10, 10)
    }

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftCheekHorizontal3mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftCheekHorizontal3mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftCheekHorizontal3mm(currentRow, currentCol)
    }
}


class RightHorizontal3mm : LeftCheekHorizontal3mm {

    constructor(rowIndex: Int, colIndex: Int) : super(rowIndex, colIndex) {
        isRight=true

    }




}

class RightCheekHorizontalGroup3mm() : BaseGroupInterface() {
    init {
        rows = listOf(10, 10, 10, 10)
    }

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightHorizontal3mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightHorizontal3mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightHorizontal3mm(currentRow, currentCol)
    }
}

class ForeheadGroup3mm() : BaseGroupInterface() {
    init {
        rows = listOf(5, 10, 10, 10, 10, 10, 10, 5)
    }

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return Forehead3mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return Forehead3mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return Forehead3mm(currentRow, currentCol)
    }
}



val posmap = mapOf<Int, Int>(
    34 to 264,
    227 to 447,
    116 to 345,
    143 to 372,
    117 to 346,
    123 to 352,
    50 to 280,
    36 to 266,
    205 to 425,
    100 to 329,
    101 to 330,
    137 to 366,
    187 to 411,
    234 to 454,
    177 to 401,
    147 to 376,
    207 to 427,
    192 to 416,
    216 to 436,
    214 to 434,
    93 to 323,
    213 to 433,
    214 to 434,
    212 to 432,
    210 to 430,
    135 to 364,
    169 to 394,
    211 to 431,
    138 to 367,
    215 to 435,
    206 to 426,
    162 to 389,
    127 to 356,
    139 to 368,
    156 to 383,
    35 to 265,
    124 to 353,
    31 to 261,
    228 to 448,
    229 to 449,
    230 to 450,
    231 to 451,
    232 to 452,
    170 to 395,
    202 to 422,
    129 to 358,
    111 to 340,
    118 to 347,
    119 to 348,
    120 to 349,
    121 to 350,
    70 to 300,
    71 to 301,
    21 to 251,
    130 to 359,
    132 to 361,
    58 to 288,
    203 to 423,
    47 to 399,
    104 to 333,
    63 to 293,
    109 to 338,
    105 to 334,
    107 to 336,
    69 to 299,
    176 to 400,
    150 to 379,
    149 to 378,
    172 to 397,
    136 to 365,
    140 to 378,
    148 to 377
)
open class LeftFeetHorizontal3mm(rowIndex: Int,colIndex: Int) : BaseCareInterface(rowIndex,colIndex) {




    override fun calLandmark(
        landmarks: LandmarkProto.NormalizedLandmarkList,
        width: Int,
        height: Int
    ): Pair<Float, Float> {

        var startX = -1.0F
        var startY = -1.0F
        when (col) {
            1 -> {
                val (x, y) = getPointOnLine(
                    landmarks,
                    getMap(34),
                    getMap(156),
                    3,
                    width,
                    height
                )
                startX = x
                startY = y
                val endX =
                    landmarks.getLandmark(getMap(130)).x * width
                val endY =
                    landmarks.getLandmark(getMap(130)).y * height
                when (row) {

                    1->{
                        val(x,y)= calculateExtendedPoint(endX,endY,startX,startY,24F)
                        startX = x
                        startY = y
                    }

                    2 -> {
                        val(x,y)=  calculateExtendedPoint(endX,endY,startX,startY,12F)
                        startX = x
                        startY = y

                    }
                    3 -> {
                        //center

                    }
                    4-> {
                        val(x,y)=  getPointOnLine(startX,startY,endX,endY,1/6F)
                        startX = x
                        startY = y
                    }
                    5 -> {

                        val(x,y)=getPointOnLine(startX,startY,endX,endY,2/6F)
                        startX = x
                        startY = y
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



class LeftFeetHorizontalGroup3mm() : BaseGroupInterface() {
    init {
        rows = listOf(5)
    }

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftFeetHorizontal3mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftFeetHorizontal3mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftFeetHorizontal3mm(currentRow, currentCol)
    }
}
class RightFeetHorizontal3mm:LeftFeetHorizontal3mm{
    constructor(rowIndex: Int, colIndex: Int) : super(rowIndex, colIndex) {
        isRight=true

    }

}
class RightFeetHorizontalGroup3mm() : BaseGroupInterface() {
    init {
        rows = listOf(5)
    }

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightFeetHorizontal3mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightFeetHorizontal3mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightFeetHorizontal3mm(currentRow, currentCol)
    }
}

open class LeftFeetVertical3mm(rowIndex: Int,colIndex: Int) : BaseCareInterface(rowIndex,colIndex) {


//    override fun logNoseLandmark(result: FaceMeshResult, height: Int, width: Int, canvas: Canvas){
//        super.logNoseLandmark(result, height, width, canvas)
//        result?.let { handLandmarkerResult ->
//            for (landmarks in handLandmarkerResult.multiFaceLandmarks()) {
//                val (startX, startY) = calLandmark(
//                    landmarks,
//                    width,
//                    height
//                )
//                val (endX,endY)=this.getPointCoordinates(startX,startY,-72.15F,45F)
//                canvas.drawLine(startX,startY,endX,endY, pointPaint)
//            }
//
//        }
//    }

    override fun calLandmark(
        landmarks: LandmarkProto.NormalizedLandmarkList,
        width: Int,
        height: Int
    ): Pair<Float, Float> {

        var startX = -1.0F
        var startY = -1.0F
        when (col) {
            1 -> {
                val (x, y) = getPointOnLine(
                    landmarks,
                    getMap(139),
                    getMap(35),
                    5,
                    width,
                    height
                )
                startX = x
                startY = y
                val (endX, endY) = getPointOnLine(
                    landmarks,
                    getMap(143),
                    getMap(227),
                    2,
                    width,
                    height
                )
                when (row) {
                    1 -> {


                        startX=endX
                        startY=endY

                    }
                    2 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,3/4F)
                        startX=newx
                        startY=newy
                    }
                    3 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,2/4F)
                        startX=newx
                        startY=newy
                    }
                    4 -> {
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/4F)
                        startX=newx
                        startY=newy
                    }

                    5 -> {

                    }

                }
            }

            else -> {

            }
        }


        return Pair(startX, startY)
    }



}
class LeftFeetVerticalGroup3mm() : BaseGroupInterface() {
    init {
        rows = listOf(5)
    }

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftFeetVertical3mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftFeetVertical3mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftFeetVertical3mm(currentRow, currentCol)
    }
}
class RightFeetVertical3mm:LeftFeetVertical3mm{
    constructor(rowIndex: Int, colIndex: Int) : super(rowIndex, colIndex) {
        isRight=true

    }

}
class RightFeetVerticalGroup3mm() : BaseGroupInterface() {
    init {
        rows = listOf(5)
    }

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightFeetVertical3mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightFeetVertical3mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightFeetVertical3mm(currentRow, currentCol)
    }
}

open class LeftTear3mm : BaseCareInterface {


    constructor(rowIndex: Int, colIndex: Int) : super(rowIndex, colIndex) {
        radius=5.5F
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
                when (row) {
                    1->{

                        val (x, y) = getPointOnLine(
                            landmarks,
                            getMap(111),
                            getMap(35),
                            3,
                            width,
                            height
                        )
                        startX = x
                        startY = y
                    }
                    2->{

                        val (x, y) = getPointOnLine(
                            landmarks,
                            getMap(111),
                            getMap(228),
                            3,
                            width,
                            height
                        )
                        startX = x
                        startY = y
//                        startX =
//                            landmarks.getLandmark(getMap(117)).x * width
//                        startY =
//                            landmarks.getLandmark(getMap(117)).y * height
                    }

                    3 -> {
                        val (x, y) = getPointOnLine(
                            landmarks,
                            getMap(118),
                            getMap(35),
                            0.3F,
                            width,
                            height
                        )
                        startX = x
                        startY =  y
//                        startX =
//                            landmarks.getLandmark(getMap(118)).x * width
//                        startY =
//                            landmarks.getLandmark(getMap(118)).y * height

                    }
                    4 -> {
                        val (x, y) = getPointOnLine(
                            landmarks,
                            getMap(118),
                            getMap(119),
                            8,
                            width,
                            height
                        )
                        startX = x
                        startY =getPointOnLine(
                            landmarks,
                            getMap(118),
                            getMap(229),
                            4,
                            width,
                            height
                        ).second
                    }

                    5-> {
//                        val (x, y) = getPointOnLine(
//                            landmarks,
//                            getMap(118),
//                            getMap(230),
//                            3,
//                            width,
//                            height
//                        )
//                        startX = x
//                        startY = y
                    }
                    6-> {
                        val (x, y) = getPointOnLine(
                            landmarks,
                            getMap(119),
                            getMap(118),
                            0.4F,
                            width,
                            height
                        )
                        startX = x

                        startY =y

                    }

                    7-> {
                        val (x, y) = getPointOnLine(
                            landmarks,
                            getMap(119),
                            getMap(120),
                            8,
                            width,
                            height
                        )
                        startX = x
                        startY = getPointOnLine(
                            landmarks,
                            getMap(119),
                            getMap(120),
                            4,
                            width,
                            height
                        ).second
                    }
                    8-> {
                        val (x, y) = getPointOnLine(
                            landmarks,
                            getMap(120),
                            getMap(119),
                            3,
                            width,
                            height
                        )
                        startX = x
                        startY = (y).toFloat()
                    }
                    9-> {
                        val (x, y) = getPointOnLine(
                            landmarks,
                            getMap(120),
                            getMap(121),
                            4,
                            width,
                            height
                        )
                        startX = x
                        startY = (y)
                    }
                    10 -> {
                        val (x, y) = getPointOnLine(
                            landmarks,
                            getMap(121),
                            getMap(47),
                            8,
                            width,
                            height
                        )
                        startX = x
                        startY = (y)
                    }


                }
            }

            else -> {

            }
        }


        return Pair(startX, startY)
    }



}



class LeftTearGroup3mm() : BaseGroupInterface() {
    init {
        rows = listOf(10)
    }

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftTear3mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftTear3mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftTear3mm(currentRow, currentCol)
    }
}
class RightTear3mm:LeftTear3mm{
    constructor(rowIndex: Int, colIndex: Int) : super(rowIndex, colIndex) {
        isRight=true
        radius=5.5F
    }

}
class RightTearGroup3mm() : BaseGroupInterface() {
    init {
        rows = listOf(10)
    }

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightTear3mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightTear3mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightTear3mm(currentRow, currentCol)
    }
}


open class LeftNasolabial3mm(rowIndex: Int,colIndex: Int) : BaseCareInterface(rowIndex,colIndex) {



    //    override fun logNoseLandmark(result: FaceMeshResult, height: Int, width: Int, canvas: Canvas){
//        super.logNoseLandmark(result, height, width, canvas)
//        result?.let { handLandmarkerResult ->
//            for (landmarks in handLandmarkerResult.multiFaceLandmarks()) {
//                val (startX, startY) = calLandmark(
//                    landmarks,
//                    width,
//                    height
//                )
//                val (endX,endY)=this.getPointCoordinates(startX,startY,-153.43F,45F)
//                canvas.drawLine(startX,startY,endX,endY, pointPaint)
//            }
//
//        }
//    }
    override fun calLandmark(
        landmarks: LandmarkProto.NormalizedLandmarkList,
        width: Int,
        height: Int
    ): Pair<Float, Float> {

        var startX = -1.0F
        var startY = -1.0F
        when (col) {
            1 -> {
                val (x, y) = getPointOnLine(
                    landmarks,
                    getMap(36),
                    getMap(129),
                    3,
                    width,
                    height
                )
                startX = x
                startY = y
                val (ry, endY) = getPointOnLine(
                    landmarks,
                    getMap(36),
                    getMap(101),
                    3,
                    width,
                    height
                )

                val endX = getPointOnLine(
                    landmarks,
                    getMap(36),
                    getMap(50),
                    4,
                    width,
                    height
                ).first
                when (row) {

                    1->{
                        startX = endX
                        startY = endY

                    }
                    2->{
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/2F)
                        startX=newx
                        startY=newy
                    }

                    3 -> {

                    }
                }
            }
            2 -> {
                var (x, y) = getPointOnLine(
                    landmarks,
                    getMap(206),
                    getMap(203),
                    3,
                    width,
                    height
                )
                startX = x
                startY= getPointOnLine(
                    landmarks,
                    getMap(206),
                    getMap(203),
                    2,
                    width,
                    height
                ).second
                val endX =
                    landmarks.getLandmark(getMap(205)).x * width
                val endY =
                    landmarks.getLandmark(getMap(205)).y * height

                when (row) {

                    1->{
                        startX = endX
                        startY = endY

                    }
                    2->{
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/2F)
                        startX=newx
                        startY=newy
                    }

                    3 -> {

                    }
                }
            }
            3 -> {
                val (x, y) = getPointOnLine(
                    landmarks,
                    getMap(216),
                    getMap(207),
                    2,
                    width,
                    height
                )
                startX = x
                startY = y
                val (endX, endY) = getPointOnLine(
                    landmarks,
                    getMap(187),
                    getMap(207),
                    2,
                    width,
                    height
                )
                when (row) {
                    1->{
                        startX = endX
                        startY = endY

                    }
                    2->{
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/2F)
                        startX=newx
                        startY=newy
                    }

                    3 -> {

                    }
                }
            }
            4 -> {
                val (x, y) = getPointOnLine(
                    landmarks,
                    getMap(214),
                    getMap(202),
                    3,
                    width,
                    height
                )
                startX = x
                startY = y
                val (endX, endY) = getPointOnLine(
                    landmarks,
                    getMap(192),
                    getMap(214),
                    3,
                    width,
                    height
                )
                when (row) {
                    1->{
                        startX = endX
                        startY = endY

                    }
                    2->{
                        val (newx,newy)=getPointOnLine(startX,startY,endX,endY,1/2F)
                        startX=newx
                        startY=newy
                    }

                    3 -> {

                    }
                }
            }
            5 -> {
                when (row) {
                    1->{


                        val (x, y) = getPointOnLine(
                            landmarks,
                            getMap(169),
                            getMap(135),
                            2,
                            width,
                            height
                        )
                        startX = x
                        startY = y
                    }
                    2->{

                        startX =
                            landmarks.getLandmark(getMap(169)).x * width
                        startY =
                            landmarks.getLandmark(getMap(169)).y * height
                    }

                    3 -> {
                        val (x, y) = getPointOnLine(
                            landmarks,
                            getMap(169),
                            getMap(170),
                            2,
                            width,
                            height
                        )
                        startX = x
                        startY = y


                    }
                }
            }

            else -> {

            }
        }


        return Pair(startX, startY)
    }



}



class LeftNasolabialGroup3mm() : BaseGroupInterface() {
    init {
        rows = listOf(3,3,3,3,3)
    }

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftNasolabial3mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftNasolabial3mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return LeftNasolabial3mm(currentRow, currentCol)
    }
}
class RightNasolabial3mm:LeftNasolabial3mm{
    constructor(rowIndex: Int, colIndex: Int) : super(rowIndex, colIndex) {
        isRight=true

    }

}
class RightNasolabialGroup3mm() : BaseGroupInterface() {
    init {
        rows = listOf(3,3,3,3,3)
    }

    override fun createShot(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightNasolabial3mm(currentRow, currentCol)
    }

    override fun createDone(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightNasolabial3mm(currentRow, currentCol)
    }

    override fun createBefore(currentRow: Int, currentCol: Int): BaseCareInterface {
        return RightNasolabial3mm(currentRow, currentCol)
    }
}