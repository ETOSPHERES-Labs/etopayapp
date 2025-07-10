package com.etospheres.etopay

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
// Import the ETOPay SDK
import com.etospheres.etopay.ETOPaySdk

class MainActivity: FlutterActivity() {
    private val CHANNEL = "etopay_sdk"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "createWallet" -> {
                    val password = call.argument<String>("password")
                    val pin = call.argument<String>("pin")
                    val config = call.argument<String>("config")
                    val username = call.argument<String>("username")
                    val accessToken = call.argument<String>("accessToken")
                    try {
                        val sdk = ETOPaySdk()
                        sdk.setConfig(config)
                        sdk.refreshAccessToken(accessToken)
                        sdk.createNewUser(username)
                        sdk.initializeUser(username)
                        sdk.setWalletPassword(pin, password)
                        val mnemonic = sdk.createWallet(pin)
                        result.success(mnemonic.split(" "))
                    } catch (e: Exception) {
                        result.error("ETOPAY_ERROR", e.localizedMessage, null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}
