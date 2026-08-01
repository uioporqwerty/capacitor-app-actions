import { WebPlugin } from '@capacitor/core';

import type { AddAppActionOptions, AppActionsPlugin } from './definitions';

export class AppActionsWeb extends WebPlugin implements AppActionsPlugin {
  async set(_options: AddAppActionOptions): Promise<void> {
    throw this.unavailable('App Actions are not available on the web.');
  }
}
