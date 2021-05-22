import { PluginListenerHandle } from '@capacitor/core';
import { AppAction } from './app-action';

export interface AddAppActionOptions {
  actions: AppAction[]
}

export interface AppActionsPlugin {
  /**
   * Set app actions for the app. Overrides any existing app actions.
   */
  set(options: AddAppActionOptions): Promise<void>

  /**
   * Listen for when an app action has been clicked by the user. actionId should match existing app actions.
   */
  addListener(actionId: string, listener: (info: any) => void) : Promise<PluginListenerHandle> & PluginListenerHandle
}
