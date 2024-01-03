package com.ilooda.nuuz

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "com.ilooda.nuuz/face"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        val shimPluginRegistry = ShimPluginRegistry(flutterEngine)
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("<platform-view-type>", NativeViewFactory(shimPluginRegistry.registrarFor("Flutter")))
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
//                call, result ->
//            if (call.method == "showFace") {
//                val lottie: java.util.HashMap<Any,Any>? = call.arguments()
//
//                val myIntent = Intent(this, FaceActivity::class.java)
//                lottie?.let {
//                    val flottie: String? =( lottie.get("test")).toString()
//                    android.util.Log.d("passed lottie file", ( lottie.get("lottie")).toString())
//                    android.util.Log.d("passed file",  ""+flottie)
//                    myIntent.putExtra("lottie", flottie) //Optional parameters
//                }
//
//                this.startActivity(myIntent)
//            } else {
//                result.notImplemented()
//            }
//        }
    }
}
