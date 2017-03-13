//
//  ViewController.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/21/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class StoryCreatorViewController: UIViewController, UIGestureRecognizerDelegate, StoryCreatorDataSourceProtocol, PresentViewControllerProtocol
{
    @IBOutlet weak var previewCollection: UICollectionView!
    
    var previewDataSource = StoryCreatorDataSource()
    var firebaseManager = FirebaseManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.firebaseManager.useFirebaseDatabase()
    
        previewCollection.dataSource = self.previewDataSource
        previewCollection.delegate = self.previewDataSource
        
        self.previewDataSource.delegate = self
        self.previewDataSource.presentVCDelegate = self
    }

    func particleAdded(_ particle:Particle)
    {
        previewCollection.reloadData()
    }
    
    @IBAction func didSwipe(_ sender: Any) {
        NSLog("Swipe left")
    }
    
    @IBAction func didPan(_ sender: Any)
    {
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
    }
    
    func present(_ viewController:UIViewController, animated: Bool)
    {
        self.present(viewController, animated: true) {}
    }
    
    @IBAction func didPressCreateButton(_ sender: Any)
    {
        //        var storyContent = ""
        //
        //        for index in 0...newParticles.count
        //        {
        //            if let particleCell = particlesTable.cellForRow(at: IndexPath(row: index, section:0)) as? WebViewFallbackCell
        //            {
        //                storyContent += particleCell.getParticleData()
        //            }
        //        }
        //
        //        let alertController = UIAlertController(title: "Story Content", message:
        //            storyContent, preferredStyle: UIAlertControllerStyle.alert)
        //        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        //
        //        self.present(alertController, animated: true, completion: nil)
    }

}




