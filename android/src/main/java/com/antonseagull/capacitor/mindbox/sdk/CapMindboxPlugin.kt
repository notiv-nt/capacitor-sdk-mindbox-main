package com.antonseagull.capacitor.mindbox.sdk

import android.app.Activity
import android.content.Context
import android.os.Handler
import com.getcapacitor.*
import com.getcapacitor.annotation.CapacitorPlugin
import cloud.mindbox.mobile_sdk.Mindbox
import cloud.mindbox.mobile_sdk.MindboxConfiguration
import cloud.mindbox.mobile_sdk.inapp.presentation.InAppCallback
import cloud.mindbox.mobile_sdk.inapp.presentation.callbacks.*
import org.json.JSONObject

@CapacitorPlugin(name = "CapMindbox")
class CapMindboxPlugin : Plugin() {
    private var deviceUuidSubscription: String? = null
    private var fmsTokenSubscription: String? = null

    private  var isInitialized = false
    @PluginMethod
    fun initialize(call: PluginCall) {

        if (isInitialized) {
            call.resolve(JSObject().put("result", true))
            return
        }

        var domain:String = call.getString("domain","api.mindbox.ru") ?: "api.mindbox.ru";
       var endpointId:String = call.getString("endpointId","") ?:  "";


        if(endpointId == ""){
            call.reject("endpointId is required")
            return
        }




        try {

            val context: Context = activity.applicationContext
            val activity: Activity? = activity

            if (activity != null && context != null) {
                val configurationBuilder =
                        MindboxConfiguration.Builder(
                            context = context,
                            domain = domain,
                            endpointId =endpointId
                        )

                var subscribeCustomerIfCreated = call.getBoolean("subscribeCustomerIfCreated",false);
                var shouldCreateCustomer = call.getBoolean("shouldCreateCustomer",true);
                var previousInstallId = call.getString("previousInstallId","");
                var previousUuid = call.getString("previousUuid","");



                configurationBuilder.subscribeCustomerIfCreated(subscribeCustomerIfCreated ?: false)
                    configurationBuilder.shouldCreateCustomer(shouldCreateCustomer?:true)
                configurationBuilder.setPreviousInstallationId(previousInstallId ?: "");
                    configurationBuilder.setPreviousDeviceUuid(previousUuid ?: "");

                val configuration = configurationBuilder.build()

                val handler = Handler(context.mainLooper)
                handler.post {
                    Mindbox.init(activity, configuration, listOf())
                }

                isInitialized = true

                call.resolve(JSObject().put("result", true))
            } else {
                call.resolve(JSObject().put("result", false))
            }
        } catch (error: Throwable) {
            call.reject("Error initializing Mindbox")
        }
    }

    @PluginMethod
    fun registerCallbacks(call: PluginCall) {
        val callbacks = call.getArray("callbacks")
        if (callbacks == null) {
            call.reject("callbacks array is required")
            return
        }

        val cb = mutableListOf<InAppCallback>()
        for (i in 0 until callbacks.length()) {
            when (val callback = callbacks.getString(i)) {
                "urlInAppCallback" -> {
                    cb.add(UrlInAppCallback())
                    cb.add(DeepLinkInAppCallback())
                    cb.add(LoggingInAppCallback())
                }
                "copyPayloadInAppCallback" -> {
                    cb.add(CopyPayloadInAppCallback())
                    cb.add(LoggingInAppCallback())
                }
                "emptyInAppCallback" -> {
                    cb.add(EmptyInAppCallback())
                }
                else -> {
                    cb.add(object : InAppCallback {
                        override fun onInAppClick(id: String, redirectUrl: String, payload: String) {
                            val params = JSObject().apply {
                                put("id", id)
                                put("redirectUrl", redirectUrl)
                                put("payload", payload)
                            }
                            notifyListeners("Click", params)
                        }

                        override fun onInAppDismissed(id: String) {
                            val params = JSObject().apply {
                                put("id", id)
                            }
                            notifyListeners("Dismiss", params)
                        }
                    })
                }
            }
        }
        Mindbox.registerInAppCallback(ComposableInAppCallback(cb))
        call.resolve()
    }

