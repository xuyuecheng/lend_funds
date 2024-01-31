package com.fund.funds.lucky.go.loan

import android.annotation.SuppressLint
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import com.fund.funds.lucky.go.loan.App.Companion.ins
import com.google.android.gms.ads.identifier.AdvertisingIdClient
import android.provider.Settings

class MainActivity : FlutterActivity() {
    private val CHANNEL = "lend_funds_plugin"
    private val REQUEST_CODE_LIVENESS = 1010
    private val REQUEST_CODE_PERMISSION = 1011
    private val REQUEST_ONE_CODE_PERMISSION = 1012
    private var channelResult: MethodChannel.Result? = null
    var mMethodChannelToFlutter: MethodChannel?=null

    @SuppressLint("HardwareIds")
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                CHANNEL
        ).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            when (call.method) {
                "getGoogleGaId" -> {
                    Thread {
                        run {
                            try {
                                if (ins.getGID.isEmpty()) {
                                    val advertisingIdInfo =
                                        AdvertisingIdClient.getAdvertisingIdInfo(applicationContext)
                                    ins.getGID = advertisingIdInfo.id.toString()
                                }
                                result.success(ins.getGID)
                            } catch (e: Exception) {
                                result.success(ins.getGID)
                            }
                        }
                    }.start()
                }
                "getAnId" -> {
                    try {
                        if (ins.getDeviceId.isEmpty()) {
                            ins.getDeviceId = Settings.Secure.getString(
                                this.contentResolver,
                                Settings.Secure.ANDROID_ID
                            )
                        }
                        result.success(ins.getDeviceId)
                    } catch (e: Exception) {
                        result.success(ins.getDeviceId)
                    }
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
        mMethodChannelToFlutter = MethodChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                "toFlutter"
        )
    }
}