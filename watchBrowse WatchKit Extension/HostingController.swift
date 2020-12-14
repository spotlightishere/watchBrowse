//
//  HostingController.swift
//  watchBrowse WatchKit Extension
//
//  Created by Spotlight Deveaux on 12/14/20.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<ContentView> {
    override init() {
        // We need SafariServices before anything else.
        dlopen("/System/Library/Frameworks/SafariServices.framework/SafariServices", RTLD_NOW)
        
        super.init()
    }
    
    override var body: ContentView {
        return ContentView()
    }
}
