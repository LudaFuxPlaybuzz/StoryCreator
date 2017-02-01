//
//  PreviewTableDataSource.swift
//  StoryCreator
//
//  Created by Luda Fux on 1/29/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class PreviewTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate, NewParticlesCollectionTableViewCellProtocol {
    
    var newParticles = [Particle]()
    weak var delegate: PreviewTableDataSourceProtocol?
    weak var presentVCDelegate: PresentViewControllerProtocol?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return newParticles.count + 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(TitleAndCoverCell.self), for: indexPath) as? TitleAndCoverCell    
            {
                cell.delegate = self.presentVCDelegate
                return cell
            }
        }
        else if indexPath.row == 1
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
                let bgColorView = UIView()
                bgColorView.backgroundColor = UIColor.clear
                cell.selectedBackgroundView = bgColorView
                
                let particle = newParticles[indexPath.row - 2]
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
        return indexPath.row >= 2 && indexPath.row < newParticles.count + 2
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        let source = newParticles[sourceIndexPath.row - 2]
        let destination = newParticles[destinationIndexPath.row - 2]
        
        newParticles[sourceIndexPath.row - 2] = destination
        newParticles[destinationIndexPath.row - 2] = source
    }

    func particleAdded(_ particle:Particle)
    {
        newParticles.append(particle)
        delegate?.particleAdded(particle)
    }
}

@objc protocol PreviewTableDataSourceProtocol: class
{
    func particleAdded(_ particle:Particle)
    func showParticle(_ particle:Particle)
}
