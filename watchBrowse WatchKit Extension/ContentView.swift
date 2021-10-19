//
//  ContentView.swift
//  watchBrowse WatchKit Extension
//
//  Created by Spotlight Deveaux on 12/14/20.
//

import Dynamic
import SwiftUI

struct ContentView: View {
    @State private var enteredUrl = "https://google.com"

    var body: some View {
        List {
            TextField("URL", text: $enteredUrl, onCommit: {
                if !enteredUrl.hasPrefix("http") {
                    // Let's hope this stays secure...
                    enteredUrl = "https://" + enteredUrl
                }
            })
            .textContentType(.URL)

            Button("Go to", action: {
                goToUrl(givenUrl: enteredUrl)
            })
            .disabled(enteredUrl == "")
        }
    }
}

func goToUrl(givenUrl: String) {
    let url = URL(string: givenUrl)
    let view = Dynamic._SFNanoBrowserViewController()
    Dynamic.UIApplication.sharedApplication.keyWindow.rootViewController.presentViewController(view, animated: true, completion: nil)
    view.loadURL(url)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
