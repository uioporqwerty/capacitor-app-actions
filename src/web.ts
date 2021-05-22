import { PluginListenerHandle, WebPlugin } from '@capacitor/core';

import type { AddAppActionOptions, AppActionsPlugin } from './definitions';

export class AppActionsWeb extends WebPlugin implements AppActionsPlugin {
  set(options: AddAppActionOptions): Promise<void> {
    throw new Error('Method not implemented.');
  }

  addListener(actionId: string, listener: (info: any) => void): Promise<PluginListenerHandle> & PluginListenerHandle {
    throw new Error('Method not implemented.');
  }
}
