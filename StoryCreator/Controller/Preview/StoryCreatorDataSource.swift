//
//  PreviewCollectionDataSource.swift
//  StoryCreator
//
//  Created by Luda Fux on 1/29/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class StoryCreatorDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, ParticleIconCellProtocol {
    
    var newParticles = [Particle]()
    weak var delegate: StoryCreatorDataSourceProtocol?
    weak var presentVCDelegate: PresentViewControllerProtocol?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return newParticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let particle = newParticles[indexPath.row]
        
        var cell = UICollectionViewCell()
        
        if let _ = particle as? MicrophoneParticle
        {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(TextParticleCell.self), for: indexPath) as! TextParticleCell
        }
        else
        {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ParticleOverviewCell.self), for: indexPath) as! ParticleOverviewCell
        }
        
//        cell.setDetails(particle: particle)
        //                cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader
        {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                             withReuseIdentifier:NSStringFromClass(TitleCoverAndDescriptionHeader.self), for: indexPath) as! TitleCoverAndDescriptionHeader
            headerView.delegate = self.presentVCDelegate
            return headerView
        } else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter,
                                                                             withReuseIdentifier:NSStringFromClass(NewParticlesAndPublishFooter.self), for: indexPath) as! NewParticlesAndPublishFooter
            footerView.newParticleDelegate = self
            return footerView
        }
    }

    func particleAdded(_ particle:Particle)
    {
        newParticles.append(particle)
        delegate?.particleAdded(particle)
    }
}

@objc protocol StoryCreatorDataSourceProtocol: class
{
    func particleAdded(_ particle:Particle)
}
