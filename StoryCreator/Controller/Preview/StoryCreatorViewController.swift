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
    @IBOutlet weak var previewCollection: UICollectionView!
    @IBOutlet weak var michrophoneContainer: UIView!
    @IBOutlet weak var michrophoneContainerBottomContainer: NSLayoutConstraint!
    @IBOutlet weak var hideAuxilaryViewsButton: UIButton!
    
    var previewDataSource = StoryCreatorDataSource()
    var firebaseManager = FirebaseManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.firebaseManager.useFirebaseDatabase()
    
        previewCollection.dataSource = self.previewDataSource
        previewCollection.delegate = self.previewDataSource
        
        self.previewDataSource.delegate = self
        self.previewDataSource.presentVCDelegate = self
        
        self.michrophoneContainerBottomContainer.constant = -michrophoneContainer.frame.size.height
        
        NotificationCenter.default.addObserver(self, selector: #selector(StoryCreatorViewController.showHideAuxilaryViewsButton), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(StoryCreatorViewController.hideHideAuxilaryViewsButton), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func prepare(for segue: UIStoryboardSegue,
                 sender: Any?)
    {
        if let voiceToSpeechViewController = segue.destination as? VoiceToSpeechViewController
        {
            voiceToSpeechViewController.delegate = self
        }
        else if let checkInViewController = segue.destination as? CheckInViewController
        {
            checkInViewController.delegate = self
        }
    }
    
    @IBAction func hideAuxilaryViewsTapped(_ sender: UIButton)
    {
        self.view.endEditing(true)
        self.hideMicrophoneView()
    }
    
    func hideMicrophoneView()
    {
        self.michrophoneContainerBottomContainer.constant = -michrophoneContainer.frame.size.height
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        hideAuxilaryViewsButton.isHidden = true
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
}

extension StoryCreatorViewController: StoryCreatorDataSourceDelegate
{
    func particleAdded(_ particle:Particle)
    {
        switch particle {
            
        case is MicrophoneParticle:
            
            let isLastTextCell = self.lastCell() is TextParticleCell
            if !isLastTextCell
            {
                previewDataSource.newParticles.append(particle)
                previewCollection.reloadData()
            }
            self.showMicrophoneView()
            
        case is TextParticle:

            if let lastTextCell = self.lastCell() as? TextParticleCell
            {
                self.showKeyboard(textView: lastTextCell.textView)
                hideAuxilaryViewsButton.isHidden = true
            }
            else
            {
                previewDataSource.newParticles.append(particle)
                previewCollection.reloadData()
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
    
    func showMicrophoneView()
    {
        self.michrophoneContainerBottomContainer.constant = 0
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        hideAuxilaryViewsButton.isHidden = false
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

extension StoryCreatorViewController: VoiceToSpeechViewControllerDelegate
{
    func textFromMicrophoneUpdated(_ text: String)
    {
        if let workingTextParticle = previewCollection.cellForItem(at: IndexPath(row: previewDataSource.newParticles.count - 1, section:0) as IndexPath) as? TextParticleCell
        {
            workingTextParticle.updateText(text)
        }
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
