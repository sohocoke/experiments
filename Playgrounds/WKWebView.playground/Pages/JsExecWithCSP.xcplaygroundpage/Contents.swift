//: [Previous](@previous)

import Foundation

var str = "Hello, playground"


let jsExpr = "(function(){ISRIL_H='fe3b';PKT_D='getpocket.com';ISRIL_SCRIPT=document.createElement('SCRIPT');ISRIL_SCRIPT.type='text/javascript';ISRIL_SCRIPT.src='http://'+PKT_D+'/b/r.js';document.getElementsByTagName('head')[0].appendChild(ISRIL_SCRIPT)})();"


// running the above in the web inspector with github.com resulted in CSP violation error in Safari 9, Safari 10 Tech Preview on El Capitan.

// testing with WKWebView evaluate...: ERROR

// testing with WKWebView user content script: ERROR

// TODO test with Sierra sdk.


import Cocoa
import WebKit
import XCPlayground
import ObjectiveC


import ExperimentsFramework


//let scriptUrl = NSBundle(identifier: "com.bigbearlabs.lab.MyFramework")!.URLForResource("UserScript", withExtension:"js")!
let scriptUrl = [#FileReference(fileReferenceLiteral: "pocket_bookmarklet.js")#]
let webView = WKWebView(frame: NSRect(x: 0, y: 0, width: 300, height: 500),
                        scriptUrl: scriptUrl,
                        onMsg: { msg, _ in
                          print(msg.body)
  },
                        onLoad: { webView, _ in
                          print("loaded!")
                          
//                          webView.evaluateJavaScript(jsExpr) { (result, error) in
//                            print(result, error)
//                          }
  }
  )!

// enable the web inspector. to use the console, make sure the WKWebView instance in the timeline is brought to focus first (otherwise your keystrokes are probably going to end up modifying the playground source).
webView.configuration.preferences.setValue(true, forKey: "developerExtrasEnabled")

XCPlaygroundPage.currentPage.liveView = webView


webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://github.com")!))




//: [Next](@next)
