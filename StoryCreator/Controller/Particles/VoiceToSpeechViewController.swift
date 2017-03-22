//
//  VoiceToSpeechViewController.swift
//  StoryCreator
//
//  Created by Luda Fux on 3/14/17.
//  Copyright © 2017 Playbuzz. All rights reserved.
//

import UIKit
import Speech

@objc protocol VoiceToSpeechViewControllerDelegate: class
{
    func textFromMicrophoneUpdated(_ text: String)
}

class VoiceToSpeechViewController: UIViewController, SFSpeechRecognizerDelegate
{
    @IBOutlet weak var recordingPromptLabel: UILabel!
    
    var recordingPrompt: String!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var isRecording = false
    
    weak var delegate: VoiceToSpeechViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        speechRecognizer?.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isRecordingEnabled = false
            
            switch authStatus {
            case .authorized:
                isRecordingEnabled = true
                
            case .denied:
                isRecordingEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isRecordingEnabled = false
                print("Speech recognition restricted on this device")
                
            case .notDetermined:
                isRecordingEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation() {
            }
        }
        
        recordingPrompt = "Start Recording!"
        self.startRecording()
    }

    @IBAction func cancelButtonPressed(_ sender: Any)
    {
        
    }
    
    func startRecording() {
        
//        recordingPromptLabel.text = "Recording..."
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
            
                self.delegate?.textFromMicrophoneUpdated((result?.bestTranscription.formattedString)!)
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            
        } else {
            
        }
    }
}


