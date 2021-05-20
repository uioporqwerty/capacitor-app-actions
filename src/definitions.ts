export interface AppActionsPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
