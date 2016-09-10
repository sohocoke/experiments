// Playground - noun: a place where people can play

//import UIKit
import Cocoa
import WebKit
import XCPlayground

let url = "http://bigbearlabs.com"
let nsURL = NSURL(string:url)
let request = NSURLRequest(URL:nsURL!)

// let view = window!.contentView!

let button = NSButton(frame: CGRect(x: 30, y: 30, width: 100, height: 50))
//view.addSubview(button)
let webView = WKWebView()
//view.addSubview(webView)
//webView.frame = view.bounds
webView.frame = CGRect(x: 0, y: 0, width: 200, height: 400)
webView.loadRequest(request)


//XCPShowView(url, view: web)
//XCPSetExecutionShouldContinueIndefinitely()
XCPlaygroundPage.currentPage.liveView = webView
XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

webView


