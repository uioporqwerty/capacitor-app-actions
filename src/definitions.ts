import { AppAction } from './app-action';
export interface AppActionsPlugin {
  set(actions: AppAction[]): Promise<void>
}
