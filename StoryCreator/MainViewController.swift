//
//  ViewController.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/21/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,NewParticlesCollectionTableViewCellProtocol
{
    @IBOutlet weak var particlesTable: UITableView!
    
    var newParticles = [Particle]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //        self.useFirebaseDatabase()
    
        particlesTable.rowHeight = UITableViewAutomaticDimension
        particlesTable.estimatedRowHeight = 140
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return newParticles.count + 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        print("row - \(indexPath.row)")
        if indexPath.row == newParticles.count
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TitleAndCoverTableViewCell.self), for: indexPath) as? TitleAndCoverTableViewCell
            {
                return cell
            }
        }
        else if indexPath.row == newParticles.count + 1
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(DescriptionTableViewCell.self), for: indexPath) as? DescriptionTableViewCell
            {
                return cell
            }
        }
        else if indexPath.row == newParticles.count + 2
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(IconsCollectionCell.self), for: indexPath) as? IconsCollectionCell
            {
                cell.delegate = self
                return cell
            }
        }
        else if indexPath.row == newParticles.count + 3
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(PublishTableViewCell.self), for: indexPath) as? PublishTableViewCell
            {
                return cell
            }
        } else
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ParticleOverviewTableViewCell.self), for: indexPath) as? ParticleOverviewTableViewCell
            {
                print("problematic row - \(indexPath.row)")
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = bgColorView
                
                let particle = newParticles[indexPath.row]
                cell.setDetails(particle: particle)
//                cell.delegate = self
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    //MARK: Deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            newParticles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
    
    //MARK: Reordering
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        return (indexPath.row != newParticles.count)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let source = newParticles[sourceIndexPath.row]
        let destination = newParticles[destinationIndexPath.row]
        newParticles[sourceIndexPath.row] = destination
        newParticles[destinationIndexPath.row] = source
    }
    
    func didSelectNewParticle(particle:Particle)
    {
        newParticles.append(particle)
        particlesTable.reloadData()
        self.viewDidLayoutSubviews()
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.performSegue(withIdentifier: "details", sender: particle)
        }
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
                let particle = newParticles[selectedRow]
                detailViewController.particle = particle
            }
        }
    }
    

}



