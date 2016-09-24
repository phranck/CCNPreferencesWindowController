//
//  GeneralPreferencesController.swift
//  PreferencesControllerTest
//
//  Created by Bruno Vandekerkhove on 04/02/16.
//  Copyright (c) 2015 WOW Media. All rights reserved.
//

import Cocoa

class GeneralPreferencesController: NSViewController, CCNPreferencesWindowControllerProtocol {
    
    convenience init() {
        
        self.init(nibName: "GeneralPreferencesController", bundle: nil)
        
        self.loadView()
        
    }
    
    override init!(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("Method not implemented")
        
    }
    
    // MARK: - Preferences Panel Protocol
    
    static var preferencesIcon: NSImage {
        
        return NSImage(named: NSImageNamePreferencesGeneral)!
        
    }
    
    static var preferencesIdentifier: String {
        
        return "General"
        
    }
    
    static var preferencesTitle: String {
        
        return "General"
        
    }
    
}
