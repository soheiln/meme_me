//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by soheiln on 5/2/16.
//  Copyright © 2016 soheiln. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource Protocol
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeTableViewCell")!
        let row = indexPath.row
        cell.imageView!.image = memes[row].memedImage
        cell.textLabel!.text = memes[row].topText + "..." + memes[row].bottomText
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Get memeEditorVC
        let object: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController")
        let memeEditorVC = object as! MemeEditorViewController
        

        // Populate memeEditorVC with data from selected item
        let dummyVarToLoadNibFile = memeEditorVC.view
        memeEditorVC.loadMeme((UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row])

        // Present the VC using navigation
        self.presentViewController(memeEditorVC, animated: true, completion: nil)
    }
    
}
