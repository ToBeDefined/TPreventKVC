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

[English Document](README.md)

</div>

### 特点

使用runtime动态替换方法防止在使用KVC的方法时候产生 `NSUnknownKeyException` & `NSInvalidArgumentException` 错误引发崩溃

- `-valueForKey:`
- `setValue:forKey:`
- `-setValue:forKeyPath:`
- `-valueForKeyPath:`等等


### 如何导入

#### 源文件

将`TPreventKVC`文件夹内部的所有文件拖入项目中即可

#### CocoaPods

[`CocoaPods`](https://cocoapods.org/)是一个Cocoa项目管理器。你可以使用以下命令去安装`CocoaPods`:

```bash
$ gem install cocoapods
```

要使用CocoaPods将`TPreventKVC`集成到您的Xcode项目中，请在`Podfile`中加入：

```ruby
pod 'TPreventKVC'
```

然后运行一下命令:

```bash
$ pod install
```

#### Carthage


[`Carthage`](https://github.com/Carthage/Carthage)是一个去中心化的依赖管理器，它构建并提供所使用的库的framework。

你可以使用 [`Homebrew`](https://brew.sh/)并运行下面的命令安装Carthage

```bash
$ brew update
$ brew install carthage
```

要将`TPreventKVC`集成到使用Carthage的Xcode项目中，请在`Cartfile`中加入：

```ruby
github "tobedefined/TPreventKVC"
```

运行`carthage update`构建framework，并将编译的对应平台的`TPreventKVC.framework`拖入Xcode项目中。

### 使用方法

#### 简单使用

导入项目之后即可。

#### 运行错误信息获取

在APP的 **`main.m`文件的`main()`函数中** 或者 **在APP的`didFinishLaunching`方法中** 加入以下代码可以获得缺失方法的具体信息：

```objc
[NSObject setHandleKVCErrorBlock:^(__unsafe_unretained Class cls, NSString *key, KVCErrorType errorType) {
    // 在这里写你要做的事情
    // 比如上传到服务器或者打印log等
}];
```


##### Some Definitions

在`NSObject+PreventKVC.h`中有以下定义

```objc
typedef NS_ENUM(NSUInteger, KVCErrorType) {
    KVCErrorTypeSetValueForUndefinedKey     = 1,
    KVCErrorTypeValueForUndefinedKey        = 2,
    KVCErrorTypeSetNilValueForKey           = 3,
};

typedef void (^ __nullable HandleKVCErrorBlock)(Class cls, NSString *key, KVCErrorType errorType);
```

- `cls`: `Class`类型；为产生错误的类或对象的Class，可使用`NSStringFromClass(cls)`返回类名字符串
- `key`: `NSString *`类型；为产生错误的Key
- `errorType`: `KVCErrorType`类型；为产生错误的类型
- `callStackSymbols`: `NSArray<NSString *> *`类型；为调用栈信息

