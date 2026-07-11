package com.ethicnology.subterfuge

import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity

// This app displays cryptographic secrets (mnemonics/seeds/shares).
// FLAG_SECURE prevents this window's content from appearing in
// screenshots, screen recordings/casting, and the "Recent apps" (task
// switcher) thumbnail on Android.
class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        window.setFlags(
            WindowManager.LayoutParams.FLAG_SECURE,
            WindowManager.LayoutParams.FLAG_SECURE
        )
        super.onCreate(savedInstanceState)
    }
}
