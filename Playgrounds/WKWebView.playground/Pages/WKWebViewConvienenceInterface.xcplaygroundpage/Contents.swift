//: create a convenience interface for webview that takes in blocks that handle user content script messages and page lifecycle events.

import Cocoa
import WebKit
import XCPlayground

import MyFramework


let scriptUrl = NSBundle(identifier: "com.bigbearlabs.lab.MyFramework")!.URLForResource("UserScript", withExtension:"js")!
let webView = WKWebView(frame: NSRect(x: 0, y: 0, width: 300, height: 500),
  scriptUrl: scriptUrl,
  onMsg: { msg, _ in
    Swift.print(msg.body)
    return
  },
  onLoad: { webView, _ in
    print("loaded!")
    
    let jsExpr =
//      "window.injectedNamespace.pageInfo.activeElement()"
      "window.injectedNamespace.pageInfo.scrollY()"
    
    webView.evaluateJavaScript(jsExpr) { (result, error) in
      print(result, error)
    }
  }
)!

// enable the web inspector. to use the console, make sure the WKWebView instance in the timeline is brought to focus first (otherwise your keystrokes are probably going to end up modifying the playground source).
webView.configuration.preferences.setValue(true, forKey: "developerExtrasEnabled")

XCPlaygroundPage.currentPage.liveView = webView


webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://w3c.org")!))



// debug

webView.navigationDelegate

