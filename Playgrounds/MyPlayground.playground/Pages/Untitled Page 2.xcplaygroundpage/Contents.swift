//: [Previous](@previous)

import Cocoa
import XCPlayground
import WebKit


var str = "Hello, playground"

//: [Next](@next)


// embedding wkwebview in nsscrollview

let scrollView = NSScrollView(frame: NSRect(x: 0, y: 0, width: 200, height: 200))

XCPlaygroundPage.currentPage.liveView = scrollView

let webView = WKWebView(frame: scrollView.frame)

//XCPlaygroundPage.currentPage.liveView = webView

//webView.frame = NSRect(x: 0, y: 0, width: 200, height: 800)


//scrollView.documentView = webView
let wkView = webView.subviews[0]
scrollView.documentView = wkView



webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://w3c.org")!))


//scrollView.documentView!.frame

scrollView.contentSize

scrollView.subviews
scrollView.subviews[0].subviews

wkView.frame = NSRect(x: 0, y: 0, width: 200, height: 800)


//webView.subviews
//webView.subviews[0].frame
//
//webView.subviews[0].subviews
