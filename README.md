<p align="left">
  <img src="https://raw.github.com/marciniwanicki/DFDiff/Resources/dfdiff.png" alt="DFDiff demo" title="DFDiff demo">
</p>

![Build status](https://travis-ci.org/marciniwanicki/DFDiff.svg?branch=develop)

This small and extramly simple Objective-C library might help you to find a set of simple operations (insert, delete, move) to transform one array into another i.e. @[A, B] -/diff/-> @[B, A], diff = [move(0, 1)]. Currently the library supports only single-dimensional arrays (`NSArray`). **It also provides a convinient way to animate reloading data in** `UITableView` 	&#128163; **.** 

<p align="center">
  <img src="https://raw.github.com/marciniwanicki/DFDiff/Resources/dfdiff-demo.gif" alt="DFDiff" title="DFDiff">
</p>

# How to use

First, all objects you want to store in arrays need to implement `DFDiffId` protocol where `- (NSString *)diffId` must be an unique string for every single item.

```objc
@interface DFArrayDiffDemoModelEntity : NSObject <DFDiffId>
```

To manage changes on `UITableView` you can use `DFTableDataReloader`. 
Create a new instance with reference to your table view

```objc
self.tableDataReloader = [DFTableDataReloader reloaderWithTableView:self.tableView];
```

and then pass new array whenever you need to refresh the table view (`- (void)reloadData:(NSArray <id <DFDiffId>> *)items;
`)

```objc
[self.tableDataReloader reloadData:dataArray];
```
If something is not clear please take a look at 	&#128640; DemoApp.

# Installation

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries. 

### Podfile

To integrate DFDiff into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
platform :ios, '7.0'

target 'TargetName' do
pod 'DFDiff', '~> 0.1.0'
end
```

# Problems?

Yup, sometimes happen ¯\\_(ツ)_/¯ &#9786; Please open a new Issue here if you run into a problem specific to DFDiff, have a feature request, or want to share a comment. 

Pull requests are encouraged and greatly appreciated! 	&#127866;

# License

DFDiff is available under the MIT license. See the LICENSE file for more info.

