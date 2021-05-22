package com.getcapacitor.community.appactions

import android.app.Activity
import android.content.Context
import android.content.Intent
import androidx.core.content.pm.ShortcutInfoCompat
import androidx.core.content.pm.ShortcutManagerCompat
import androidx.core.graphics.drawable.IconCompat
import com.getcapacitor.PluginCall
import java.util.ArrayList

class AppActions(val context: Context,
                 val activity: Activity) {

    fun set(call: PluginCall) {
        ShortcutManagerCompat.removeAllDynamicShortcuts(context)

        val actions = call.getArray("actions")
        val shortcuts: MutableList<ShortcutInfoCompat?> = ArrayList<ShortcutInfoCompat?>()
        for (i in 0 until actions.length()) {
            val action = actions.getJSONObject(i)
            val appAction = AppAction(action.getString("id").trim(),
                                      action.getString("title").trim())

            if (action.has("subtitle"))
                appAction.subtitle = action.getString("subtitle").trim()

            if (action.has("icon"))
                appAction.icon = action.getString("icon").trim()

            val shortcutInfoBuilder = ShortcutInfoCompat.Builder(context, appAction.id)
                    .setShortLabel(appAction.title)
                    .setIntent(Intent(context, activity.javaClass)
                            .setAction(Intent.ACTION_MAIN)
                            .setPackage(context.packageName)
                            .setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            .putExtra("ACTION_ID", action.getString("id").trim { it <= ' ' })
                    )

            if (appAction.subtitle?.isNotEmpty() == true)
                shortcutInfoBuilder.setLongLabel(appAction.subtitle!!)

            if (appAction.icon?.isNotEmpty() == true) {
                val iconResId = context.resources.getIdentifier(appAction.icon, "drawable", context.packageName)
                if (iconResId != 0)
                    shortcutInfoBuilder.setIcon(IconCompat.createWithResource(context, iconResId))
            }

            shortcuts.add(shortcutInfoBuilder.build())
        }

        ShortcutManagerCompat.addDynamicShortcuts(context, shortcuts)
    }
}