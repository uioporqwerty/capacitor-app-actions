import { PluginListenerHandle, WebPlugin } from '@capacitor/core';
import { AppAction } from './app-action';

import type { AppActionsPlugin } from './definitions';

export class AppActionsWeb extends WebPlugin implements AppActionsPlugin {
  set(actions: AppAction[]): Promise<void> {
    throw new Error('Method not implemented.');
  }

  addListener(actionId: string, listener: (info: any) => void): Promise<PluginListenerHandle> & PluginListenerHandle {
    throw new Error('Method not implemented.');
  }
}
