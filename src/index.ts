import { registerPlugin } from '@capacitor/core';

import type { AppActionsPlugin } from './definitions';

const AppActions = registerPlugin<AppActionsPlugin>('AppActions', {
  web: () => import('./web').then(m => new m.AppActionsWeb()),
});

export * from './definitions';
export { AppActions };
