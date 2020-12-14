//
//  ContentView.swift
//  watchBrowse WatchKit Extension
//
//  Created by Spotlight Deveaux on 12/14/20.
//

import Dynamic
import SwiftUI

struct ContentView: View {
    @State private var enteredUrl = ""
    
    var body: some View {
        List {
            TextField("URL", text: $enteredUrl)
                .textContentType(.URL)
            Button("Go to", action: {
                enteredUrl = goToUrl(givenUrl: enteredUrl)
            })
            .disabled(enteredUrl == "")
        }
    }
}

func goToUrl(givenUrl: String) -> String {
    var url = givenUrl
    if !url.hasPrefix("http") {
        // I hope you are secure.
        url = "https://" + url
    }
    
    let view = Dynamic.SFSafariViewController.initWithURL(URL(string: url))
    Dynamic.UIApplication.sharedApplication.keyWindow.rootViewController.presentViewController(view, animated:true, completion: nil)
    
    return url
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
