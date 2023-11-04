package com.example.ocean_change

import io.flutter.embedding.android.FlutterActivity
import com.google.firebase.appcheck.debug.DebugAppCheckProviderFactory
import com.google.firebase.appcheck.ktx.appCheck
import com.google.firebase.ktx.Firebase
import com.google.firebase.ktx.initialize

class MainActivity: FlutterActivity() {

    private fun initDebug(){
        
        Firebase.initialize(context = this)
        Firebase.appCheck.installAppCheckProviderFactory(
        DebugAppCheckProviderFactory.getInstance(),
    )
    }
    
}
