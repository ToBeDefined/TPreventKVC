<div align="center">

TPreventKVC
------

</div>

<div align="center">

![platform](https://img.shields.io/badge/Platform-iOS%20%7C%20tvOS%20%7C%20macOS%20%7C%20watchOS-brightgreen.svg)&nbsp;
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)&nbsp;
[![CocoaPods](https://img.shields.io/badge/Cocoapods-compatible-brightgreen.svg?style=flat)](http://cocoapods.org/)&nbsp;
[![Build Status](https://travis-ci.org/ToBeDefined/TPreventKVC.svg?branch=master)](https://travis-ci.org/ToBeDefined/TPreventKVC)&nbsp;
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/tobedefined/TPreventKVC/blob/master/LICENSE)

</div>

<div align="center">

[中文文档](README_CN.md)

</div>


### 特点

使用runtime动态替换方法防止在使用KVC的方法时候产生 `NSUnknownKeyException` & `NSInvalidArgumentException` 错误引发崩溃

- `-valueForKey:`
- `setValue:forKey:`
- `-setValue:forKeyPath:`
- `-valueForKeyPath:`等等


### Installation

#### Source File

Drag all the files inside the `TPreventKVC` folder in the corresponding module directory into you project.

#### CocoaPods

[`CocoaPods`](https://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate `TPreventKVC` into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'TPreventKVC'
```

Then, run the following command:

```bash
$ pod install
```

#### Carthage

[`Carthage`](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [`Homebrew`](https://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate `TPreventKVC` into your Xcode project using Carthage, specify it in your `Cartfile`:

```ruby
github "tobedefined/TPreventKVC"
```

Run `carthage update` to build the framework and drag the built `TPreventKVC.framework` into your Xcode project.

### How to use

After importing the project.

##### Set Block Get Error Infomation

In the  **`main()` function of the APP's `main.m` file**  or  **in the APP's `didFinishLaunching` method**  add the following code to get the specific information about the missing method:

```objc
[NSObject setHandleKVCErrorBlock:^(__unsafe_unretained Class cls, NSString *key, KVCErrorType errorType) {
    // DO SOMETHING
    // like upload to server or print log or others
}];
```

##### 一些定义

The following definitions and methods are in `NSObject+PreventKVC.h`

```objc
typedef NS_ENUM(NSUInteger, KVCErrorType) {
    KVCErrorTypeSetValueForUndefinedKey     = 1,
    KVCErrorTypeValueForUndefinedKey        = 2,
    KVCErrorTypeSetNilValueForKey           = 3,
};

typedef void (^ __nullable HandleKVCErrorBlock)(Class cls, NSString *key, KVCErrorType errorType);
```

- `cls`: `Class` type; use `NSStringFromClass(cls)` to return a class name string for a Class that produces the wrong class or object
- `key`: `NSString *` type; the key to generate the error
- `errorType`: `KVCErrorType`; the type that generated the error
- `callStackSymbols`: `NSArray<NSString *> *` type; call stack infomations


