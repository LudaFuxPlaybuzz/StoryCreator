//
//  ViewController.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/21/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, NewParticlesCollectionTableViewCellProtocol
{
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var particlesTable: UITableView!
    @IBOutlet weak var descriptionBackground: UIView!
    
    let descriptionBackgroundBorder = CAShapeLayer()
    var numOfParticles = 1
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        createButton.layer.masksToBounds = true
        createButton.layer.cornerRadius = 6
     
        descriptionBackgroundBorder.path = UIBezierPath(rect: descriptionBackground.bounds).cgPath
        descriptionBackground.layer.addSublayer(descriptionBackgroundBorder)
        particlesTable.setEditing(true, animated: true)
    }
    
    override func viewDidLayoutSubviews()
    {
        descriptionBackgroundBorder.strokeColor = UIColor.init(colorLiteralRed: 0.5, green: 0.5, blue: 0.5, alpha: 0.25).cgColor
        descriptionBackgroundBorder.fillColor = nil
        descriptionBackgroundBorder.lineDashPattern = [12, 8]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return numOfParticles + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == 0
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ParticleTableViewCell.self), for: indexPath) as? ParticleTableViewCell
            {
                return cell
            }
        }
        else
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(NewParticlesCollectionTableViewCell.self), for: indexPath) as? NewParticlesCollectionTableViewCell
            {
                cell.delegate = self
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        if indexPath.row == numOfParticles
        {
            return false
        }
        else
        {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            numOfParticles -= 1
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.top)
        }
    }
    
    func didSelectNewParticle(particle:NewParticleObject)
    {
        numOfParticles += 1
        particlesTable.reloadData()
     }
}

