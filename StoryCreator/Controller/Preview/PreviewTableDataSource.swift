//
//  PreviewCollectionDataSource.swift
//  StoryCreator
//
//  Created by Luda Fux on 1/29/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit

class PreviewCollectionDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, NewParticlesCollectionTableViewCellProtocol {
    
    var newParticles = [Particle]()
    weak var delegate: PreviewCollectionDataSourceProtocol?
    weak var presentVCDelegate: PresentViewControllerProtocol?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return newParticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ParticleOverviewCell.self), for: indexPath) as! ParticleOverviewCell
        
        let particle = newParticles[indexPath.row]
        cell.setDetails(particle: particle)
        //                cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader
        {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                             withReuseIdentifier:NSStringFromClass(TitleAndCoverHeader.self), for: indexPath) as! TitleAndCoverHeader
            return headerView
        } else {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter,
                                                                             withReuseIdentifier:NSStringFromClass(NewParticlesAndPublishFooter.self), for: indexPath) as! NewParticlesAndPublishFooter
            return footerView
        }
    }

    func particleAdded(_ particle:Particle)
    {
        newParticles.append(particle)
        delegate?.particleAdded(particle)
    }
}

@objc protocol PreviewCollectionDataSourceProtocol: class
{
    func particleAdded(_ particle:Particle)
    func showParticle(_ particle:Particle)
}
