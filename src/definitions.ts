declare module '@capacitor/core' {
  interface PluginRegistry {
    LoginPlugin: LoginPluginPlugin;
  }
}

export interface LoginPluginPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
