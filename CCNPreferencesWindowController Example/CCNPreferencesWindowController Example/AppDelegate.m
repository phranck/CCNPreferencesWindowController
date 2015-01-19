//
//  AppDelegate.m
//  CCNPreferencesWindowController Example
//
//  Created by Frank Gregor on 19.01.15.
//  Copyright (c) 2015 cocoa:naut. All rights reserved.
//

#import "AppDelegate.h"
#import "CCNPreferencesWindowController.h"

#import "PreferencesGeneralViewController.h"
#import "PreferencesNetworkViewController.h"
#import "PreferencesBonjourViewController.h"


static NSString *const kCenterPreferenceWindowToolbarIcons = @"CenterPreferenceWindowToolbarIcons";

@interface AppDelegate () <NSWindowDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (strong) CCNPreferencesWindowController *preferences;
@property (weak) IBOutlet NSButton *showPreferencesButton;
@property (weak) IBOutlet NSButton *centerToolbarIcons;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(handleWindowWillCloseNotification:) name:NSWindowWillCloseNotification object:nil];


    // init the preferences window controller
    self.preferences = [CCNPreferencesWindowController new];
    // setup all prefefences view controllers
    [self.preferences setPreferencesViewControllers:@[
        [PreferencesGeneralViewController new],
        [PreferencesNetworkViewController new],
        [PreferencesBonjourViewController new]
    ]];

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:kCenterPreferenceWindowToolbarIcons]) {
        [defaults setBool:YES forKey:kCenterPreferenceWindowToolbarIcons];
    }
    BOOL centerIcons = [defaults boolForKey:kCenterPreferenceWindowToolbarIcons];
    self.centerToolbarIcons.state = (centerIcons ? NSOnState : NSOffState);
    self.preferences.centerToolbarItems = centerIcons;
}

- (IBAction)centerToolbarIconsAction:(NSButton *)centerToolbarIcons {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL centerIcons = YES;
    switch (centerToolbarIcons.state) {
        case NSOnState: centerIcons = YES; break;
        case NSOffState: centerIcons = NO; break;
    }
    [defaults setBool:centerIcons forKey:kCenterPreferenceWindowToolbarIcons];
    self.preferences.centerToolbarItems = centerIcons;
}

- (IBAction)showPreferencesButtonAction:(id)sender {
    self.centerToolbarIcons.enabled = NO;
    [self.preferences showPreferencesWindow];
}

#pragma mark - NSWindowDelegate Notifications

- (void)handleWindowWillCloseNotification:(NSNotification *)note {
    if ([note.object isEqual:self.preferences.window]) {
        self.centerToolbarIcons.enabled = YES;
    }
}

@end
