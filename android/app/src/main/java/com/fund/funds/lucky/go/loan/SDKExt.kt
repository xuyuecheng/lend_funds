package com.fund.funds.lucky.go.loan

import android.annotation.SuppressLint
import android.content.Context
import com.android.installreferrer.api.InstallReferrerClient
import com.android.installreferrer.api.InstallReferrerStateListener
import com.android.installreferrer.api.ReferrerDetails


@SuppressLint("NewApi")
object SDKExt {
//    fun uploadFirebaseToken(callback: ((map: HashMap<String, Any>) -> Unit)? = null) {
//        FirebaseMessaging.getInstance().token.addOnCompleteListener(object :
//            OnCompleteListener<String> {
//            override fun onComplete(@NonNull task: Task<String?>) {
//
//                if (!task.isComplete || !task.isSuccessful)
//                    return
//                val token: String = task.result.toString()
//                if (token.isNotEmpty()) {
//                    val mFirebaseMessaging: HashMap<String, Any> = HashMap()
//                    mFirebaseMessaging["model"] = token
//                    callback?.invoke(mFirebaseMessaging)
//                }
//            }
//        })
//    }
//
//    fun uploadInstanceId(
//        context: Context,
//        callback: ((map: HashMap<String, Any>) -> Unit)? = null
//    ) {
//        FirebaseAnalytics.getInstance(context).appInstanceId.addOnCompleteListener(
//            OnCompleteListener { task ->
//                if (!task.isComplete || !task.isSuccessful) return@OnCompleteListener
//                val id = task.result
//                if (id != null && id.isNotEmpty()) {
//                    val aasdas: HashMap<String, Any> = HashMap()
//                    aasdas["model"] = id
//                    callback?.invoke(aasdas)
//                }
//            })
//    }

    fun initInstallReferrer(
        context: Context,
        callback: ((map: HashMap<String, Any>) -> Unit)? = null
    ) {
        val referrerClient = InstallReferrerClient.newBuilder(context).build()
        referrerClient.startConnection(object : InstallReferrerStateListener {
            override fun onInstallReferrerSetupFinished(responseCode: Int) {
                when (responseCode) {
                    InstallReferrerClient.InstallReferrerResponse.OK -> {
                        try {
                            val response: ReferrerDetails = referrerClient.installReferrer
                            val qweqwewqe: MutableMap<String, String> = HashMap()
                            if (response.installReferrer != null) {
                                qweqwewqe["installReferrer"] = response.installReferrer
                            }
                            if (response.installVersion != null) {
                                qweqwewqe["installVersion"] = response.installVersion
                            }
                            qweqwewqe["googlePlayInstantParam"] =
                                response.googlePlayInstantParam.toString()
                            qweqwewqe["installBeginTimestampSeconds"] =
                                response.installBeginTimestampSeconds.toString()
                            qweqwewqe["installBeginTimestampServerSeconds"] =
                                response.installBeginTimestampServerSeconds.toString()
                            qweqwewqe["referrerClickTimestampSeconds"] =
                                response.referrerClickTimestampSeconds.toString()
                            qweqwewqe["referrerClickTimestampServerSeconds"] =
                                response.referrerClickTimestampServerSeconds.toString()
                            val ewqeqeee: HashMap<String, Any> = HashMap()
                            ewqeqeee["modelU8mV9A"] = qweqwewqe
                            callback?.invoke(ewqeqeee)
                        } catch (e: Exception) {
                            e.printStackTrace()
                        }
                    }
                    InstallReferrerClient.InstallReferrerResponse.FEATURE_NOT_SUPPORTED -> {
                        val fffdssm: HashMap<String, Any> = HashMap()
                        val rerrerr: HashMap<String, Any> = HashMap()
                        rerrerr["error"] = "NOT_SUPPORTED"
                        fffdssm["modelU8mV9A"] = rerrerr
                        callback?.invoke(fffdssm)
                    }
                    InstallReferrerClient.InstallReferrerResponse.SERVICE_UNAVAILABLE -> {
                        val model: HashMap<String, Any> = HashMap()
                        val req: HashMap<String, Any> = HashMap()
                        req["error"] = "SERVICE_UNAVAILABLE"
                        model["modelU8mV9A"] = req
                        callback?.invoke(model)
                    }
                }
            }

            override fun onInstallReferrerServiceDisconnected() {}
        })
    }

//    fun initBranch(context: Context) {
//        Branch.enableLogging()
//        Branch.getAutoInstance(context)
//        FirebaseApp.initializeApp(context)
//    }


//    private const val firstInstallKey = "firstInstall"
//    private const val storeWebKey = "web_params"
//    const val webReplaceUrl = "loan_web_url:"
//    var result: String by preferences("", storeWebKey)
//    var firstKey: Boolean by preferences(false, firstInstallKey)
//
//    fun getChannelParameters(
//        context: Context,
//        callback: ((map: HashMap<Any, Any>) -> Unit)? = null
//    ) {
//        val handler = Handler()
//        val count = intArrayOf(0)
//
//        val runnable: Runnable = object : Runnable {
//            override fun run() {
//                if (result.isEmpty()) {
//                    val nMap: HashMap<Any, Any> = HashMap()
//                    val clipboardManager: ClipboardManager =
//                        context.getSystemService(Context.CLIPBOARD_SERVICE) as ClipboardManager
//                    val clipData: ClipData? = clipboardManager.primaryClip
//                    if (clipData != null) {
//                        for (i in 0 until clipData.itemCount) {
//                            val item: ClipData.Item = clipData.getItemAt(i)
//                            if (item != null) {
//                                var copiedText: String = item.text.toString()
//                                if (copiedText.startsWith(webReplaceUrl) && copiedText.contains("?")) {
//                                    copiedText =
//                                        copiedText.replaceFirst(webReplaceUrl.toRegex(), "")
//                                    val uri: Uri = Uri.parse(copiedText)
//                                    if (uri != null) {
//                                        val parameterNames: Set<String> =
//                                            uri.queryParameterNames
//                                        for (paramName in parameterNames) {
//                                            val paramValue: String? =
//                                                uri.getQueryParameter(paramName)
//                                            if (paramValue != null) {
//                                                nMap[paramName] = paramValue
//                                            }
//                                        }
//                                        result = nMap.toJson().toString()
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//                count[0]++
//                if (count[0] < 10 && result.isEmpty()) {
//                    handler.postDelayed(this, 2000)
//                    return
//                }
//                val b: Boolean = firstKey
//
//                var fbMap: HashMap<Any, Any> = HashMap<Any, Any>()
//                if (result.isNotEmpty()) {
//                    fbMap = result.toMap<Any, Any>()
//                }
//                if (!b) {
//                    fbMap["fbInstall"] = true
//                }
//                val map: HashMap<Any, Any> = HashMap()
//                map["model"] = fbMap
//                Log.e("getChannelParameters:", map.toJson().toString())
//                ExecutionModule_ExecutorFactory.executor().execute {
//                    callback?.invoke(map)
//                }
//            }
//
//        }
//        handler.postDelayed(runnable, 1000)
//    }
//
//    fun setFirstKey(
//    ) {
//        firstKey = true
//    }
}

