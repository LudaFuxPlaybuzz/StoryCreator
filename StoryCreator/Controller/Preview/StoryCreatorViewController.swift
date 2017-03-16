//
//  ViewController.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/21/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit

class StoryCreatorViewController: UIViewController, UIGestureRecognizerDelegate, StoryCreatorDataSourceDelegate, PresentViewControllerDelegate, VoiceToSpeechViewControllerDelegate
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
    }

    override func prepare(for segue: UIStoryboardSegue,
                 sender: Any?)
    {
        if let voiceToSpeechViewController = segue.destination as? VoiceToSpeechViewController
        {
            voiceToSpeechViewController.delegate = self
        }
    }
    
    func particleAdded(_ particle:Particle)
    {
        let lastCell = previewCollection.cellForItem(at: IndexPath(row: previewDataSource.newParticles.count - 1, section:0) as IndexPath)
        
        switch particle {
        
        case is MicrophoneParticle:
            
            let isLastTextCell = lastCell is TextParticleCell
            if !isLastTextCell
            {
                previewDataSource.newParticles.append(particle)
                previewCollection.reloadData()
            }
            self.showMicrophoneView()
            
        case is TextParticle:
            
            let isLastTextCell = lastCell is TextParticleCell
            if !isLastTextCell
            {
                previewDataSource.newParticles.append(particle)
                previewCollection.reloadData()
            }
            
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
    
    func hideMicrophoneView()
    {
        self.michrophoneContainerBottomContainer.constant = -michrophoneContainer.frame.size.height
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
        hideAuxilaryViewsButton.isHidden = true
    }
    
    @IBAction func didPan(_ sender: Any)
    {
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
    }
    
    @IBAction func hideAuxilaryViewsTapped(_ sender: UIButton)
    {
        self.hideMicrophoneView()
    }
    
    func present(_ viewController:UIViewController, animated: Bool)
    {
        self.present(viewController, animated: true) {}
    }

    func textFromMicrophoneUpdated(_ text: String)
    {
        if let workingTextParticle = previewCollection.cellForItem(at: IndexPath(row: previewDataSource.newParticles.count - 1, section:0) as IndexPath) as? TextParticleCell
        {
            workingTextParticle.updateText(text)
        }
    }
}




