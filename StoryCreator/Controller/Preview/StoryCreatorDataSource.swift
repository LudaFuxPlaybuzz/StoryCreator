//
//  PreviewCollectionDataSource.swift
//  StoryCreator
//
//  Created by Luda Fux on 1/29/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

@objc protocol StoryCreatorDataSourceDelegate: class
{
    func particleAdded(_ particle:Particle)
}

class StoryCreatorDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var newParticles = [Particle]()
    weak var delegate: StoryCreatorDataSourceDelegate?
    weak var presentVCDelegate: PresentViewControllerDelegate?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return newParticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let particle = newParticles[indexPath.row]
        
        var cell = UICollectionViewCell()
        
        switch particle
        {
        case is MicrophoneParticle, is TextParticle:
        
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(TextParticleCell.self), for: indexPath) as! TextParticleCell
            
        case is ImageParticle:
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ImageParticleCell.self), for: indexPath) as! ImageParticleCell
        
        case is MapParticle:
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(MapParticleCell.self), for: indexPath) as! MapParticleCell
            
        default:
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ParticleOverviewCell.self), for: indexPath) as! ParticleOverviewCell
            
        }
        
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
}

extension StoryCreatorDataSource: ParticleIconCellDelegate
{
    func particleAdded(_ particle:Particle)
    {
        delegate?.particleAdded(particle)
    }
}

extension StoryCreatorDataSource: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let particleType = newParticles[indexPath.row]
        
        switch particleType {
        case is ImageParticle:
            return CGSize(width: 400, height: 300)
        case is MapParticle:
            return CGSize(width: 400, height: 250)
        default:
            return CGSize(width: 400, height: 50)
        }
    }
}
