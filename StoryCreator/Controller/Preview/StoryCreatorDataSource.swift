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
            
        case is QuoteParticle:
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(QuoteParticleCell.self), for: indexPath) as! QuoteParticleCell
            
        default:
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(ParticleOverviewCell.self), for: indexPath) as! ParticleOverviewCell
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        
        if kind == UICollectionElementKindSectionHeader
        {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                             withReuseIdentifier:NSStringFromClass(TitleCoverAndDescriptionHeader.self), for: indexPath) as! TitleCoverAndDescriptionHeader
            headerView.delegate = self.presentVCDelegate
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let temp = newParticles.remove(at: sourceIndexPath.item)
        newParticles.insert(temp, at: destinationIndexPath.item)
    }
}

extension StoryCreatorDataSource: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let particleType = newParticles[indexPath.row]
        
        let width = UIScreen.main.bounds.width
        
        switch particleType {
        case is ImageParticle:
            return CGSize(width: width, height: 300)
        case is MapParticle:
            return CGSize(width: width, height: 250)
        case is QuoteParticle:
            return CGSize(width: width, height: 370)
        default:
            return CGSize(width: width, height: 50)
        }
    }
}

extension UICollectionViewFlowLayout {
    
    open override func invalidationContext(forInteractivelyMovingItems targetIndexPaths: [IndexPath], withTargetPosition targetPosition: CGPoint, previousIndexPaths: [IndexPath], previousPosition: CGPoint) -> UICollectionViewLayoutInvalidationContext {
        
        let context = super.invalidationContext(forInteractivelyMovingItems: targetIndexPaths, withTargetPosition: targetPosition, previousIndexPaths: previousIndexPaths, previousPosition: previousPosition)
        
//        self.delegate?.collectionView!(self.collectionView!, moveItemAt: previousIndexPaths[0], to: targetIndexPaths[0])
        
        return context
    }
}
