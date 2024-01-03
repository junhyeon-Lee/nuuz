/*
 * Copyright 2022 The TensorFlow Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *             http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.ilooda.nuuz
import android.annotation.SuppressLint
import android.content.Context
import android.graphics.*
import android.util.AttributeSet
import android.util.Log
import android.view.View
import android.widget.FrameLayout
import com.google.mediapipe.formats.proto.LandmarkProto
import com.google.mediapipe.solutions.facemesh.FaceMeshResult
import java.util.concurrent.atomic.AtomicBoolean
import kotlin.math.PI
import kotlin.math.cos
import kotlin.math.sin
import kotlin.math.sqrt


abstract class BaseCareInterface(rowIndex: Int, colIndex: Int) {
    var row = rowIndex
    var col= colIndex
    var isRight=false


    fun getPointCoordinates(x0: Float, y0: Float, theta: Float, n: Float): Pair<Float, Float> {
        val x = x0 + n * cos(theta * PI / 180)
        val y = y0 + n * sin(theta * PI / 180)
        return Pair(x.toFloat(), y.toFloat())
    }




    fun calculateExtendedPoint(x1: Float, y1: Float, x2: Float, y2: Float, n: Float): Pair<Float, Float> {
        val dx = x2 - x1
        val dy = y2 - y1
        val distance = sqrt(dx * dx + dy * dy)
        val factor = n / distance
        val newX = x2 + factor * dx
        val newY = y2 + factor * dy
        return Pair(newX, newY)
    }
    fun getExtendedPointOnLine(landmarks: LandmarkProto.NormalizedLandmarkList,pos1: Int, pos2: Int, n: Float, width: Int, height: Int): Pair<Float, Float> {
        val x1=landmarks.getLandmark(pos1).x*width
        val y1=landmarks.getLandmark(pos1).y*height
        val x2=landmarks.getLandmark(pos2).x*height
        val y2=landmarks.getLandmark(pos2).y*height
        val distance=sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
        return calculateExtendedPoint(x1,y1,x2,y2,n*distance)
    }
    fun getPointOnLine(landmarks: LandmarkProto.NormalizedLandmarkList,pos1: Int, pos2: Int, n: Float, width: Int, height: Int): Pair<Float, Float> {
        val x1=landmarks.getLandmark(pos1).x*width
        val y1=landmarks.getLandmark(pos1).y*height
        val x2=landmarks.getLandmark(pos2).x*height
        val y2=landmarks.getLandmark(pos2).y*height
        val x = x1 + (x2 - x1) * n
        val y = y1 + (y2 - y1) * n
        return Pair(x, y)
    }
    fun getPointOnLine(landmarks: LandmarkProto.NormalizedLandmarkList,pos1: Int, pos2: Int, n: Int, width: Int, height: Int): Pair<Float, Float> {
        val x1=landmarks.getLandmark(pos1).x*width
        val y1=landmarks.getLandmark(pos1).y*height
        val x2=landmarks.getLandmark(pos2).x*height
        val y2=landmarks.getLandmark(pos2).y*height
        val x = x1 + (x2 - x1) / n
        val y = y1 + (y2 - y1) / n
        return Pair(x, y)
    }
    fun getPointOnLine(x1:Float,y1:Float,x2:Float,y2:Float,n:Int): Pair<Float, Float>{
        val x = x1 + (x2 - x1) / n
        val y = y1 + (y2 - y1) / n
        return Pair(x, y)
    }
    fun getPointOnLine(x1:Float,y1:Float,x2:Float,y2:Float,n:Float): Pair<Float, Float>{
        val x = x1 + (x2 - x1) *n
        val y = y1 + (y2 - y1) * n
        return Pair(x, y)
    }

    open fun logNoseLandmark(result: FaceMeshResult, height: Int, width: Int, canvas: Canvas): MutableList<Float> {
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
//                Log.d("radius","$radius")
                canvas.drawCircle(startX,startY,radius, pointPaint)
            }


        }
        return points
    }

    abstract fun calLandmark(landmarks: LandmarkProto.NormalizedLandmarkList, width: Int, height: Int): Pair<Float, Float>
    fun getMap(pos: Int): Int {
        return if (isRight)
            posmap[pos] ?: pos
        else pos
    }
    fun getMap(pos: Int, isRight:Boolean): Int {
        return if (isRight)
            posmap[pos] ?: pos
        else pos
    }

    var  radius=6F
    var pointPaint = Paint()

    init {
        pointPaint.color = Color.RED
        pointPaint.strokeWidth = 6F
        pointPaint.style = Paint.Style.FILL
    }

    init {
        if (rowIndex == 1) {
            pointPaint.color = Color.WHITE
            //pointPaint.color = Color.parseColor("#FF00B8")
            pointPaint.strokeWidth = 1F
        } else {
            pointPaint.color = Color.WHITE
            pointPaint.strokeWidth = 1F
        }
        pointPaint.style = Paint.Style.FILL
    }

}

abstract class BaseGroupInterface {
    var row = 1
    var col = 1
    var lastx=1.0F
    var lasty=1.0F
    var last_col = 1
    val isUpdate = AtomicBoolean(false)
    var rows = listOf(5, 10, 5)
    var careItems = ArrayList<BaseCareInterface>()
    var linePaint = Paint()
    private var pointPaint = Paint()
    init{
        linePaint.color = Color.CYAN

        linePaint.strokeWidth = 4F
        linePaint.style = Paint.Style.FILL
//        linePaint.setStyle(Paint.Style.STROKE)
//        linePaint.setPathEffect(DashPathEffect(floatArrayOf(10f, 10f), 0f))

        pointPaint.color =  Color.parseColor("#FF00B8")
        pointPaint.strokeWidth = 6F
        pointPaint.style = Paint.Style.FILL
    }
    open fun close() {
        careItems.clear()
    }
    fun addRow(){changePosition(row,col+1)}
    fun changePosition(rowIndex: Int, colIndex: Int) {
        var testrow = rowIndex
        var testcol = colIndex
        if (testcol > rows.size) testcol = 1;
        if (testrow > rows[testcol - 1]) {
            testcol++;
            testrow = 1;
        }

        if (testcol > rows.size) testcol = 1;
        col = testcol
        row = testrow
        lastx = 1.0F
        lasty = 1.0F
    }
    open fun active() {
//        layout.removeAllViews()
//         careItems.clear()
    }

    open fun logNoseLandmark(
        bitmap:Bitmap,
        result: FaceMeshResult,
        height: Int,
        width: Int,
        layout: FrameLayout,
        view:OverlayView

    ) {
//        if (isUpdate.get()   || result.multiFaceLandmarks().isEmpty()) return
        val th=0.01
        val canvas=Canvas(bitmap)
        try {
//            lastx=result.multiFaceLandmarks()[0].landmarkList[0].x
//            lasty=result.multiFaceLandmarks()[0].landmarkList[0].y
            val lines = mutableListOf<Float>()
            val points = mutableListOf<Float>()
            layout.post {
                //  if (careItems.isEmpty())layout.removeAllViews()
                var changerow = careItems.isEmpty()
                if (last_col != col ) {
                    Log.d("group", "Move col")
                    // layout.removeAllViews()
                    careItems.clear()
                    changerow = true

                }
                if(false) {
                    changerow=careItems.isEmpty()
                    for (i in 0 until rows.size){
                        for (j in 0 until rows[i]) {
                            val currentRow = j + 1
                            val currentCol = i+1
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
                    for(item in careItems){
                        item.logNoseLandmark(result, height, width, canvas)
                    }
                }else {
                    for (j in 0 until rows[col-1]) {
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
                        val pts=( careItems[j].logNoseLandmark(result, height, width, canvas))
                        if ( careItems[j].row==1){
                            points.addAll(pts)
                        }
                        lines.addAll(pts)
                        lines.addAll(pts)
                    }
                }
//                if(lines.size>2) {
//                    lines.removeAt(0)
//                    lines.removeAt(0)
//                }
                //     canvas.drawLines(lines.toFloatArray(),linePaint)
//                canvas.drawPoints(points.toFloatArray(),pointPaint)
                view.setResults(bitmap,result,width,height)
                last_col = col
            }

        } finally {
            isUpdate.set(false)
        }


    }

    abstract fun createShot(currentRow:Int, currentCol:Int):BaseCareInterface
    abstract fun createDone(currentRow:Int, currentCol:Int):BaseCareInterface
    abstract fun createBefore(currentRow:Int, currentCol:Int):BaseCareInterface
}
class OverlayView(context: Context, attrs: AttributeSet?) :
    View(context, attrs) {

    private var dr: Bitmap? = null
    private var results: FaceMeshResult? = null
    private var linePaint = Paint()
    private var pointPaint = Paint()

    private var scaleFactor: Float = 1f
    private var imageWidth: Int = 1
    private var imageHeight: Int = 1

    init {
        initPaints()

    }

    fun clear() {
        results = null
        linePaint.reset()
        pointPaint.reset()
        invalidate()
        initPaints()
    }

    private fun initPaints() {
        linePaint.color = Color.CYAN

        linePaint.strokeWidth = LANDMARK_STROKE_WIDTH
        linePaint.style = Paint.Style.STROKE

        pointPaint.color = Color.RED
        pointPaint.strokeWidth = 6F
        pointPaint.style = Paint.Style.FILL
    }


    override fun draw(canvas: Canvas) {
        super.draw(canvas)
        this.dr?.let {
//            val cv = Canvas(it)
//            results?.let { handLandmarkerResult ->
//                val lines = mutableListOf<Float>()
//                val points = mutableListOf<Float>()
//
//                for (landmarks in handLandmarkerResult.multiFaceLandmarks()) {
//
//                    for (i in landmarkConnections.indices step 3) {
//                        scaleFactor = 1.0f
//                        val movew =
//                            0//if(moveX) (width/2-imageWidth/2)/2 else 0//width/2-imageWidth/2
//                        val moveh =
//                            0//if(!moveX) (height/2-imageHeight/2)/2 else 0//height/2-imageHeight/2
//                        val startX =
//                            landmarks.getLandmark(landmarkConnections[i]).x * imageWidth * scaleFactor - (movew)
//                        val startY =
//                            landmarks.getLandmark(landmarkConnections[i]).y * imageHeight * scaleFactor - ((moveh))
//                        val endX =
//                            landmarks.getLandmark(landmarkConnections[i + 1]).x * imageWidth * scaleFactor - (movew)
//                        val endY =
//                            landmarks.getLandmark(landmarkConnections[i + 1]).y * imageHeight * scaleFactor - ((moveh))
//                        val lastX =
//                            landmarks.getLandmark(landmarkConnections[i + 2]).x * imageWidth * scaleFactor - (movew)
//                        val lastY =
//                            landmarks.getLandmark(landmarkConnections[i + 2]).y * imageHeight * scaleFactor - ((moveh))
//                        lines.add(endX)
//                        lines.add(endY)
//                        lines.add((lastX + endX) / 2)
//                        lines.add((lastY + endY) / 2)
//                        lines.add(lastX)
//                        lines.add(lastY)
//                        points.add(startX)
//                        points.add(startY)
//
//                    }
//                    cv.drawPoints(lines.toFloatArray(), linePaint)
//                    cv.drawPoints(points.toFloatArray(), pointPaint)
//                }
//
//            }
            if(! it.isRecycled()) {
                canvas.drawBitmap(it, null, scaleCenterCrop(it, this.height, this.width), null)
                it.recycle()
            }
        }
    }

    fun scaleCenterCrop(source: Bitmap, newHeight: Int, newWidth: Int): RectF {
        val sourceWidth = source.width
        val sourceHeight = source.height

        // Compute the scaling factors to fit the new height and width, respectively.
        // To cover the final image, the final scaling will be the bigger
        // of these two.
        val xScale = newWidth.toFloat() / sourceWidth
        val yScale = newHeight.toFloat() / sourceHeight
        val scale = Math.max(xScale, yScale)

        // Now get the size of the source bitmap when scaled
        val scaledWidth = scale * sourceWidth
        val scaledHeight = scale * sourceHeight

        // Let's find out the upper left coordinates if the scaled bitmap
        // should be centered in the new size give by the parameters
        val left = (newWidth - scaledWidth) / 2
        val top = (newHeight - scaledHeight) / 2

        // The target rectangle for the new, scaled version of the source bitmap will now
        // be
        val targetRect = RectF(left, top, left + scaledWidth, top + scaledHeight)
        return targetRect
//        // Finally, we create a new bitmap of the specified size and draw our new,
//        // scaled bitmap onto it.
//        val dest = Bitmap.createBitmap(newWidth, newHeight, source.config)
//        val canvas = Canvas(dest)
//        canvas.drawBitmap(source, null, targetRect, null)
//        return dest
    }

    var moveX = true

    @SuppressLint("SuspiciousIndentation")
    fun setResults(
        bitMap: Bitmap,
        handLandmarkerResults: FaceMeshResult,
        imageHeight: Int,
        imageWidth: Int,


        ) {
        this.dr = bitMap
        results = handLandmarkerResults

        this.imageHeight = imageHeight
        this.imageWidth = imageWidth
//        //  Timber.d("p:"+previewWidth+" "+previewHeight+"atual"+width+" "+height)
//        scaleFactor =
//
//                // PreviewView is in FILL_START mode. So we need to scale up the
//                // landmarks to match with the size that the captured images will be
//                // displayed.
//            max(width * 1f / imageWidth, height * 1f / imageHeight)
//        if (width * 1f / imageWidth > height * 1f / imageHeight) moveX = false
//        Log.d("scale", "result to screen with $scaleFactor height:$imageHeight width:$imageWidth")
        invalidate()
    }

    companion object {
        private const val LANDMARK_STROKE_WIDTH = 4F

        // This list defines the lines that are drawn when visualizing the hand landmark detection
        // results. These lines connect:
        // landmarkConnections[2*n] and landmarkConnections[2*n+1]
        private val landmarkConnections = listOf(
            123, 147, 213, 119, 101, 206
        )
    }
}
