package com.getcapacitor.community.appactions

import android.app.Activity
import android.content.Context
import androidx.core.content.pm.ShortcutManagerCompat
import androidx.test.core.app.ApplicationProvider
import com.getcapacitor.JSArray
import com.getcapacitor.JSObject
import com.getcapacitor.PluginCall
import org.junit.Assert.assertEquals
import org.junit.Assert.assertTrue
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.Robolectric
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [34])
class AppActionsTest {

    private fun pluginCall(data: JSObject): PluginCall {
        return PluginCall(null, "AppActions", "callback-id", "set", data)
    }

    @Test
    fun set_registersDynamicShortcuts() {
        val context = ApplicationProvider.getApplicationContext<Context>()
        val activity = Robolectric.buildActivity(Activity::class.java).get()

        val actions = JSArray().apply {
            put(JSObject().apply {
                put("id", "order")
                put("title", "Order")
                put("subtitle", "Place an Order")
            })
            put(JSObject().apply {
                put("id", "order_2")
                put("title", "Hello")
            })
        }
        val call = pluginCall(JSObject().apply { put("actions", actions) })

        AppActions(context, activity).set(call)

        // getDynamicShortcuts() does not guarantee ordering, so index by id.
        val shortcuts = ShortcutManagerCompat.getDynamicShortcuts(context).associateBy { it.id }
        assertEquals(2, shortcuts.size)
        val order = shortcuts.getValue("order")
        assertEquals("Order", order.shortLabel.toString())
        assertEquals("Place an Order", order.longLabel.toString())
        assertTrue(shortcuts.containsKey("order_2"))
    }

    @Test
    fun set_overwritesPreviousShortcuts() {
        val context = ApplicationProvider.getApplicationContext<Context>()
        val activity = Robolectric.buildActivity(Activity::class.java).get()
        val impl = AppActions(context, activity)

        val first = JSArray().apply {
            put(JSObject().apply {
                put("id", "one")
                put("title", "One")
            })
        }
        impl.set(pluginCall(JSObject().apply { put("actions", first) }))

        val second = JSArray().apply {
            put(JSObject().apply {
                put("id", "two")
                put("title", "Two")
            })
        }
        impl.set(pluginCall(JSObject().apply { put("actions", second) }))

        val shortcuts = ShortcutManagerCompat.getDynamicShortcuts(context)
        assertEquals(1, shortcuts.size)
        assertEquals("two", shortcuts[0].id)
    }
}
