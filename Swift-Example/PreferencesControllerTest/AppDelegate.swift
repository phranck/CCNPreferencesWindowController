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
    private let generalController = GeneralPreferencesController()
    private let advancedController = AdvancedPreferencesController()
    private var preferencesController = CCNPreferencesWindowController()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
       
        // Set up preferences window
        preferencesController.viewControllers = [generalController, advancedController]
        preferencesController.titleAppearsTransparent = true
        preferencesController.showToolbarSeparator = false
        preferencesController.showToolbarItemsAsSegmentedControl = true
        preferencesController.allowsVibrancy = false
        
        // Show preferences
        showPreferences(nil)
        
    }

    @IBAction func showPreferences(sender: AnyObject?) {
        
        preferencesController.showPreferencesWindow()
        
    }

}

