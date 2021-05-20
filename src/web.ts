import { WebPlugin } from '@capacitor/core';
import { AppAction } from './app-action';

import type { AppActionsPlugin } from './definitions';

export class AppActionsWeb extends WebPlugin implements AppActionsPlugin {
  set(actions: AppAction[]): Promise<void> {
    return Promise.resolve();
  }
}
