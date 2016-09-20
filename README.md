# GeofenceDebugController

[![Version](https://img.shields.io/cocoapods/v/GeofenceDebugController.svg?style=flat)](http://cocoapods.org/pods/GeofenceDebugController)
[![License](https://img.shields.io/cocoapods/l/GeofenceDebugController.svg?style=flat)](http://cocoapods.org/pods/GeofenceDebugController)
[![Platform](https://img.shields.io/cocoapods/p/GeofenceDebugController.svg?style=flat)](http://cocoapods.org/pods/GeofenceDebugController)

## What is GeofenceDebugController?

GeofenceDebugController is debug tool for Geofence.
You can check geofences set in your app quickly.
Geofences can be confirmed on the screen of a list or map.

## ScreenShot

<img src="https://github.com/himaratsu/GeofenceDebugController/blob/master/screenshot/demo0.png?raw=true" width="480">

<img src="https://github.com/himaratsu/GeofenceDebugController/blob/master/screenshot/demo1.png?raw=true" width="480">

## Usage

Please import `GeofenceDebugController`, and call `show(viewController: UIViewController)` method at any point.

```swift
import GeofenceDebugController
```
```swift
GeofenceDebugController.show(self)
```

## Installation

GeofenceDebugController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GeofenceDebugController"
```

## Requirements

* iOS 8.0 and later
* Swift 2.3

## Author

Ryosuke Hiramatsu, himaratsu@gmail.com

## License

GeofenceDebugController is available under the MIT license. See the LICENSE file for more info.
