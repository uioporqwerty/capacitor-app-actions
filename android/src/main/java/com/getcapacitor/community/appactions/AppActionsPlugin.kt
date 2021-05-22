package com.getcapacitor.community.appactions

import android.content.Intent
import android.os.Build
import androidx.annotation.RequiresApi
import com.getcapacitor.Plugin
import com.getcapacitor.PluginCall
import com.getcapacitor.PluginMethod
import com.getcapacitor.annotation.CapacitorPlugin
import org.json.JSONException

@CapacitorPlugin(name = "AppActions")
class AppActionsPlugin : Plugin() {
    private var implementation: AppActions? = null

    override fun load() {
        super.load()
        implementation = AppActions(context, activity)
    }

    override fun handleOnNewIntent(intent: Intent) {
        super.handleOnNewIntent(intent)
        if (intent.hasExtra("ACTION_ID")) {
            notifyListeners(intent.getStringExtra("ACTION_ID"), null)
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.N_MR1)
    @PluginMethod
    fun set(call: PluginCall) {
        try {
            implementation?.set(call)
        } catch (ex: JSONException) {
            call.reject(ex.message)
        } catch (ex: Exception) {
            call.reject(ex.message)
        }
        call.resolve()
    }
}