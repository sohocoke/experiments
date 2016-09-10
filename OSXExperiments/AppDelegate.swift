//
//  AppDelegate.swift
//  OSXExperiments
//
//  Created by ilo on 27/11/2015.
//  Copyright © 2015 Big Bear Labs. All rights reserved.
//

import Cocoa
import WebKit


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, WKScriptMessageHandler {

  @IBOutlet weak var window: NSWindow!


  func applicationDidFinishLaunching(aNotification: NSNotification) {
    // Insert code here to initialize your application
    
    showWebView()
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }
  
  var webView: WKWebView!
  var button: NSButton!
  
  func showWebView() {
    let view = window!.contentView!
    
    button = NSButton(frame: CGRect(x: 30, y: 30, width: 100, height: 50))
    button.target = self
    button.action = #selector(AppDelegate.onClick(_:))
    view.addSubview(button)
    view.window?.makeFirstResponder(button)

    let source = "document.body.style.background = '#777';" +
      "window.webkit.messageHandlers.injectionMessageHandler.postMessage({msg: 'documentEnd'});" +
      "console.log('test!');" +
      "var onBlur, onFocus;" +
      
      "window.addEventListener('focusin', onFocus, true);" +
      
      "window.addEventListener('blur', onBlur, true);" +

      "onFocus = function() {" +
      "window.webkit.messageHandlers.injectionMessageHandler.postMessage({msg: 'focus'});" +
      "  return console.log('focus');" +
      "};" +

      "onBlur = function() {" +
      "window.webkit.messageHandlers.injectionMessageHandler.postMessage({msg: 'blur'});" +
      "  return console.log('blur');" +
      "};"
      
    let userScript = WKUserScript(source: source, injectionTime: .AtDocumentEnd, forMainFrameOnly: true)
    let userContentController = WKUserContentController()
    userContentController.addUserScript(userScript)
    userContentController.addScriptMessageHandler(self, name: "injectionMessageHandler")
    
    let config = WKWebViewConfiguration()
    config.userContentController = userContentController;
    
    config.preferences.setValue(true, forKey: "developerExtrasEnabled")

    self.webView = WKWebView(frame: CGRect(x: 0, y: 50, width: 300, height: 300), configuration: config)
    view.addSubview(webView)
    
    
    
    self.load(self)
    
    self.evalJs()
  }
  
  func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
    print("first responder: \(window!.firstResponder), msg: \(message.body)")
//    window!.firstResponder.resignFirstResponder()
    window!.makeFirstResponder(button) 
  }
  
  @IBAction func onClick(sender: NSObject) {
//    self.load(sender)
    self.injectSelectorGadget()
  }
  
  func load(sender: NSObject) {
//    let url = "http://bigbearlabs.com"

    let url = "https://github.com/search?q=http"
//    let url = "https://google.com"
    let nsURL = NSURL(string:url)
    let request = NSURLRequest(URL:nsURL!)
    
    webView.loadRequest(request)
    
    // NEXT what causes the steal? domelement.focus? window.focus?
    // NEXT try replacing / replacing back.
  }
  
  func evalJs() {
    webView.evaluateJavaScript("return window") { (result, err) -> Void in
      print("done.")
    }
  }
  func injectSelectorGadget() {
    let script = "function importJS(src, look_for, onload) {\n  var s = document.createElement('script');\n  s.setAttribute('type', 'text/javascript');\n  s.setAttribute('src', src);\n  if (onload) wait_for_script_load(look_for, onload);\n  var head = document.getElementsByTagName('head')[0];\n  if (head) {\n    head.appendChild(s);\n  } else {\n    document.body.appendChild(s);\n  }\n}\n\nfunction importCSS(href, look_for, onload) {\n  var s = document.createElement('link');\n  s.setAttribute('rel', 'stylesheet');\n  s.setAttribute('type', 'text/css');\n  s.setAttribute('media', 'screen');\n  s.setAttribute('href', href);\n  if (onload) wait_for_script_load(look_for, onload);\n  var head = document.getElementsByTagName('head')[0];\n  if (head) {\n    head.appendChild(s);\n  } else {\n    document.body.appendChild(s);\n  }\n}\n\nfunction wait_for_script_load(look_for, callback) {\n  var interval = setInterval(function() {\n    // if (eval('typeof ' + look_for) != 'undefined') {\n    if (typeof(lookfor) != 'undefined') {\n      clearInterval(interval);\n      callback();\n    }\n  }, 50);\n}\n\n(function(){\n  importCSS('https://dv0akt2986vzh.cloudfront.net/stable/lib/selectorgadget.css');\n  importJS('https://ajax.googleapis.com/ajax/libs/jquery/1.3.1/jquery.min.js', 'jQuery', function() { // Load everything else when it is done.\n    jQuery.noConflict();\n    importJS('https://dv0akt2986vzh.cloudfront.net/stable/vendor/diff/diff_match_patch.js', 'diff_match_patch', function() {\n      importJS('https://dv0akt2986vzh.cloudfront.net/stable/lib/dom.js', 'DomPredictionHelper', function() {\n        importJS('https://dv0akt2986vzh.cloudfront.net/stable/lib/interface.js');\n      });\n    });\n  });\n})();"
    webView.evaluateJavaScript(script) { (a: AnyObject?, e: NSError?) -> Void in
      print("\(a) \(e)")
    }
  }
  
}

