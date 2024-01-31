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
//    public var instantId: String = ""


//    val LOG_TAG = "AppsFlyerOneLinkSimApp"
//    val DL_ATTRS = "dl_attrs"
//    var conversionData: Map<String, Any>? = null
    companion object {
        lateinit var ins: App
    }

    override fun onCreate() {
        super.onCreate()
        ins = this
        setHeadData()
//        uploadInstanceId();

//        Log.e("LivenessAuth:", LivenessAuth.sdkVersion)
//
//        val afDevKey = "HJXmspJkyNEfoD8jQ532GJ"
//        val appsflyer = AppsFlyerLib.getInstance()
//        appsflyer.setMinTimeBetweenSessions(0)
//        appsflyer.setDebugLog(true)
//
//        val conversionListener: AppsFlyerConversionListener = object : AppsFlyerConversionListener {
//            override fun onConversionDataSuccess(conversionDataMap: Map<String, Any>) {
//                for (attrName in conversionDataMap.keys) Log.d(
//                    LOG_TAG,
//                    "Conversion attribute: " + attrName + " = " + conversionDataMap[attrName]
//                )
//                val status: String =
//                    Objects.requireNonNull(conversionDataMap["af_status"]).toString()
//                if (status == "Non-organic") {
//                    if (Objects.requireNonNull(conversionDataMap["is_first_launch"]).toString() == "true"
//                    ) {
//                        Log.d(LOG_TAG, "Conversion: First Launch")
//                    } else {
//                        Log.d(LOG_TAG, "Conversion: Not First Launch")
//                    }
//                } else {
//                    Log.d(LOG_TAG, "Conversion: This is an organic install.")
//                }
//                conversionData = conversionDataMap
//            }
//
//            override fun onConversionDataFail(errorMessage: String) {
//                Log.d(
//                    LOG_TAG,
//                    "error getting conversion data: $errorMessage"
//                )
//            }
//
//            override fun onAppOpenAttribution(attributionData: Map<String, String>) {
//                Log.d(LOG_TAG, "onAppOpenAttribution: This is fake call.")
//            }
//
//            override fun onAttributionFailure(errorMessage: String) {
//                Log.d(
//                    LOG_TAG,
//                    "error onAttributionFailure : $errorMessage"
//                )
//            }
//        }
//        appsflyer.init(afDevKey, conversionListener, this)
//        appsflyer.start(this)
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

//    @SuppressLint("MissingPermission")
//    private fun uploadInstanceId() {
//        FirebaseAnalytics.getInstance(this).appInstanceId.addOnCompleteListener(OnCompleteListener { task ->
//            if (task.isSuccessful) {
//               instantId = task.result
//            }
//        })
//    }
}