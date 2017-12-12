//
//  SentMemeCollectionViewController.swift
//  MEME Part-1
//
//  Created by Samita Mandwe on 11/29/17.
//  Copyright © 2017 udacity. All rights reserved.
//

import UIKit
class SentMemeCollectionViewController:UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
     // MARK: Outlets
   @IBOutlet weak var flowLayout: UICollectionView!
    
    // To access the array of memes stored in Application Delegate
    var memes: [Meme] { return (UIApplication.shared.delegate as! AppDelegate).memes }
    
    // MARK: Life Cycle
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellSize = CGSize(width: 100, height: 100)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        flowLayout.setCollectionViewLayout(layout, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
        self.tabBarController!.tabBar.isHidden = false
        
    }
    
    @IBAction func newMeme(sender: UIBarButtonItem) {
        let memeEditor = storyboard!.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        present(memeEditor, animated: true, completion: nil)
    }
    
    // MARK: Collection View Data Source
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Dequeue a reusable cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        // Access saved meme for a given row
        let meme: Meme = memes[(indexPath as NSIndexPath).row]
        // Set the label and image
        cell.memeImageView.image = meme.memedImage
        return cell
    }
    
    override func collectionView(_ sentMemesCollectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        // Grab the DetailViewController from Storyboard
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        // Populate view controller with data from the selected item
        detailController.meme = self.memes[indexPath.row]
        
        // Present the view controller using navigation
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
}
