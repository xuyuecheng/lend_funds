package com.fund.funds.lucky.go.loan

import android.annotation.SuppressLint
import android.provider.Settings
//import android.util.Log
//import com.appsflyer.AppsFlyerConversionListener
//import com.appsflyer.AppsFlyerLib
//import com.fintek.liveness.lib.utils.entity.LivenessAuth
import com.google.android.gms.ads.identifier.AdvertisingIdClient
//import com.google.android.gms.tasks.OnCompleteListener
//import com.google.firebase.analytics.FirebaseAnalytics
import io.flutter.app.FlutterApplication
import java.util.*


class App : FlutterApplication() {

    public var getGID : String = ""
    public var getDeviceId : String = ""
    companion object {
        lateinit var ins: App
    }

    override fun onCreate() {
        super.onCreate()
        ins = this
        setHeadData()
        SDKExt.initBranch(this)
    }

    @SuppressLint("HardwareIds")
    public fun setHeadData(){
        Thread {
            run {
                try {
                    val advertisingIdInfo =
                        AdvertisingIdClient.getAdvertisingIdInfo(applicationContext)
                    getGID = advertisingIdInfo.id.toString()
                } catch (e: Exception) {
                }
                getDeviceId = Settings.Secure.getString(
                    this.contentResolver,
                    Settings.Secure.ANDROID_ID
                )
            }
        }.start()
    }
}