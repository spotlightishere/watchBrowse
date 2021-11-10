//
//  watchBrowseApp.swift
//  watchBrowse WatchKit Extension
//
//  Created by Spotlight Deveaux on 2021-11-10.
//

import Foundation
import SwiftUI

class NSFileManagerExtended: NSObject {
    @objc func containerURL(forSecurityApplicationGroupIdentifier _: String) -> URL {
        FileManager.default.temporaryDirectory
    }
}

@main
struct watchBrowseApp: App {
    init() {
        // We need SafariServices before anything else.
        dlopen("/System/Library/Frameworks/SafariServices.framework/SafariServices", RTLD_NOW)

        // We cannot allow Safari to use its default group for persisting data, as we lack access to it.
        // We can swizzle and substitute our temporary directory instead!
        let fileManager = FileManager.self
        let newFileManager = NSFileManagerExtended.self

        let original = class_getInstanceMethod(fileManager, #selector(FileManager.containerURL(forSecurityApplicationGroupIdentifier:)))
        let new = class_getInstanceMethod(newFileManager, #selector(NSFileManagerExtended.containerURL(forSecurityApplicationGroupIdentifier:)))

        method_exchangeImplementations(original!, new!)
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
    }
}
