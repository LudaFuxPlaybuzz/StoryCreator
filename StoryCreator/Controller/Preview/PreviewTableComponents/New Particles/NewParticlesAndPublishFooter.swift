//
//  NewParticlesCollectionView.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/22/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class NewParticlesAndPublishFooter : UICollectionReusableView, UICollectionViewDataSource, NewParticleCollectionViewCellProtocol
{
    @IBOutlet weak var NewParticlesCollectionView: UICollectionView!
    
    let cardBackgroundBorder = CAShapeLayer()
    var particleItems = [Particle]()
    weak var delegate: NewParticlesCollectionTableViewCellProtocol?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

        particleItems = [Particle(image:"1", name:"Text", url:"https://steelb.com/story.html?particle=paragraph"),
                        Particle(image:"2", name:"Image", url:"https://steelb.com/story.html?particle=imageSection"),
                        Particle(image:"3", name:"Quote", url:"https://steelb.com/story.html?particle=quote"),
                        Particle(image:"4", name:"Convo", url:"https://steelb.com/story.html?particle=convo"),
                        Particle(image:"5", name:"Summery", url:"https://steelb.com/story.html?particle=summaryCard"),
                        Particle(image:"6", name:"Embed Section", url:"https://steelb.com/story.html?particle=embedSection"),
                        Particle(image:"7", name:"Flip Card", url:"https://steelb.com/story.html?particle=flipCard"),
                        Particle(image:"8", name:"Poll", url:"https://steelb.com/story.html?particle=pollSection")]
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return particleItems.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(NewParticleCell.self), for: indexPath) as? NewParticleCell
        {
            let particle:Particle = self.particleItems[indexPath.row]
            cell.setDetails(particle)
            cell.delegate = self
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func particleAdded(_ particle:Particle)
    {
        self.delegate?.particleAdded(particle)
    }
}

@objc protocol NewParticlesCollectionTableViewCellProtocol: class
{
    func particleAdded(_ particle:Particle)
}
