//
//  NewParticlesCollectionTableViewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/22/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class NewParticlesCollectionTableViewCell: UITableViewCell, UICollectionViewDataSource
{
    @IBOutlet weak var cardBackground: UIView!
    @IBOutlet weak var NewParticlesCollectionView: UICollectionView!
    
    let cardBackgroundBorder = CAShapeLayer()
    
    override func awakeFromNib()
    {
        super.awakeFromNib()

        cardBackgroundBorder.strokeColor = UIColor.init(colorLiteralRed: 0.5, green: 0.5, blue: 0.5, alpha: 0.25).cgColor
        cardBackgroundBorder.borderWidth = 3
        cardBackgroundBorder.fillColor = nil
        cardBackgroundBorder.lineDashPattern = [12, 8]
    }

    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        cardBackgroundBorder.path = UIBezierPath(rect: cardBackground.bounds).cgPath
        cardBackground.layer.addSublayer(cardBackgroundBorder)
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 8
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(NewParticleCollectionViewCell.self), for: indexPath)
        
        return cell

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
