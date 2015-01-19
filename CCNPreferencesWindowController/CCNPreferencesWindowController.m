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

#import <QuartzCore/QuartzCore.h>
#import "CCNPreferencesWindowController.h"
#import "CCNPreferencesWindowControllerProtocol.h"


static NSString *const CCNPreferencesToolbarIdentifier = @"CCNPreferencesMainToolbar";
static NSString *const CCNPreferencesWindowFrameAutoSaveName = @"CCNPreferencesWindowFrameAutoSaveName";
static NSRect CCNPreferencesDefaultWindowRect;
static unsigned short const CCNEscapeKey = 53;


/**
 ====================================================================================================================
 */
#pragma mark CCNPreferencesWindow
#pragma mark -
@interface CCNPreferencesWindow : NSWindow
@end




/**
 ====================================================================================================================
 */

#pragma mark - CCNPreferencesWindowController
#pragma mark -

@interface CCNPreferencesWindowController() <NSToolbarDelegate, NSWindowDelegate>
@property (strong) CCNPreferencesWindow *window;

@property (strong) NSToolbar *toolbar;
@property (strong) NSMutableArray *toolbarDefaultItemIdentifiers;

@property (strong) NSMutableOrderedSet *viewControllers;
@property (strong) id<CCNPreferencesWindowControllerProtocol> activeViewController;
@end

@implementation CCNPreferencesWindowController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (void)setupDefaults {
    self.viewControllers = [[NSMutableOrderedSet alloc] init];
    self.activeViewController = nil;
    self.window = [[CCNPreferencesWindow alloc] init];

    self.showToolbarWithSingleViewController = YES;
    self.centerToolbarItems = YES;
    self.showToolbarSeparator = YES;
    self.allowsVibrancy = NO;
}

- (void)setupToolbar {
    if (self.showToolbarWithSingleViewController || self.viewControllers.count > 1) {
        self.toolbar = [[NSToolbar alloc] initWithIdentifier:CCNPreferencesToolbarIdentifier];
        self.toolbar.allowsUserCustomization = YES;
        self.toolbar.autosavesConfiguration = YES;
        self.toolbar.showsBaselineSeparator = self.showToolbarSeparator;
        self.toolbar.delegate = self;
        self.window.toolbar = self.toolbar;
    }
    else {
        self.window.toolbar = nil;
    }
}

- (void)dealloc {
    _viewControllers = nil;
    _activeViewController = nil;
    _toolbar = nil;
    _toolbarDefaultItemIdentifiers = nil;
}

#pragma mark - API

- (void)setPreferencesViewControllers:(NSArray *)viewControllers {
    for (id viewController in viewControllers) {
        [self addPreferencesViewController:viewController];
    }
    [self setupToolbar];
}

- (void)showPreferencesWindow {
    self.window.alphaValue = 0.0;
    [self showWindow:self];
    [self.window makeKeyAndOrderFront:self];
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];

    [self activateViewController:self.viewControllers[0] animate:NO];
    if (self.window.toolbar) {
        [self.window.toolbar setSelectedItemIdentifier:self.toolbarDefaultItemIdentifiers[(self.centerToolbarItems ? 1 : 0)]];
    }
    self.window.alphaValue = 1.0;
}

- (void)dismissPreferencesWindow {
    [self close];
}

#pragma mark - Custom Accessors

- (void)setTitlebarAppearsTransparent:(BOOL)titlebarAppearsTransparent {
    self.window.titlebarAppearsTransparent = titlebarAppearsTransparent;
}

- (void)setCenterToolbarItems:(BOOL)centerToolbarItems {
    _centerToolbarItems = centerToolbarItems;
    self.toolbarDefaultItemIdentifiers = nil;
    self.toolbar = nil;
    [self setupToolbar];
}

#pragma mark - Helper

- (void)addPreferencesViewController:(id<CCNPreferencesWindowControllerProtocol>)viewController {
    NSAssert([viewController conformsToProtocol:@protocol(CCNPreferencesWindowControllerProtocol)], @"ERROR: The viewController [%@] must conform to protocol <CCNPreferencesWindowControllerDelegate>", [viewController class]);

    [self.viewControllers addObject:viewController];
}

- (id<CCNPreferencesWindowControllerProtocol>)viewControllerWithIdentifier:(NSString *)identifier {
    for (id<CCNPreferencesWindowControllerProtocol> vc in self.viewControllers) {
        if ([[vc preferenceIdentifier] isEqualToString:identifier]) {
            return vc;
        }
    }
    return nil;
}

