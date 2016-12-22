//
//  NewParticlesCollectionTableViewCell.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/22/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class NewParticlesCollectionTableViewCell: UITableViewCell, UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 7
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(NewParticleCollectionViewCell.self), for: indexPath) 
        return cell

    }
    
    @IBOutlet weak var NewParticlesCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
