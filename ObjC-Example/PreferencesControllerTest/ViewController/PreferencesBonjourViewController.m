//
//  PreferencesBonjourViewController.m
//  CCNPreferencesWindowController Example
//
//  Created by Frank Gregor on 19.01.15.
//  Copyright (c) 2015 cocoa:naut. All rights reserved.
//

#import "PreferencesBonjourViewController.h"
#import "CCNPreferencesWindowControllerProtocol.h"

@interface PreferencesBonjourViewController () <CCNPreferencesWindowControllerProtocol>
@end

@implementation PreferencesBonjourViewController

- (instancetype)init {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {

    }
    return self;
}

#pragma mark - CCNPreferencesWindowControllerDelegate

- (NSString *)preferenceIdentifier { return @"BonjourPreferencesIdentifier"; }
- (NSString *)preferenceTitle { return @"Bonjour"; }
- (NSImage *)preferenceIcon { return [NSImage imageNamed:NSImageNameBonjour]; }

@end
