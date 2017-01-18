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
static NSString *const kPresentSegmentedControlInToolbar = @"PresentSegmentedControlInToolbar";

@interface AppDelegate () <NSWindowDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (strong) CCNPreferencesWindowController *preferences;
@property (weak) IBOutlet NSButton *showPreferencesButton;
@property (weak) IBOutlet NSButton *centerToolbarIcons;
@property (weak) IBOutlet NSMatrix *toolbarOrSegment;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(handleWindowWillCloseNotification:) name:NSWindowWillCloseNotification object:nil];


    // init the preferences window controller
    self.preferences = [CCNPreferencesWindowController new];
    self.preferences.titlebarAppearsTransparent = NO;

    // setup all prefefences view controllers
    [self.preferences setPreferencesViewControllers:@[
        [PreferencesGeneralViewController new],
        [PreferencesNetworkViewController new],
        [PreferencesBonjourViewController new]
    ]];

    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:kCenterPreferenceWindowToolbarIcons]) {
        [defaults setBool:YES forKey:kCenterPreferenceWindowToolbarIcons];
        [defaults setBool:NO forKey:kPresentSegmentedControlInToolbar];
    }
    BOOL centerIcons = [defaults boolForKey:kCenterPreferenceWindowToolbarIcons];
    BOOL presentSegmentedControl = [defaults boolForKey:kPresentSegmentedControlInToolbar];

    self.centerToolbarIcons.state = (centerIcons ? NSOnState : NSOffState);
    self.centerToolbarIcons.enabled = !presentSegmentedControl;

    [self.toolbarOrSegment selectCellAtRow:(presentSegmentedControl ? 1 : 0) column:0];

    self.preferences.centerToolbarItems = centerIcons;
    self.preferences.showToolbarItemsAsSegmentedControl = presentSegmentedControl;
}

- (IBAction)centerToolbarIconsAction:(NSButton *)centerToolbarIcons {
    BOOL centerIcons = YES;
    switch (centerToolbarIcons.state) {
        case NSOnState: centerIcons = YES; break;
        case NSOffState: centerIcons = NO; break;
    }
    self.preferences.centerToolbarItems = centerIcons;
    [[NSUserDefaults standardUserDefaults] setBool:centerIcons forKey:kCenterPreferenceWindowToolbarIcons];
}

- (IBAction)toolbarOrSegmentAction:(NSMatrix *)toolbarOrSegment {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL presentSegmentedControl = (toolbarOrSegment.selectedRow == 1);

    self.centerToolbarIcons.enabled = !presentSegmentedControl;
    self.centerToolbarIcons.state = (presentSegmentedControl ? NSOnState : self.centerToolbarIcons.state);

    self.preferences.showToolbarItemsAsSegmentedControl = presentSegmentedControl;

    [defaults setBool:presentSegmentedControl forKey:kCenterPreferenceWindowToolbarIcons];
    [defaults setBool:presentSegmentedControl forKey:kPresentSegmentedControlInToolbar];
}

- (IBAction)showPreferencesButtonAction:(id)sender {
    self.centerToolbarIcons.enabled = NO;
    self.toolbarOrSegment.enabled = NO;
    [self.preferences showPreferencesWindow];
}

#pragma mark - NSWindowDelegate Notifications

- (void)handleWindowWillCloseNotification:(NSNotification *)note {
    if ([note.object isEqual:self.preferences.window]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.centerToolbarIcons.enabled = ![defaults boolForKey:kPresentSegmentedControlInToolbar];
        self.toolbarOrSegment.enabled = YES;
    }
}

@end
