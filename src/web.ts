import { WebPlugin } from '@capacitor/core';
import { LoginPluginPlugin } from './definitions';

export class LoginPluginWeb extends WebPlugin implements LoginPluginPlugin {
  constructor() {
    super({
      name: 'LoginPlugin',
      platforms: ['web'],
    });
  }

  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}

const LoginPlugin = new LoginPluginWeb();

export { LoginPlugin };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(LoginPlugin);
