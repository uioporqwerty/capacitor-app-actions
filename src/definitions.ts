import { PluginListenerHandle } from '@capacitor/core';
import { AppAction } from './app-action';

export interface AppActionsPlugin {
  set(actions: AppAction[]): Promise<void>
  addListener(actionId: string, listener: (info: any) => void) : Promise<PluginListenerHandle> & PluginListenerHandle
}
