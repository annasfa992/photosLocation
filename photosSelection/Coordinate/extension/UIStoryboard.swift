//
//  UIStoryboard.swift
//  photosSelection
//
//  Created by Anas on 24/09/2023.
//

import Foundation
import UIKit

    protocol Storybordable {
        static func createObject(storyBoard:String) -> Self
    }
    
    extension Storybordable where Self: UIViewController {
        static func createObject(storyBoard:String) -> Self {
            let id = String(describing: self)
            let storyboard = UIStoryboard(name: storyBoard, bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: id) as! Self
        }
    }

