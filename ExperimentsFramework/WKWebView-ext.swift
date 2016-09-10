//
//  WKWebView-ext.swift
//  PlaygroundPlayground
//
//  Created by ilo on 10/09/16.
//  Copyright © 2016 Big Bear Labs. All rights reserved.
//

import Foundation
import WebKit
import ObjectiveC

public extension WKWebView {
  
  convenience public init?(frame: NSRect, scriptUrl: NSURL? = nil, onMsg: (WKScriptMessage, WKUserContentController) -> Void, onLoad: (WKWebView, WKNavigation) -> Void) {
    do {
      let configuration = WKWebViewConfiguration()
      
      if scriptUrl != nil {
        let source = try NSString(contentsOfURL: scriptUrl!, encoding: NSUTF8StringEncoding)
        let script = WKUserScript(source: source as String, injectionTime: .AtDocumentEnd, forMainFrameOnly: true)
        
        configuration.userContentController.addUserScript(script)
      }
      
      class BridgeMessageHandler: NSObject, WKScriptMessageHandler {
        let onMsg: (WKScriptMessage, WKUserContentController) -> Void
        
        init(onMsg: (WKScriptMessage, WKUserContentController) -> Void) {
          self.onMsg = onMsg
        }
        
        @objc func userContentController(userContentController: WKUserContentController,
                                         didReceiveScriptMessage message: WKScriptMessage) {
          onMsg(message, userContentController)
        }
      }
      let handler = BridgeMessageHandler(onMsg: onMsg)
      configuration.userContentController.addScriptMessageHandler(handler, name: "bridge")
      
      class NavigationDelegate: NSObject, WKNavigationDelegate {
        let onLoad: (WKWebView, WKNavigation) -> Void
        
        init(onLoad: (WKWebView, WKNavigation)-> Void) {
          self.onLoad = onLoad
        }
        
        @objc func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
          onLoad(webView, navigation)
        }
      }
      
      self.init(frame: frame, configuration: configuration)
      
      let navigationDelegate = NavigationDelegate(onLoad: onLoad)
      self.navigationDelegate = navigationDelegate
      
      // retain the nav delegate.
      var delegateKey = "wk_webview_navigation_delegate"
      objc_setAssociatedObject(self, &delegateKey, navigationDelegate, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    } catch let error {
      Swift.print("error initialising webview: \(error)")
      return nil
    }
  }
  
}