    @PluginMethod
    fun getDeviceUUID(call: PluginCall) {
        try {
            if (this.deviceUuidSubscription != null) {
                Mindbox.disposeDeviceUuidSubscription(this.deviceUuidSubscription!!)
            }

            this.deviceUuidSubscription = Mindbox.subscribeDeviceUuid { deviceUUID ->
                call.resolve(JSObject().put("deviceUUID", deviceUUID))
            }
        } catch (error: Throwable) {
            call.reject("Error getting device UUID")
        }
    }

    @PluginMethod
    fun getFMSToken(call: PluginCall) {
        try {
            if (this.fmsTokenSubscription != null) {
                Mindbox.disposePushTokenSubscription(this.fmsTokenSubscription!!)
            }

            this.fmsTokenSubscription = Mindbox.subscribePushToken { fmsToken ->
                call.resolve(JSObject().put("fmsToken", fmsToken))
            }
        } catch (error: Throwable) {
            call.reject("Error getting FMS token")
        }
    }

    @PluginMethod
    fun updateFMSToken(call: PluginCall) {
        val token = call.getString("token")
        if (token == null) {
            call.reject("token is required")
            return
        }

        try {
            Mindbox.updatePushToken(activity.applicationContext, token)
            call.resolve()
        } catch (error: Throwable) {
            call.reject("Error updating FMS token")
        }
    }

    @PluginMethod
    fun executeAsyncOperation(call: PluginCall) {
        val operationSystemName = call.getString("operationSystemName")
        val operationBody = call.getString("operationBody")

        if (operationSystemName == null || operationBody == null) {
            call.reject("operationSystemName and operationBody are required")
            return
        }

        Mindbox.executeAsyncOperation(activity.applicationContext, operationSystemName, operationBody)
        call.resolve()
    }

    @PluginMethod
    fun executeSyncOperation(call: PluginCall) {
        val operationSystemName = call.getString("operationSystemName")
        val operationBody = call.getString("operationBody")

        if (operationSystemName == null || operationBody == null) {
            call.reject("operationSystemName and operationBody are required")
            return
        }

        Mindbox.executeSyncOperation(
            context = activity.applicationContext,
            operationSystemName = operationSystemName,
            operationBodyJson = operationBody,
            onSuccess = { response ->
                call.resolve(JSObject().put("response", response))
            },
            onError = { error ->
                call.resolve(JSObject().put("error", error.toJson()))
            }
        )
    }

    @PluginMethod
    fun setLogLevel(call: PluginCall) {
        val level = call.getInt("level")
        if (level == null) {
            call.reject("level is required")
            return
        }

        val logLevel: cloud.mindbox.mobile_sdk.logger.Level = cloud.mindbox.mobile_sdk.logger.Level.values()[level]
        Mindbox.setLogLevel(logLevel)
        call.resolve()
    }

    @PluginMethod
    fun getSdkVersion(call: PluginCall) {
        try {
            call.resolve(JSObject().put("sdkVersion", Mindbox.getSdkVersion()))
        } catch (error: Throwable) {
            call.reject("Error getting SDK version")
        }
    }

    @PluginMethod
    fun pushDelivered(call: PluginCall) {
        val uniqKey = call.getString("uniqKey")
        if (uniqKey == null) {
            call.reject("uniqKey is required")
            return
        }

        Mindbox.onPushReceived(
            context = activity.applicationContext,
            uniqKey = uniqKey,
        )
        call.resolve()
    }

    @PluginMethod
    fun updateNotificationPermissionStatus(call: PluginCall) {
        val granted = call.getBoolean("granted") ?: false
        Mindbox.updateNotificationPermissionStatus(
            context = activity.applicationContext,

        )
        call.resolve()
    }
}