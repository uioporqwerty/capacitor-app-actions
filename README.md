<p align="center"><br><img src="https://user-images.githubusercontent.com/236501/85893648-1c92e880-b7a8-11ea-926d-95355b8175c7.png" width="128" height="128" /></p>

<h3 align="center">App Actions</h3>
<p align="center"><strong><code>capacitor-app-actions</code></strong></p>
<p align="center">
  Capacitor iOS and Android Plugin for App Actions
</p>

<p align="center">
  <img src="https://img.shields.io/maintenance/yes/2021?style=flat-square" />
  <a href="https://github.com/uioporqwerty/capacitor-app-actions/actions?query=workflow%3A%22Plugin-CI%22"><img src="https://img.shields.io/github/workflow/status/uioporqwerty/capacitor-app-actions/Plugin-CI?style=flat-square" /></a>
  <a href="https://www.npmjs.com/package/capacitor-app-actions"><img src="https://img.shields.io/npm/l/capacitor-app-actions?style=flat-square" /></a>
<br>
  <a href="https://www.npmjs.com/package/capacitor-app-actions"><img src="https://img.shields.io/npm/dw/capacitor-app-actions?style=flat-square" /></a>
  <a href="https://www.npmjs.com/package/capacitor-app-actions"><img src="https://img.shields.io/npm/v/capacitor-app-actions?style=flat-square" /></a>
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
<a href="#contributors-"><img src="https://img.shields.io/badge/all%20contributors-1-orange?style=flat-square" /></a>
<!-- ALL-CONTRIBUTORS-BADGE:END -->
</p>

## Maintainers

| Maintainer | GitHub | Social |
| -----------| -------| -------|
| Nitish Sachar | [uioporqwerty](https://github.com/uioporqwerty) | [LinkedIn](https://linkedin.com/in/nitish-sachar) |

## Installation

```bash
npm install capacitor-app-actions
npx cap sync
```

## Configuration

Android:

No additional configuration required.

iOS:

Add the following to `AppDelegate.swift`. This snippet allows the plugin to recognize when an app action has been selected so that you can respond to those events.

```swift
func application(_ application: UIApplication,
                   performActionFor shortcutItem: UIApplicationShortcutItem,
                   completionHandler: @escaping (Bool) -> Void)
{
    NotificationCenter.default.post(name: NSNotification.Name("appActionReceived"), object: nil, userInfo: ["actionId" : shortcutItem.type])
}
```

## Usage

Typically app actions are added at application startup, but you can add them where appropriate:

```
import { AppActions } from 'capacitor-app-actions'

await Capacitor.Plugins.AppActions.set({ "actions": [ 
    { id: "order", title: "Order", subtitle: "Place an Order", icon: "star.fill" }, 
    { id: "locations", title: "Find location", subtitle: "Find nearby location", icon: "star.fill"}
  ]});
```
Listen to an event triggered by an existing app action:

```
AppActions.addListener("order", (info) => {
    // Do your in app work. Navigate to the appropriate page or trigger other in app actions.
  });
```
## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/uioporqwerty"><img src="https://avatars.githubusercontent.com/u/4053751?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Nitish Sachar</b></sub></a><br /><a href="#maintenance-uioporqwerty" title="Maintenance">🚧</a> <a href="https://github.com/uioporqwerty/capacitor-app-actions/commits?author=uioporqwerty" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!