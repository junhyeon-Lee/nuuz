//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//
package com.google.mediapipe.solutioncore

import android.app.Activity
import android.content.Context
import android.graphics.SurfaceTexture
import android.util.Log
import android.util.Size
import com.google.mediapipe.components.*
import com.google.mediapipe.components.CameraHelper.OnCameraStartedListener
import com.google.mediapipe.framework.MediaPipeException
import com.google.mediapipe.framework.MediaPipeException.StatusCode
import javax.microedition.khronos.egl.EGLContext


class CameraInputFPS(activity: Context?) {
    private val cameraHelper = CameraXPreviewHelperFPS()
    private var customOnCameraStartedListener: OnCameraStartedListener? = null
    private var newFrameListener: TextureFrameConsumer? = null
    private var frameTexture: SurfaceTexture? = null
    private var converter: ExternalTextureConverter? = null

//    init {
//        PermissionHelper.checkAndRequestCameraPermissions(activity)
//    }

    fun setNewFrameListener(listener: TextureFrameConsumer?) {
        newFrameListener = listener
    }

    fun setOnCameraStartedListener(listener: OnCameraStartedListener?) {
        customOnCameraStartedListener = listener
    }

    fun start(
        activity: Context?,
        eglContext: EGLContext?,
        cameraFacing: CameraFacing,
        width: Int,
        height: Int
    ) {
//        if (PermissionHelper.cameraPermissionsGranted(activity)) {
            if (converter == null) {
                converter = ExternalTextureConverter(eglContext, 2)
            }
            if (newFrameListener == null) {
                throw MediaPipeException(
                    StatusCode.FAILED_PRECONDITION.ordinal,
                    "newFrameListener is not set."
                )
            } else {
                frameTexture = converter!!.surfaceTexture
                converter!!.setConsumer(newFrameListener)
                cameraHelper.setOnCameraStartedListener { surfaceTexture: SurfaceTexture? ->
                    if (width != 0 && height != 0) {
                        updateOutputSize(width, height)
                    }
                    if (customOnCameraStartedListener != null) {
                        customOnCameraStartedListener!!.onCameraStarted(surfaceTexture)
                    }
                }
                cameraHelper.startCamera(
                    activity!!,
                    if (cameraFacing == CameraFacing.FRONT) CameraHelper.CameraFacing.FRONT else CameraHelper.CameraFacing.BACK,
                    frameTexture,
                    if (width != 0 && height != 0) Size(width, height) else null
                )
            }
//        }
    }

    fun updateOutputSize(width: Int, height: Int) {
        val displaySize = cameraHelper.computeDisplaySizeFromViewSize(Size(width, height))
        val isCameraRotated = cameraHelper.isCameraRotated
        Log.i(
            "CameraInput",
            "Set camera output texture frame size to width=" + displaySize.width + " , height=" + displaySize.height
        )
        converter!!.setDestinationSize(
            if (isCameraRotated) displaySize.height else displaySize.width,
            if (isCameraRotated) displaySize.width else displaySize.height
        )
    }

    fun close() {
        if (converter != null) {
            converter!!.close()
        }
    }

    val isCameraRotated: Boolean
        get() = cameraHelper.isCameraRotated

    enum class CameraFacing {
        FRONT, BACK
    }

    companion object {
        private const val TAG = "CameraInput"
    }
}