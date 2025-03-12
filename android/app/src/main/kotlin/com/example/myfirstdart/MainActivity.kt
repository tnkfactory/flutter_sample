package com.example.myfirstdart

import android.os.Bundle
import android.os.PersistableBundle
import android.util.Log
import androidx.fragment.app.FragmentActivity
import com.tnkfactory.ad.TnkContext
import com.tnkfactory.ad.TnkOfferwall
import com.tnkfactory.ad.off.AdEventHandler
import com.tnkfactory.ad.rwd.TnkCore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity : FlutterFragmentActivity() {


    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        TnkOfferwall(this)

        var tnkContext:TnkContext? = null

        var mEventHandler: AdEventHandler? = null

        if (!TnkCore.isInitialized())
            TnkCore.init(this)
        if (this is FragmentActivity) {
            tnkContext = TnkContext(this)
            mEventHandler = AdEventHandler(this)
            Log.d("tnk", "is FragmentActivity")
        }else{
            Log.d("tnk", "not FragmentActivity")
        }

    }
}
