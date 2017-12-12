//
//  MemeTableViewController.swift
//  MEME Part-1
//
//  Created by Samita Mandwe on 11/13/17.
//  Copyright © 2017 udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    //MARK:- To access the array of memes stored in Application Delegate
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var memes: [Meme] {
        return appDelegate.memes
    }
    
    // MARK: Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.tabBarController!.tabBar.isHidden = false
    }
    
    @IBAction func newMeme(sender: UIBarButtonItem) {
        let memeEditor = storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        present(memeEditor, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //MARK : Swipe left to delete a Meme
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
           appDelegate.memes.remove(at: indexPath.row)
           tableView.reloadData()
        }
    }
    // MARK: Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell
        let cell =  tableView.dequeueReusableCell(withIdentifier: "memeTableViewCell")!
        // Access saved meme for a given row
        let meme = self.memes[(indexPath as NSIndexPath).row]
        // Set the label and image
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = "\(meme.topText!)...\(meme.bottomText!)"
        return cell
        
    }
    func tableView(_ tableView: UITableView,  didSelectRowAt indexPath: IndexPath) {
        // Grab the DetailViewController from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        // Populate view controller with data from the selected item
        detailController.meme = self.memes[indexPath.row]
        
        // Present the view controller using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    }



