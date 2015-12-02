//
//  MasterViewController.swift
//  experiments
//
//  Created by ilo on 27/11/2015.
//  Copyright © 2015 Big Bear Labs. All rights reserved.
//

import UIKit
import WebKit


class MasterViewController: UITableViewController {

  var detailViewController: DetailViewController? = nil
  var objects = [AnyObject]()

  
  func showWebView() {
    
    let url = "https://bigbearlabs.com"
    let nsURL = NSURL(string:url)
    let request = NSURLRequest(URL:nsURL!)
    
//    let frame = CGRect(x: 0, y: 0, width: 800, height:600)
    let frame = self.view.bounds
    let config = WKWebViewConfiguration()
    let web = WKWebView(frame: frame, configuration: nil)
    
//    [self.wkWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
//    [self.wkWebView setNavigationDelegate:self];
//    [self.wkWebView setUIDelegate:self];
//    [self.wkWebView setMultipleTouchEnabled:YES];
//    [self.wkWebView setAutoresizesSubviews:YES];
//    [self.wkWebView.scrollView setAlwaysBounceVertical:YES];
//    [self.view addSubview:self.wkWebView];
    self.view.addSubview(web)
    web.frame = self.view.bounds
    

    web.loadRequest(request)
    
    self.webView = web
  }
  
  var webView = WKWebView?
  
  func showWebView__() {
    self.webView = WKWebView()
    webView?.backgroundColor = UIColor.whiteColor()
    webView?.autoresizingMask = UIViewAutoresizing.FlexibleWidth
    webView?.autoresizingMask = UIViewAutoresizing.FlexibleHeight
    let url = NSURL(string:"https://www.bignerdranch.com")
    let req = NSURLRequest(URL:url!)
    webView?.loadRequest(req)
    
    self.view.addSubview((webView)!)

  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem()

    let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
    self.navigationItem.rightBarButtonItem = addButton
    if let split = self.splitViewController {
        let controllers = split.viewControllers
        self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }

    
    showWebView()
  }

  override func viewWillAppear(animated: Bool) {
    self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
    super.viewWillAppear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func insertNewObject(sender: AnyObject) {
    objects.insert(NSDate(), atIndex: 0)
    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
    self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
  }

  // MARK: - Segues

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            let object = objects[indexPath.row] as! NSDate
            let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
            controller.detailItem = object
            controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
  }

  // MARK: - Table View

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

    let object = objects[indexPath.row] as! NSDate
    cell.textLabel!.text = object.description
    return cell
  }

  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }

  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
        objects.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
  }


}

