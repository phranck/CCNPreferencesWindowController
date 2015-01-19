//
//  Created by Frank Gregor on 16.01.15.
//  Copyright (c) 2015 cocoa:naut. All rights reserved.
//

/*
 The MIT License (MIT)
 Copyright © 2014 Frank Gregor, <phranck@cocoanaut.com>
 http://cocoanaut.mit-license.org

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the “Software”), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import <AppKit/AppKit.h>

@interface CCNPreferencesWindowController : NSWindowController

@property (assign, nonatomic) BOOL titlebarAppearsTransparent;              // default: NO;     This is a forwarder for the used window.
@property (assign, nonatomic) BOOL showToolbarSeparator;                    // default: YES;    This is a forwarder for the toolbar.
@property (assign, nonatomic) BOOL showToolbarWithSingleViewController;     // default: NO;     If set to YES, the toolbar is always visible. Otherwise the toolbar will be only shown if there are more than one prefereceViewController.
@property (assign, nonatomic) BOOL centerToolbarItems;                      // default: YES;    If you set it to NO the toolbarItems will be left aligned
@property (assign, nonatomic) BOOL allowsVibrancy;                          // default: NO;     If set to YES then the contentView will be embedded in a NSVisualEffectView using blending mode NSVisualEffectBlendingModeBehindWindow.

- (void)setPreferencesViewControllers:(NSArray *)viewControllers;

- (void)showPreferencesWindow;
- (void)dismissPreferencesWindow;

@end
