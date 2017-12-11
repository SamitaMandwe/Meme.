//
//  MemeDetailViewController.swift
//  MEME Part-1
//
//  Created by Samita Mandwe on 11/15/17.
//  Copyright © 2017 udacity. All rights reserved.
//

import UIKit
class MemeDetailViewController:UIViewController {
    
    //MARK:- Properties
    var meme: Meme!

    // MARK:- Outlets
    @IBOutlet var memeImageView: UIImageView!
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeImageView.image = meme.memedImage
        tabBarController!.tabBar.isHidden = true
    }
}

