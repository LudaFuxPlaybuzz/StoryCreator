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

        particleItems = [NewParticleObject(particleImage:"1", particleURL:""),
                        NewParticleObject(particleImage:"2", particleURL:""),
                        NewParticleObject(particleImage:"3", particleURL:"https://steelb.com/story.html?particle=quote"),
                        NewParticleObject(particleImage:"4", particleURL:"https://steelb.com/story.html?particle=convo"),
                        NewParticleObject(particleImage:"5", particleURL:"https://steelb.com/story.html?particle=paragraph"),
                        NewParticleObject(particleImage:"6", particleURL:""),
                        NewParticleObject(particleImage:"7", particleURL:""),
                        NewParticleObject(particleImage:"8", particleURL:"")]
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
