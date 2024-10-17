package com.finniu

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.os.Bundle
import android.net.Uri

class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL = "com.finniu/deeplink"
    private val ENGINE_ID = "my_engine_id"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initializeFlutterEngine()
        handleIntent(intent)
    }

    private fun initializeFlutterEngine() {
        if (FlutterEngineCache.getInstance().get(ENGINE_ID) == null) {
            val flutterEngine = FlutterEngine(this).apply {
                dartExecutor.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
            }
            FlutterEngineCache.getInstance().put(ENGINE_ID, flutterEngine)
        }
    }

    override fun provideFlutterEngine(context: android.content.Context): FlutterEngine? {
        return FlutterEngineCache.getInstance().get(ENGINE_ID)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "initialLink" -> result.success(intent?.data?.toString())
                "getDeepLinkScheme" -> result.success(BuildConfig.DEEP_LINK_SCHEME)
                else -> result.notImplemented()
            }
        }
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent?) {
        intent?.data?.let { uri ->
            if (isValidDeepLink(uri)) {
                val deepLink = uri.toString()
                FlutterEngineCache.getInstance().get(ENGINE_ID)?.dartExecutor?.binaryMessenger?.let { binaryMessenger ->
                    MethodChannel(binaryMessenger, CHANNEL).invokeMethod("handleDeepLink", deepLink)
                }
            }
        }
    }

    private fun isValidDeepLink(uri: Uri): Boolean {
        return uri.scheme == BuildConfig.DEEP_LINK_SCHEME || uri.scheme == "https"
    }
}