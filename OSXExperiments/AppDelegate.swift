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
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!


  func applicationDidFinishLaunching(aNotification: NSNotification) {
    // Insert code here to initialize your application
    
    showWebView()
  }

  func applicationWillTerminate(aNotification: NSNotification) {
    // Insert code here to tear down your application
  }
  

  func showWebView() {
    let url = "http://bigbearlabs.com"
    let nsURL = NSURL(string:url)
    let request = NSURLRequest(URL:nsURL!)
    
    let view = window!.contentView!
    
    let button = NSButton(frame: CGRect(x: 30, y: 30, width: 100, height: 50))
    view.addSubview(button)

    let source = "document.body.style.background = '#777';"
    let userScript = WKUserScript(source: source, injectionTime: .AtDocumentEnd, forMainFrameOnly: true)
    let userContentController = WKUserContentController()
    userContentController.addUserScript(userScript)
    let config = WKWebViewConfiguration()
    config.userContentController = userContentController;
    
    let webView = WKWebView(frame: self.window.contentView!.bounds, configuration: config)
    view.addSubview(webView)
    
    webView.loadRequest(request)
  }

  func showWebView__() {
    let webView = WKWebView()
    let url = NSURL(string:"https://google.com")
    let req = NSURLRequest(URL:url!)
    webView.loadRequest(req)
    
    self.window!.contentView!.addSubview(webView)
    let frame = self.window!.contentView!.bounds
    webView.frame = frame
    
    
  }

}

