#  CapacitorPlugin POC

Demonstrate creating a own plugin and integrate with an existed pwa application.

# How to Use

1. Add dependency package to your package.json to get via npm/yarn (package manager) then run `npm i`
```
"dependencies": {
    "@capacitor/android": "^2.4.0",
    "@capacitor/cli": "^2.4.0",
    "@capacitor/core": "^2.4.0",
    "@capacitor/ios": "^2.4.0",
    "capacitor-login-flow": "git+https://github.com/pycohub/CapacitorPluginPOC.git"
}
```
2. Add dependency to your podfile in `ios/App/Podfile`. Remember run `pod install`
```
target 'App' do
    capacitor_pods
    # Add your Pods here
    pod 'CapacitorLoginFlow', :path => '../../node_modules/capacitor-login-flow'
end
```
3. Consume Plugin
```
window.customElements.define('capacitor-welcome', class extends HTMLElement {
  constructor() {
    super();

    Capacitor.Plugins.SplashScreen.hide();
    
    const root = this.attachShadow({ mode: 'open' });

    root.innerHTML = `
    <style>
      :host {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
        display: block;
        width: 100%;
        height: 100%;
      }
      h1, h2, h3, h4, h5 {
        text-transform: uppercase;
      }
      .button {
        display: inline-block;
        padding: 10px;
        background-color: #73B5F6;
        color: #fff;
        font-size: 0.9em;
        border: 0;
        border-radius: 3px;
        text-decoration: none;
        cursor: pointer;
      }
      main {
        padding: 15px;
      }
      main hr { height: 1px; background-color: #eee; border: 0; }
      main h1 {
        font-size: 1.4em;
        text-transform: uppercase;
        letter-spacing: 1px;
      }
      main h2 {
        font-size: 1.1em;
      }
      main h3 {
        font-size: 0.9em;
      }
      main p {
        color: #333;
      }
      main pre {
        white-space: pre-line;
      }
    </style>
    <div>
      <capacitor-welcome-titlebar>
        <h1>Capacitor</h1>
      </capacitor-welcome-titlebar>
      <main>
        <p>
          Capacitor makes it easy to build powerful apps for the app stores, mobile web (Progressive Web Apps), and desktop, all
          with a single code base.
        </p>
        <h2>Getting Started</h2>
        <p>
          You'll probably need a UI framework to build a full-featured app. Might we recommend
          <a target="_blank" href="http://ionicframework.com/">Ionic</a>?
        </p>
        <p>
          Visit <a href="http://ionic-team.github.io/capacitor">ionic-team.github.io/capacitor</a> for information
          on using native features, building plugins, and more.
        </p>
        <a href="http://ionic-team.github.io/capacitor" target="_blank" class="button">Read more</a>
        <h2>Tiny Demo</h2>
        <p>
          This demo shows how to call Capacitor plugins. Say cheese!
        </p>
        <p>
          <button class="button" id="take-photo">Take Photo</button>
        </p>
        <p>
          <button class="button" id="invoke-native-ui">Invoke Native UIViewController</button>
        </p>
        <p>
          <img id="image" style="max-width: 100%">
        </p>
      </main>
    </div>
    `
  }

  connectedCallback() {
    const self = this;

    self.shadowRoot.querySelector('#take-photo').addEventListener('click', async function(e) {
      const { Camera } = Capacitor.Plugins;

      try {
        const photo = await Camera.getPhoto({
          resultType: "uri"
        });

        const image = self.shadowRoot.querySelector('#image');
        if (!image) {
          return;
        }
        
        image.src = photo.webPath;
      } catch (e) {
        console.warn('User cancelled', e);
      }
    });

    self.shadowRoot.querySelector('#invoke-native-ui').addEventListener('click', async function(e) {
      const { LoginPlugin } = Capacitor.Plugins;
      console.log('LoginPlugin = ' + LoginPlugin)
      
      const result = await LoginPlugin.showLogin({ value: "Hello NativeUI!" })
      console.log(result.value)
  })
  }
});

window.customElements.define('capacitor-welcome-titlebar', class extends HTMLElement {
  constructor() {
    super();
    const root = this.attachShadow({ mode: 'open' });
    root.innerHTML = `
    <style>
      :host {
        position: relative;
        display: block;
        padding: 15px 15px 15px 15px;
        text-align: center;
        background-color: #73B5F6;
      }
      ::slotted(h1) {
        margin: 0;
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
        font-size: 0.9em;
        font-weight: 600;
        color: #fff;
      }
    </style>
    <slot></slot>
    `;
  }
});

```

