//
//  SwipeToDeleteCollectionViewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 2/5/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class SwipeToDeleteCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: SwipeToDeleteCollectionViewCellProtocol?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        let gestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeRight(gestureRecognizer:)))
        gestureRecognizer.direction = UISwipeGestureRecognizerDirection.right
        gestureRecognizer.delegate = self
        
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    func handleSwipeRight(gestureRecognizer: UIGestureRecognizer) {
        print("")
//        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
//        self.presentViewController(alert, animated: true, completion: nil)
    }
}


@objc protocol SwipeToDeleteCollectionViewCellProtocol: class
{
    func deleteButtonClicked(_ cell:SwipeToDeleteCollectionViewCell)
}
