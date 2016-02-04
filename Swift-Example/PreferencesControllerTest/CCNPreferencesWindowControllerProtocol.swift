//
//  CCNPreferencesWindowControllerProtocol.swift
//
//  Original Objective-C code created by Frank Gregor on 16/01/15, adapted by Bruno Vandekerkhove on 30/08/15.
//  Copyright (c) 2015 cocoa:naut. All rights reserved.
//

//
//  The MIT License (MIT)
//  Copyright © 2014 Frank Gregor, <phranck@cocoanaut.com>
//  http://cocoanaut.mit-license.org
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the “Software”), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import AppKit

/// A protocol for preference panels
@objc protocol CCNPreferencesWindowControllerProtocol {
    
    /// The identifier of the preference panel.
    func preferencesIdentifier() -> String
    
    /// The title of the preference panel.
    func preferencesTitle() -> String
    
    /// The icon of the preference panel.
    func preferencesIcon() -> NSImage
    
    /// The preference panel's first responder
    optional func firstResponder() -> NSResponder
    
    /// The tooltip of the preference panel
    optional func preferencesToolTip() -> String
    
}