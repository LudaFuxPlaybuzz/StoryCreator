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
    
    func particleAdded(_ particle:Particle)
    {
        newParticles.append(particle)
        delegate?.particleAdded(particle)
    }
}

@objc protocol PreviewTableDataSourceProtocol: class
{
    func particleAdded(_ particle:Particle)
}
