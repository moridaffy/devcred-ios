<h1 align="center">
  <br>
  <img src="https://raw.githubusercontent.com/moridaffy/devcred-ios/master/Icon.png" alt="App Icon" width="300">
  <br>
  DevCred
  <br>
</h1>

<h4 align="center">Simple package for displaying credits to developer inside your app</h4>

<h1 align="center">
<img src="https://raw.githubusercontent.com/moridaffy/devcred-ios/master/screenshot_dark.png" width="250"> <img src="https://raw.githubusercontent.com/moridaffy/devcred-ios/master/screenshot_light.png" width="250">
</h1>

<p align="center">
  <a href="#Features">Features</a> •
  <a href="#How-to-use">How to use</a> •
  <a href="#Remote-json">Remote JSON</a> •
  <a href="#TODO">TODO</a> •
  <a href="#Developer">Developer</a>
</p>

## Features
* Display developer credits from anywhere inside your app modally or push to existing `UINavigationController`
* Customize background view (custom color or blurred)
* Allow your users to contact you through provided social links
* Cross-promote your apps from each other

## How to use
DevCred can be added to your project using SPM. Just add new package to your existing project by pasting this URL in Xcode:
```
https://github.com/moridaffy/devcred-ios
```

Then just configure DevCred and call `present` function to display it:
```swift
@objc private func creditsButtonTapped() {
  let localSource: DevCredInfoSource = .local(
      title: "Title to be displayed in navigation bar",
      developer: DevCredDeveloperInfo(
        name: "Write your name",
        description: "and your position",
        imageUrl: "https://upload.wikimedia.org/wikipedia/commons/d/d0/Apple_logo_Think_Different_vectorized.svg",
        links: [
          // add your social links here
        ]
      ),
      projects: [
        // list your projects here
      ])

    let config = DevCredConfig(
      infoSource: localSource,
      excludedBundleId: "host_app_bundle_id",   // pass host app bundle ID to exclude it from projects list
      presentationType: .modal,                 // present DevCred screen modally or by pushing into navigationController
      background: .blurDark,                    // DevCred screen background style
      accentColor: .red,                        // accent color used in DevCred screen for buttons, icons and etc
      textColor: .white                         // text color used in DevCred screen
    )
    DevCredRootView.present(config: config, from: self)
}
```

## Remote JSON
DevCred can also be configured using remote JSON which allows you to always keep your project list up to date across all your apps without need for regularly uploading new app builds to App Store. Just pass remote `infoSource` to `DevCredConfig`'s initializer with URL, containing valid JSON (example can be found <a href="https://mxm.codes/devcred.json">here</a>)
```swift
let config = DevCredConfig(
  infoSource: .remote(url: "https://developer.portfolio/path/to/json"),
  excludedBundleId: "host_app_bundle_id",
  presentationType: .modal,
  background: .blurDark,
  accentColor: .red,
  textColor: .white
)
DevCredRootView.present(config: config, from: self)
```

Remote source can also contain your project info in different languages. To do so pass a dictionary instead of just string to `name` field, for example:
```json
{
  "developer": {
    "name": {
      "en": "Maxim Skryabin",
      "ru": "Максим Скрябин"
    },
    "description": "Same description will be displayed to all users regardless their device language"
  }
}
```
This way DevCred gets device's language code (`Locale.current.languageCode`) and displays corresponding string. If user's device has unexpected language code - english string will be displayed.  

## TODO
- [ ] Caching of remote `infoSource`
- [ ] Get rid of `Kingfisher`
- [ ] Add support for fallback local source if no internet connection is available and cache is missing
- [X] Option to exclude current app from project list

## Developer
This package was created by Maxim Skryabin as a simple way of showcasing my apps inside my other apps. I also decided to make it easy to use for other developers by opensourcing it. Feel free to contact me using <a href="https://mxm.codes/contact-en/">my website</a>.

Icons used in this package are from <a href="https://www.iconfinder.com/search?q=&iconset=eon-social-media-contact-info-2">Eon - Social Media & Contact Info icons pack</a>
