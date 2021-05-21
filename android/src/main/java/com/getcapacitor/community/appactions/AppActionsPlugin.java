package com.getcapacitor.community.appactions;

import android.content.Intent;
import android.os.Build;

import androidx.annotation.RequiresApi;
import androidx.core.content.pm.ShortcutInfoCompat;
import androidx.core.content.pm.ShortcutManagerCompat;

import com.getcapacitor.JSArray;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

import static android.content.Intent.FLAG_ACTIVITY_CLEAR_TOP;
import static android.content.Intent.FLAG_ACTIVITY_SINGLE_TOP;

@CapacitorPlugin(name = "AppActions")
public class AppActionsPlugin extends Plugin {

    private AppActions implementation = new AppActions();

    @RequiresApi(api = Build.VERSION_CODES.N_MR1)
    @PluginMethod
    public void set(PluginCall call) {
        try {
            ShortcutManagerCompat.removeAllDynamicShortcuts(getContext());
            JSArray actions = call.getArray("actions");
            List<ShortcutInfoCompat> shortcuts = new ArrayList();

            for (int i = 0; i < actions.length(); i++) {
                JSONObject action = actions.getJSONObject(i);

                ShortcutInfoCompat.Builder s = new ShortcutInfoCompat.Builder(getContext(), action.getString("id"))
                        .setShortLabel(action.getString("title"));

                if (action.has("subtitle")) {
                    s.setLongLabel(action.getString("subtitle"));
                }

                Intent shortcutIntent = new Intent(Intent.ACTION_MAIN);
                shortcutIntent.setPackage(getContext().getPackageName());
                shortcutIntent.setFlags(FLAG_ACTIVITY_CLEAR_TOP | FLAG_ACTIVITY_SINGLE_TOP);
                s.setIntent(shortcutIntent);
                shortcuts.add(s.build());
            }

            ShortcutManagerCompat.addDynamicShortcuts(getContext(), shortcuts);
        } catch (JSONException ex) {
            call.reject(ex.getMessage());
        }
        call.resolve();
    }
}
