//
//  PreferencesGeneralViewController.m
//  CCNPreferencesWindowController Example
//
//  Created by Frank Gregor on 19.01.15.
//  Copyright (c) 2015 cocoa:naut. All rights reserved.
//

#import "PreferencesGeneralViewController.h"
#import "CCNPreferencesWindowControllerProtocol.h"

@interface PreferencesGeneralViewController () <CCNPreferencesWindowControllerProtocol>
@end

@implementation PreferencesGeneralViewController

- (instancetype)init {
    self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
    if (self) {

    }
    return self;
}

#pragma mark - CCNPreferencesWindowControllerDelegate

- (NSString *)preferenceIdentifier { return @"GeneralPreferencesIdentifier"; }
- (NSString *)preferenceTitle { return @"General"; }
- (NSImage *)preferenceIcon { return [NSImage imageNamed:NSImageNamePreferencesGeneral]; }

@end