- (void)activateViewController:(id<CCNPreferencesWindowControllerProtocol>)viewController animate:(BOOL)animate {
    NSRect currentWindowFrame      = self.window.frame;
    NSRect viewControllerFrame     = [(NSViewController *)viewController view].frame;
    NSRect frameRectForContentRect = [self.window frameRectForContentRect:viewControllerFrame];

    CGFloat deltaX = NSWidth(currentWindowFrame) - NSWidth(frameRectForContentRect);
    CGFloat deltaY = NSHeight(currentWindowFrame) - NSHeight(frameRectForContentRect);
    NSRect newWindowFrame = NSMakeRect(NSMinX(currentWindowFrame) + (self.centerToolbarItems ? deltaX / 2 : 0),
                                       NSMinY(currentWindowFrame) + deltaY,
                                       NSWidth(frameRectForContentRect),
                                       NSHeight(frameRectForContentRect));

    self.window.title = [viewController preferenceTitle];
    NSView *newContentView = [(NSViewController *)viewController view];
    newContentView.alphaValue = 0;

    if (self.allowsVibrancy) {
        NSVisualEffectView *effectView = [[NSVisualEffectView alloc] initWithFrame:newContentView.frame];
        effectView.blendingMode = NSVisualEffectBlendingModeBehindWindow;
        [effectView addSubview:newContentView];
        self.window.contentView = effectView;
    }
    else {
        self.window.contentView = newContentView;
    }

    __weak typeof(self) wSelf = self;
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = (animate ? 0.25 : 0);
        context.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [[wSelf.window animator] setFrame:newWindowFrame display:YES];
        [[newContentView animator] setAlphaValue:1.0];

    } completionHandler:^{
        wSelf.activeViewController = viewController;
    }];
}

#pragma mark - NSToolbarItem Actions

- (void)toolbarItemAction:(NSToolbarItem *)toolbarItem {
    if (![[self.activeViewController preferenceIdentifier] isEqualToString:toolbarItem.itemIdentifier]) {
        id<CCNPreferencesWindowControllerProtocol> vc = [self viewControllerWithIdentifier:toolbarItem.itemIdentifier];
        [self activateViewController:vc animate:YES];
    }
}

#pragma mark - NSToolbarDelegate

- (NSToolbarItem *)toolbar:(NSToolbar *)toolbar itemForItemIdentifier:(NSString *)itemIdentifier willBeInsertedIntoToolbar:(BOOL)flag {
    if ([itemIdentifier isEqualToString:NSToolbarFlexibleSpaceItemIdentifier]) {
        return nil;
    }

    id<CCNPreferencesWindowControllerProtocol> vc = [self viewControllerWithIdentifier:itemIdentifier];
    NSString *identifier = [vc preferenceIdentifier];
    NSString *label      = [vc preferenceTitle];
    NSImage *icon        = [vc preferenceIcon];
    NSString *toolTip    = nil;
    if ([vc respondsToSelector:@selector(preferenceToolTip)]) {
        toolTip = [vc preferenceToolTip];
    }

    NSToolbarItem *toolbarItem = [[NSToolbarItem alloc] initWithItemIdentifier:identifier];
    toolbarItem.label          = label;
    toolbarItem.paletteLabel   = label;
    toolbarItem.image          = icon;
    toolbarItem.toolTip        = toolTip;
    toolbarItem.target         = self;
    toolbarItem.action         = @selector(toolbarItemAction:);

    return toolbarItem;
}

- (NSArray *)toolbarDefaultItemIdentifiers:(NSToolbar *)toolbar {
    if (!self.toolbarDefaultItemIdentifiers && self.viewControllers.count > 0) {
        self.toolbarDefaultItemIdentifiers = [[NSMutableArray alloc] init];

        if (self.centerToolbarItems) {
            [self.toolbarDefaultItemIdentifiers insertObject:NSToolbarFlexibleSpaceItemIdentifier atIndex:0];
        }

        NSInteger offset = self.toolbarDefaultItemIdentifiers.count;
        __weak typeof(self) wSelf = self;
        [self.viewControllers enumerateObjectsUsingBlock:^(id<CCNPreferencesWindowControllerProtocol>vc, NSUInteger idx, BOOL *stop) {
            [wSelf.toolbarDefaultItemIdentifiers insertObject:[vc preferenceIdentifier] atIndex:idx + offset];
        }];

        if (self.centerToolbarItems) {
            [self.toolbarDefaultItemIdentifiers insertObject:NSToolbarFlexibleSpaceItemIdentifier atIndex:self.toolbarDefaultItemIdentifiers.count];
        }
    }
    return self.toolbarDefaultItemIdentifiers;
}

- (NSArray *)toolbarAllowedItemIdentifiers:(NSToolbar *)toolbar {
    return [self toolbarDefaultItemIdentifiers:toolbar];
}

- (NSArray *)toolbarSelectableItemIdentifiers:(NSToolbar *)toolbar {
    return [self toolbarDefaultItemIdentifiers:toolbar];
}

#pragma mark - NSWindowDelegate


@end




/**
 ====================================================================================================================
 */

#pragma mark - CCNPreferencesWindow
#pragma mark -

@implementation CCNPreferencesWindow

+ (void)initialize {
    CCNPreferencesDefaultWindowRect = NSMakeRect(0, 0, 420, 230);
}

- (instancetype)init {
    self = [super initWithContentRect:CCNPreferencesDefaultWindowRect
                            styleMask:(NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask)
                              backing:NSBackingStoreBuffered
                                defer:YES];
    if (self) {
        [self center];
        self.frameAutosaveName = CCNPreferencesWindowFrameAutoSaveName;
        [self setFrameFromString:CCNPreferencesWindowFrameAutoSaveName];
    }
    return self;
}

- (void)keyDown:(NSEvent *)theEvent {
    switch(theEvent.keyCode) {
        case CCNEscapeKey:
            [self orderOut:nil];
            [self close];
            break;
        default: [super keyDown:theEvent];
    }
}

@end