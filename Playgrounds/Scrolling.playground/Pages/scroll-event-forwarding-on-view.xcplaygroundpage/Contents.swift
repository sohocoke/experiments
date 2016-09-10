//: Playground - noun: a place where people can play

import Cocoa
import XCPlayground
import WebKit


var str = "Hello, playground"


class MyView: NSButton {
//  override func wantsForwardedScrollEventsForAxis(axis: NSEventGestureAxis) -> Bool {
//    return true
//  }
//  
//  override func wantsScrollEventsForSwipeTrackingOnAxis(axis: NSEventGestureAxis) -> Bool {
//    return true
//  }
  
//  override func scrollWheel(theEvent: NSEvent) {
//    NSLog("scroll!!!")
//    super.scrollWheel(theEvent)
//  }
}


let view = MyView(frame: NSMakeRect(0,0,300,500))
//XCPlaygroundPage.currentPage.liveView = view

let scrollView = NSScrollView(frame: NSMakeRect(0,0,300,300))
scrollView.documentView = view
XCPlaygroundPage.currentPage.liveView = scrollView


let webView = WKWebView(frame: view.bounds)

// view.addSubview(webView)
//NOTE this results in no scroll evnets on MyView.
//view.addSubview(webView.subviews[0])

webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://w3c.org")!))

//scrollView.addSubview(webView)

//let sv = webView.scrollView


//view.loadRequest(NSURLRequest(URL: NSURL(string: "http://w3c.org")!))

//view.subviews[0]

