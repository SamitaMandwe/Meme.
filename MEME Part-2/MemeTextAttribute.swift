//
//  MemeTextAttribute.swift
//  MEME Part-1
//
//  Created by Samita Mandwe on 11/1/17.
//  Copyright © 2017 udacity. All rights reserved.
//

import Foundation
import UIKit

class MemeTextAttribute: UIViewController {
    
    let memeTextAttributes:[String:Any] = [
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.font.rawValue: UIFont(name: "impact", size: 40)!,
        NSAttributedStringKey.strokeWidth.rawValue: -4.0]
    
}
