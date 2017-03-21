//
//  MapParticleCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 3/21/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class MapParticleCell: UICollectionViewCell {
    
    @IBOutlet weak var mapContainer: UIView!
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var placeIcon: UIImageView!
    @IBOutlet weak var placeName: UILabel!
  
    override func awakeFromNib()
    {
        super.awakeFromNib()
        mapContainer.isHidden = true
    }
    
    func setDetails(checkInDetails: CheckInDetails)
    {
        self.placeIcon.image = UIImage.init(named: checkInDetails.iconName)
        self.placeName.text = checkInDetails.checkInTitle
        self.mapImageView.image = UIImage.init(named: checkInDetails.mapImageName)
        mapContainer.isHidden = false
    }
}
