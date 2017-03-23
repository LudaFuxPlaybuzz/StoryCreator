//
//  ViewController.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/21/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit
import DKImagePickerController

class StoryCreatorViewController: UIViewController
{
    
    @IBOutlet weak var particlesIconsCollectionView: UICollectionView!
    
    @IBOutlet weak var previewCollection: UICollectionView!
    @IBOutlet weak var hideAuxilaryViewsButton: UIButton!
    
    var previewDataSource = StoryCreatorDataSource()
    var firebaseManager = FirebaseManager()
    let newParticlesDataSourse = NewParticlesDataSourse()
    var longPressGesture: UILongPressGestureRecognizer!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.firebaseManager.useFirebaseDatabase()
    
        previewCollection.dataSource = self.previewDataSource
        previewCollection.delegate = self.previewDataSource
        
        self.previewDataSource.delegate = self
        self.previewDataSource.presentVCDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(StoryCreatorViewController.showHideAuxilaryViewsButton), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(StoryCreatorViewController.hideHideAuxilaryViewsButton), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        particlesIconsCollectionView.dataSource = newParticlesDataSourse
        newParticlesDataSourse.newParticleDelegate = self
        
        longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(StoryCreatorViewController.handleLongGesture(gesture:)))
        self.previewCollection.addGestureRecognizer(longPressGesture!)
    }

    func handleLongGesture(gesture: UILongPressGestureRecognizer) {
        
        switch(gesture.state) {
            
        case UIGestureRecognizerState.began:
            guard let selectedIndexPath = self.previewCollection.indexPathForItem(at: gesture.location(in: self.previewCollection)) else {
                break
            }
            previewCollection.beginInteractiveMovementForItem(at: selectedIndexPath)
        case UIGestureRecognizerState.changed:
            previewCollection.updateInteractiveMovementTargetPosition(gesture.location(in: gesture.view!))
        case UIGestureRecognizerState.ended:
            previewCollection.endInteractiveMovement()
        default:
            previewCollection.cancelInteractiveMovement()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                 sender: Any?)
    {
        if let checkInViewController = segue.destination as? CheckInViewController
        {
            checkInViewController.delegate = self
        }
    }
    
    @IBAction func hideAuxilaryViewsTapped(_ sender: UIButton)
    {
        self.view.endEditing(true)
    }
    
    func showHideAuxilaryViewsButton()
    {
        hideAuxilaryViewsButton.isHidden = false
    }
    
    func hideHideAuxilaryViewsButton()
    {
        hideAuxilaryViewsButton.isHidden = true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?)
    {
        if(event?.subtype == UIEventSubtype.motionShake)
        {
            let lastCell = self.lastCell()
            
            if let lastImageCell = lastCell as? ImageParticleCell
            {
                lastImageCell.blurImage()
            }
        }
    }
    
    func lastCell() -> UICollectionViewCell?
    {
        let lastCell = previewCollection.cellForItem(at: IndexPath(row: previewDataSource.newParticles.count - 1, section:0) as IndexPath)
        return lastCell
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}

extension StoryCreatorViewController: StoryCreatorDataSourceDelegate, ParticleIconCellDelegate
{
    func particleAdded(_ particle:Particle)
    {
        switch particle {
            
            case is TextParticle:

            if !(self.lastCell() is TextParticleCell)
            {
                previewDataSource.newParticles.append(particle)
                previewCollection.reloadData()
            }
            
            delay(0.1) {
                if let lastTextCell = self.lastCell() as? TextParticleCell
                {
                    self.showKeyboard(textView: lastTextCell.textView)
                    self.hideAuxilaryViewsButton.isHidden = false
                }
            }
            
        case is ImageParticle:
            
            previewDataSource.newParticles.append(particle)
            previewCollection.reloadData()
            
            let pickerController = DKImagePickerController()
            pickerController.singleSelect = true
            
            pickerController.didSelectAssets = { (assets: [DKAsset]) in
                if assets.count > 0
                {
                    let asset: DKAsset = assets[0]
                    asset.fetchImageWithSize(self.view.frame.size, completeBlock: { image, info in
                        if let lastPicCell = self.previewCollection.cellForItem(at: IndexPath(row: self.previewDataSource.newParticles.count - 1, section:0) as IndexPath) as? ImageParticleCell
                        {
                            lastPicCell.imageView.image = image
                        }
                    })
                }
            }
            self.present(pickerController, animated: true) {}
        
        case is MapParticle:
            
            self.performSegue(withIdentifier: "CheckIn", sender: nil)
            previewDataSource.newParticles.append(particle)
            previewCollection.reloadData()
            
        default:
            previewDataSource.newParticles.append(particle)
            previewCollection.reloadData()
        }
    }
    
    func showKeyboard(textView: UITextView)
    {
        textView.becomeFirstResponder()
    }
    
}

extension StoryCreatorViewController: PresentViewControllerDelegate
{
    func present(_ viewController:UIViewController, animated: Bool)
    {
        self.present(viewController, animated: true) {}
    }
}

extension StoryCreatorViewController: CheckInViewControllerDelegate
{
    func didCheckIn(_ checkInDetails:CheckInDetails)
    {
        if let lastMapCell = self.lastCell() as? MapParticleCell
        {
            lastMapCell.setDetails(checkInDetails: checkInDetails)
        }
    }
}
