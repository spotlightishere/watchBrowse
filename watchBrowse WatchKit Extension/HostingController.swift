//
//  HostingController.swift
//  watchBrowse WatchKit Extension
//
//  Created by Spotlight Deveaux on 12/14/20.
//

import WatchKit
import Foundation
import SwiftUI

class NSFileManagerExtended: NSObject {
    @objc func containerURL(forSecurityApplicationGroupIdentifier _: String) -> URL {
        FileManager.default.temporaryDirectory
    }
}

class HostingController: WKHostingController<ContentView> {
    override init() {
        // We need SafariServices before anything else.
        dlopen("/System/Library/Frameworks/SafariServices.framework/SafariServices", RTLD_NOW)
        
        // We cannot allow Safari to use its default group for persisting data, as we lack access to it.
        // We can swizzle and substitute our temporary directory instead!
        let fileManager = FileManager.self
        let newFileManager = NSFileManagerExtended.self

        let original = class_getInstanceMethod(fileManager, #selector(FileManager.containerURL(forSecurityApplicationGroupIdentifier:)))
        let new = class_getInstanceMethod(newFileManager, #selector(NSFileManagerExtended.containerURL(forSecurityApplicationGroupIdentifier:)))

        method_exchangeImplementations(original!, new!)

        super.init()
    }
    
    override var body: ContentView {
        return ContentView()
    }
}
