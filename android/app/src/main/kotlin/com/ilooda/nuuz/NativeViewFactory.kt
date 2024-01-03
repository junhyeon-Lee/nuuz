package com.ilooda.nuuz
import android.content.Context
import android.view.View
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.platform.PlatformViewFactory
//import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.BasicMessageChannel
//import io.flutter.plugin.common.StandardMessageCodec
import android.app.Activity
internal class NativeView(context: Activity, id: Int,messenger: BinaryMessenger, creationParams: Map<String?, Any?>?) : PlatformView,BasicMessageChannel.MessageHandler<Any> {
    private val textView: FaceView
    private val MESSAGE_CHANNEL_PATH = "careMessageChannelPath"
    //   lateinit var  messageChannel:BasicMessageChannel
    fun onAttachedToEngine(messenger:BinaryMessenger) {
        val messageChannel = BasicMessageChannel(
            messenger,
            MESSAGE_CHANNEL_PATH,
            StandardMessageCodec.INSTANCE
        )
        messageChannel.setMessageHandler(this)
    }


    override fun onMessage(
        message: Any?,
        reply: BasicMessageChannel.Reply<Any>
    ) {
        message?.let {

            val mapParams = it as Map<String, Any>;
            if (mapParams.containsKey("nextRow")){
                android.util.Log.d("flutter msg", "call next row")
                textView.nextRow()
            }
            if (mapParams.containsKey("range")) {
                val range = mapParams["range"] as Int
                val column = mapParams["column"] as Int
                val name= mapParams["name"] as String
                textView.changeRegion(name,range,column)


                android.util.Log.d("flutter msg", "current row $range col $column")
            }
            if (mapParams.containsKey("scaleX")){
                val x = (mapParams["scaleX"] as Double).toFloat()
                val y = (mapParams["scaleY"] as Double).toFloat()
//                activeCare?.setScale(x,y)
            }
            if (mapParams.containsKey("close")){
                textView.dispose()
            }
            reply.reply(createResult(200, "received"))
        }
    }

    private fun createResult(code: Int, data: String): HashMap<String, Any> {
        var result = HashMap<String, Any>()
        result["code"] = code
        result["data"] = data
        return result
    }

    override fun getView(): View {
        return textView
    }
    override fun onFlutterViewAttached(  flutterView:View){
        textView.restart()
    }
    override fun onFlutterViewDetached(){
        textView.stop()
    }
    override fun dispose() {
        textView.dispose()

    }

    init {
        textView = FaceView(context,null)
        this.onAttachedToEngine(messenger)
        creationParams?.let {
            if (it.containsKey("region")) {
                textView.changeRegion(it["region"]!! as String,1,1)
            }
            if (it.containsKey("type") ){
                if( "3mm"==it["type"]){
                    textView.is3mm=true
                }else{
                    textView.is3mm=false
                }
            }
        }
    }
}

class NativeViewFactory (private val registrar: Registrar): PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        val messenger: BinaryMessenger=registrar.messenger()
        return NativeView(registrar.activity()!!, viewId,messenger, creationParams)
    }
}