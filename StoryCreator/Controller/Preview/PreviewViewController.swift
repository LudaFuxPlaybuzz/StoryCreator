//
//  ViewController.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/21/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit
import Firebase

class PreviewViewController: UIViewController, PreviewCollectionDataSourceProtocol, PresentViewControllerProtocol
{
    @IBOutlet weak var previewCollection: UICollectionView!
    
    var previewDataSource = PreviewCollectionDataSource()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //        self.useFirebaseDatabase()
    
        previewCollection.dataSource = self.previewDataSource
        previewCollection.delegate = self.previewDataSource
        
        self.previewDataSource.delegate = self
        self.previewDataSource.presentVCDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
//    func useFirebaseDatabase()
//    {
//        let ref = FIRDatabase.database().reference()
//        ref.child("articles").child("article2").setValue(["title": "Igal is awesome!"])
//    }
//    
//    func reloadTable()
//    {
//        particlesTable.reloadData()
//    }
//    
//    func triggerOpenCamera()
//    {
//        self.didPressCameraButton(self)
//    }

    func particleAdded(_ particle:Particle)
    {
        previewCollection.reloadData()
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
//            self.performSegue(withIdentifier: "details", sender: particle)
        }
    }
    
    func showParticle(_ particle:Particle)
    {
        self.performSegue(withIdentifier: "details", sender: particle)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!)
    {
        if let particle = sender as? Particle
        {
            if let detailViewController = segue.destination as? WebFallbackViewController
            {
                detailViewController.particle = particle
            }
            
        }
        else if let indexPath = previewCollection.indexPathsForSelectedItems?[0]
        {
            let selectedRow = indexPath.row
            
//            if let cell = previewCollection.cellForItem(at: indexPath) as? ParticleOverviewCell
//            {
////                print("stuff in prepare")
////                cell.selectionView.isHidden = false
//                cell.setSelected(true, animated: false)
//            }
        
            if let detailViewController = segue.destination as? WebFallbackViewController
            {
                print(selectedRow)
                let particle = self.previewDataSource.newParticles[selectedRow]
                detailViewController.particle = particle
            }
        }
    }
    
    @IBAction func didPan(_ sender: Any)
    {
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
    }
    //Mark: PresentViewControllerProtocol
    func present(_ viewController:UIViewController, animated: Bool)
    {
        self.present(viewController, animated: true) {}
    }
}



