import { PluginListenerHandle } from '@capacitor/core';
import { AppAction } from './app-action';

export interface AddAppActionOptions {
  actions: AppAction[]
}

export interface AppActionsPlugin {
  set(options: AddAppActionOptions): Promise<void>
  addListener(actionId: string, listener: (info: any) => void) : Promise<PluginListenerHandle> & PluginListenerHandle
}
