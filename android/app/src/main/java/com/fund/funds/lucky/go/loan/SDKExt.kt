package com.fund.funds.lucky.go.loan

import android.annotation.SuppressLint
import android.content.Context
import com.android.installreferrer.api.InstallReferrerClient
import com.android.installreferrer.api.InstallReferrerStateListener
import com.android.installreferrer.api.ReferrerDetails
import com.google.firebase.FirebaseApp
import io.branch.referral.Branch


@SuppressLint("NewApi")
object SDKExt {
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

    fun initBranch(context: Context) {
        Branch.enableLogging()
        Branch.getAutoInstance(context)
        FirebaseApp.initializeApp(context)
    }
}

