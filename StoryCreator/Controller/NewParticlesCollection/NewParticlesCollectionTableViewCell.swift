//
//  NewParticlesCollectionTableViewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/22/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class NewParticlesCollectionTableViewCell: UITableViewCell, UICollectionViewDataSource, NewParticleCollectionViewCellProtocol
{
    @IBOutlet weak var cardBackground: UIView!
    @IBOutlet weak var NewParticlesCollectionView: UICollectionView!
    
    let cardBackgroundBorder = CAShapeLayer()
    var particleItems = [NewParticleObject]()
    weak var delegate: NewParticlesCollectionTableViewCellProtocol?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

        particleItems = [NewParticleObject(particleImage:"1"),
                        NewParticleObject(particleImage:"2"),
                        NewParticleObject(particleImage:"3"),
                        NewParticleObject(particleImage:"4"),
                        NewParticleObject(particleImage:"5"),
                        NewParticleObject(particleImage:"6"),
                        NewParticleObject(particleImage:"7"),
                        NewParticleObject(particleImage:"8")]
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return particleItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(NewParticleCollectionViewCell.self), for: indexPath) as? NewParticleCollectionViewCell
        {
            let particle:NewParticleObject = self.particleItems[indexPath.row]
            cell.setDetails(particle)
            cell.delegate = self
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func didSelectNewParticle(particle:NewParticleObject)
    {
        self.delegate?.didSelectNewParticle(particle: particle)
    }
}

@objc protocol NewParticlesCollectionTableViewCellProtocol: class
{
    func didSelectNewParticle(particle:NewParticleObject)
}
