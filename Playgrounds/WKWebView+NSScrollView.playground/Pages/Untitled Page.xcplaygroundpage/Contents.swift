//: Playground - noun: a place where people can play

import Cocoa
import XCPlayground


var str = "Hello, playground"

let view = NSScrollView(frame: NSRect(x: 0, y: 0, width: 100, height: 100))

XCPlaygroundPage.currentPage.liveView = view


let v2 = NSButton(frame: NSRect(x: 0, y: 0, width: 100, height: 300))

view.documentView = v2

NSEvent.addGlobalMonitorForEventsMatchingMask(NSEventMask., handler: <#T##(NSEvent) -> Void#>)
// oh... this is probably not going to work in a playground...
