//: [Previous](@previous)

import Cocoa
import XCPlayground
import WebKit


var str = "Hello, playground"

let frameRect = NSRect(x: 0, y: 0, width: 200, height: 200)

class MyViewController: NSViewController {
  override func loadView() {
    self.view = NSView(frame: frameRect)
  }
}

let viewController = MyViewController(nibName: nil, bundle: nil)!

let button = NSButton(frame: frameRect)

viewController.view.addSubview(button)


XCPlaygroundPage.currentPage.liveView = viewController



//: [Next](@next)


