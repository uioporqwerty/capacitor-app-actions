package com.getcapacitor.community.appactions

import android.content.Intent
import android.os.Build
import androidx.annotation.RequiresApi
import com.getcapacitor.JSObject
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
        // Cold launch: the activity was started by the shortcut itself, so the
        // action arrives in the launch intent (handleOnNewIntent is only called
        // when the activity is already running).
        handleActionIntent(activity?.intent)
    }

    override fun handleOnNewIntent(intent: Intent) {
        super.handleOnNewIntent(intent)
        // Warm launch: the app was already running in the background.
        handleActionIntent(intent)
    }

    private fun handleActionIntent(intent: Intent?) {
        val actionId = intent?.getStringExtra("ACTION_ID") ?: return
        // Consume the extra so the same action isn't re-emitted on later
        // lifecycle events (e.g. configuration changes).
        intent.removeExtra("ACTION_ID")
        val data = JSObject().put("actionId", actionId)
        // retainUntilConsumed delivers the event once a JS listener subscribes,
        // covering the cold-launch case where the web layer isn't ready yet.
        notifyListeners(actionId, data, true)
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