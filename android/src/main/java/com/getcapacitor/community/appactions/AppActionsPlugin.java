package com.getcapacitor.community.appactions;

import com.getcapacitor.JSArray;
import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

import org.json.JSONException;
import org.json.JSONObject;

@CapacitorPlugin(name = "AppActions")
public class AppActionsPlugin extends Plugin {

    private AppActions implementation = new AppActions();

    @PluginMethod
    public void set(PluginCall call) {
        System.out.println("set from appactions plugin");
//        try {
//            JSArray actions = call.getArray("actions");
//
//            for (int i = 0; i < actions.length(); i++) {
//                JSONObject action = actions.getJSONObject(i);
//                System.out.println(action.get("id"));
//            }
//        } catch (JSONException ex) {
//
//        }
        call.resolve();
    }
}
