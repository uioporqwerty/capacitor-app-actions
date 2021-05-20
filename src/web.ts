import { WebPlugin } from '@capacitor/core';

import type { AppActionsPlugin } from './definitions';

export class AppActionsWeb extends WebPlugin implements AppActionsPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
