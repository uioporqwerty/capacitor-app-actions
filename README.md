<p align="center"><br><img src="https://user-images.githubusercontent.com/236501/85893648-1c92e880-b7a8-11ea-926d-95355b8175c7.png" width="128" height="128" /></p>
<h3 align="center">App Actions</h3>
<p align="center"><strong><code>@capacitor-community/app-actions</code></strong></p>
<p align="center">
  Capacitor iOS and Android Plugin for App Actions
</p>

<p align="center">
  <img src="https://img.shields.io/maintenance/yes/2020?style=flat-square" />
  <a href="https://github.com/capacitor-community/example/actions?query=workflow%3A%22CI%22"><img src="https://img.shields.io/github/workflow/status/capacitor-community/example/CI?style=flat-square" /></a>
  <a href="https://www.npmjs.com/package/@capacitor-community/example"><img src="https://img.shields.io/npm/l/@capacitor-community/example?style=flat-square" /></a>
<br>
  <a href="https://www.npmjs.com/package/@capacitor-community/example"><img src="https://img.shields.io/npm/dw/@capacitor-community/example?style=flat-square" /></a>
  <a href="https://www.npmjs.com/package/@capacitor-community/example"><img src="https://img.shields.io/npm/v/@capacitor-community/example?style=flat-square" /></a>
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
<a href="#contributors-"><img src="https://img.shields.io/badge/all%20contributors-0-orange?style=flat-square" /></a>
<!-- ALL-CONTRIBUTORS-BADGE:END -->
</p>

## Maintainers

| Maintainer | GitHub | Social |
| -----------| -------| -------|
| Nitish Sachar | [uioporqwerty](https://github.com/uioporqwerty) | [LinkedIn](https://linkedin.com/in/nitish-sachar) |

## Installation

```bash
npm install @capacitor-community/app-actions
npx cap sync
```

## Configuration

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

TODO
