//: [Previous](@previous)

import Cocoa
import XCPlayground
import WebKit


var str = "Hello, playground"


class MyViewController: NSViewController {
//  override func loadView() {
//  }
}

let viewController = MyViewController(nibName: nil, bundle: nil)!

let button = NSButton(frame: NSRect(x: 0, y: 0, width: 200, height: 200))

viewController.setView

//XCPlaygroundPage.currentPage.liveView = button

XCPlaygroundPage.currentPage.liveView = viewController



// NOTE live view doens't seem to work with NSViewControllers as of xcode 7.3.



//: [Next](@next)


