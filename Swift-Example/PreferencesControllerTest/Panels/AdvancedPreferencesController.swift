//
//  AdvancedPreferencesController.swift
//  PreferencesControllerTest
//
//  Created by Bruno Vandekerkhove on 04/02/16.
//  Copyright (c) 2015 WOW Media. All rights reserved.
//

import Cocoa

class AdvancedPreferencesController: NSViewController, CCNPreferencesWindowControllerProtocol {
    
    convenience init() {
        
        self.init(nibName: "AdvancedPreferencesController", bundle: nil)
        
    }
    
    override init!(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("Method not implemented")
        
    }
    
    // MARK: - Preferences Panel Protocol
    
    func preferencesIcon() -> NSImage {
        
        return NSImage(named: NSImageNameAdvanced)!
        
    }
    
    func preferencesIdentifier() -> String {
        
        return "Advanced"
        
    }
    
    func preferencesTitle() -> String {
        
        return "Advanced"
        
    }
    
}
