//
//  AppDelegate.swift
//  PreferencesControllerTest
//
//  Created by Bruno Vandekerkhove on 04/02/16.
//  Copyright © 2016 Bruno Vandekerkhove. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // Window/View Controllers
    fileprivate let generalController = GeneralPreferencesController()
    fileprivate let advancedController = AdvancedPreferencesController()
    fileprivate var preferencesController = CCNPreferencesWindowController()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
       
        // Set up preferences window
        preferencesController.viewControllers = [generalController, advancedController]
        preferencesController.titleAppearsTransparent = false
        preferencesController.showToolbarSeparator = false
        preferencesController.showToolbarItemsAsSegmentedControl = false
        preferencesController.allowsVibrancy = false
        
        // Show preferences
        showPreferences(nil)
        
    }

    @IBAction func showPreferences(_ sender: AnyObject?) {
        
        preferencesController.showPreferencesWindow()
        
    }

}

