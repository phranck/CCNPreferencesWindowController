[![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=phranck&url=https://github.com/phranck/CCNPreferencesWindowController&title=CCNPreferencesWindowController&tags=github&category=software)
[![No Maintenance Intended](http://unmaintained.tech/badge.svg)](http://unmaintained.tech/)


## Overview

`CCNPreferencesWindowController` is an Objective-C/Swift subclass of `NSWindowController` that automatically manages your custom view controllers for handling app preferences. 

Here is a shot of the included example application:

![CCNPreferencesWindowController Example Application](https://dl.dropbox.com/u/34133216/WebImages/Github/CCNPreferencesWindowController.gif)


## Integration

You can add `CCNPreferencesWindowController` by using CocoaPods. Just add this line to your Podfile:

```
pod 'CCNPreferencesWindowController'
```


## Usage

For the Objective-C version :

```Objective-C
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // init the preferences window controller
    self.preferences = [CCNPreferencesWindowController new];
    self.preferences.centerToolbarItems = YES;	// or NO

    // setup all preference view controllers
    [self.preferences setPreferencesViewControllers:@[
        [PreferencesGeneralViewController new],
        [PreferencesNetworkViewController new],
        [PreferencesBonjourViewController new]
    ]];
}


- (IBAction)showPreferencesWindow:(id)sender {
    [self.preferences showPreferencesWindow];
}

```

For the Swift version :

```Swift
private let generalController = GeneralPreferencesController()
private let advancedController = AdvancedPreferencesController()
private var preferencesController = CCNPreferencesWindowController()
    
func applicationDidFinishLaunching(aNotification: NSNotification) {
    preferencesController.viewControllers = [generalController, advancedController]
    preferencesController.centerToolbarItems  = true
}

@IBAction func showPreferences(sender: AnyObject?) {
    preferencesController.showPreferencesWindow()
}

```

That's all.


## Requirements

`CCNPreferencesWindowController` was written using ARC and "modern" Objective-C 2. At the moment it has only support for OS X 10.10 Yosemite. OS X 10.9 Mavericks should work too, but it's untested yet. The Swift version has been tested on El Capitan.


## Contribution

The code is provided as-is, and it is far from being complete or free of bugs. If you like this component feel free to support it. Make changes related to your needs, extend it or just use it in your own project. Pull-Requests and Feedbacks are very welcome. Just contact me at [phranck@cocoanaut.com](mailto:phranck@cocoanaut.com?Subject=[CCNPreferencesWindowController] Your component on Github) or send me a ping on Twitter [@TheCocoaNaut](http://twitter.com/TheCocoaNaut). 


## Documentation
The complete documentation you will find on [CocoaDocs](http://cocoadocs.org/docsets/CCNPreferencesWindowController/).


## License
This software is published under the [MIT License](http://cocoanaut.mit-license.org).


## Software that uses CCNPreferencesWindowController

* [Review Times](http://reviewtimes.cocoanaut.com) - A small Mac tool that shows you the calculated average of the review times for both the Mac App Store and the iOS App Store

