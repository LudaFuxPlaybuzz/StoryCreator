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
        previewCollection.reloadData()
    }
    
    @IBAction func didPan(_ sender: Any)
    {
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil);
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




