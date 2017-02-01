//
//  ViewController.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/21/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController, PreviewTableDataSourceProtocol, PresentViewControllerProtocol
{
    @IBOutlet weak var particlesTable: UITableView!
    
    var feedDataSource = PreviewTableDataSource()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //        self.useFirebaseDatabase()
    
        particlesTable.rowHeight = UITableViewAutomaticDimension
        particlesTable.estimatedRowHeight = 140
        particlesTable.dataSource = self.feedDataSource
        particlesTable.delegate = self.feedDataSource
        self.feedDataSource.delegate = self
        self.feedDataSource.presentVCDelegate = self
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
        particlesTable.reloadData()
        
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
        else if let indexPath = particlesTable.indexPathForSelectedRow
        {
            let selectedRow = indexPath.row
            
            if let detailViewController = segue.destination as? WebFallbackViewController
            {
//                let particle = newParticles[selectedRow]
//                detailViewController.particle = particle
            }
        }
    }
    
    //Mark: PresentViewControllerProtocol
    func present(_ viewController:UIViewController, animated: Bool)
    {
        self.present(viewController, animated: true) {}
    }
}



