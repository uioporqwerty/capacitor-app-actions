import type { PluginListenerHandle } from '@capacitor/core';

import type { AppAction } from './app-action';

export interface AddAppActionOptions {
  actions: AppAction[];
}

/**
 * Data passed to an app action listener when the action is triggered.
 */
export interface AppActionEvent {
  /**
   * The `id` of the app action that was triggered.
   */
  actionId: string;
}

export interface AppActionsPlugin {
  /**
   * Set app actions for the app. Overrides any existing app actions.
   */
  set(options: AddAppActionOptions): Promise<void>;

  /**
   * Listen for when an app action has been clicked by the user.
   * `actionId` should match the `id` of an existing app action.
   */
  addListener(actionId: string, listener: (info: AppActionEvent) => void): Promise<PluginListenerHandle>;
}
