//
//  NewParticlesCollectionTableViewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/22/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class IconsCollectionCell: UITableViewCell, UICollectionViewDataSource, NewParticleCollectionViewCellProtocol
{
    @IBOutlet weak var cardBackground: UIView!
    @IBOutlet weak var NewParticlesCollectionView: UICollectionView!
    
    let cardBackgroundBorder = CAShapeLayer()
    var particleItems = [Particle]()
    weak var delegate: NewParticlesCollectionTableViewCellProtocol?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

        particleItems = [Particle(particleImage:"1", particleURL:"https://steelb.com/story.html?particle=paragraph"),
                        Particle(particleImage:"2", particleURL:"https://steelb.com/story.html?particle=imageSection"),
                        Particle(particleImage:"3", particleURL:"https://steelb.com/story.html?particle=quote"),
                        Particle(particleImage:"4", particleURL:"https://steelb.com/story.html?particle=convo"),
                        Particle(particleImage:"5", particleURL:"https://steelb.com/story.html?particle=summaryCard"),
                        Particle(particleImage:"6", particleURL:"https://steelb.com/story.html?particle=embedSection"),
                        Particle(particleImage:"7", particleURL:"https://steelb.com/story.html?particle=flipCard"),
                        Particle(particleImage:"8", particleURL:"https://steelb.com/story.html?particle=pollSection")]
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return particleItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(IconCell.self), for: indexPath) as? IconCell
        {
            let particle:Particle = self.particleItems[indexPath.row]
            cell.setDetails(particle)
            cell.delegate = self
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func didSelectNewParticle(particle:Particle)
    {
        self.delegate?.didSelectNewParticle(particle: particle)
    }
}

@objc protocol NewParticlesCollectionTableViewCellProtocol: class
{
    func didSelectNewParticle(particle:Particle)
}
