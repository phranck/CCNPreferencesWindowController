//
//  Preferences2ViewController.m
//  CCNPreferencesWindowController Example
//
//  Created by Frank Gregor on 19.01.15.
//  Copyright (c) 2015 cocoa:naut. All rights reserved.
//

#import "PreferencesNetworkViewController.h"
#import "CCNPreferencesWindowControllerProtocol.h"

@interface PreferencesNetworkViewController () <CCNPreferencesWindowControllerProtocol>
@end

@implementation PreferencesNetworkViewController

- (instancetype)init {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {

    }
    return self;
}

#pragma mark - CCNPreferencesWindowControllerDelegate

- (NSString *)preferenceIdentifier { return @"NetworkPreferencesIdentifier"; }
- (NSString *)preferenceTitle { return @"Network"; }
- (NSImage *)preferenceIcon { return [NSImage imageNamed:NSImageNameNetwork]; }

@end
