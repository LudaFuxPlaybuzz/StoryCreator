//
//  ViewController.swift
//  StoryCreator
//
//  Created by Luda Fux on 12/21/16.
//  Copyright © 2016 Playbuzz. All rights reserved.
//

import UIKit
import DKImagePickerController
import AnimatedTextInput
import Firebase

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,NewParticlesCollectionTableViewCellProtocol, WebViewFallbackCellProtocol
{
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var particlesTable: UITableView!
    @IBOutlet weak var particlesTableHeight: NSLayoutConstraint!
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleTextField: AnimatedTextInput!
    @IBOutlet weak var descriptionTextField: AnimatedTextInput!
    
    let descriptionBackgroundBorder = CAShapeLayer()
    var newParticles = [NewParticleObject]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        createButton.layer.masksToBounds = true
        createButton.layer.cornerRadius = 6
     
//        self.useFirebaseDatabase()
        
        titleTextField.style = TitleInputStyle() as AnimatedTextInputStyle
        titleTextField.backgroundColor = UIColor.clear
        titleTextField.placeHolderText = "Title"
        
        descriptionTextField.style = DescriptionInputStyle() as AnimatedTextInputStyle
        descriptionTextField.placeHolderText = "Description"
        descriptionTextField.type = .multiline
        
        particlesTable.rowHeight = UITableViewAutomaticDimension
        particlesTable.estimatedRowHeight = 140
        
        containerHeightConstraint.constant = self.view.frame.height
        self.view.needsUpdateConstraints()
    }
    
//    func useFirebaseDatabase()
//    {
//        let ref = FIRDatabase.database().reference()
//        ref.child("articles").child("article2").setValue(["title": "Igal is awesome!"])
//    }
//    
    func reloadTable()
    {
        particlesTable.reloadData()
    }
    
    override func viewDidLayoutSubviews()
    {
//        particlesTableHeight.constant = particlesTable.contentSize.height
        
//        containerHeightConstraint.constant = particlesTable.contentSize.height + 300
    }
    
    @IBAction func didPressCameraButton(_ sender: Any)
    {
        let pickerController = DKImagePickerController()
        pickerController.singleSelect = true
        
        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            if assets.count > 0
            {
                let asset: DKAsset = assets[0]
                asset.fetchImageWithSize(self.coverImage.frame.size, completeBlock: { image, info in
                        self.coverImage.image = image
                })
            }
        }
        
        self.present(pickerController, animated: true) {}
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return newParticles.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.row == newParticles.count
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(IconsCollectionCell.self), for: indexPath) as? IconsCollectionCell
            {
                cell.delegate = self
                return cell
            }
        }
        else
        {
            if let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(WebViewFallbackCell.self), for: indexPath) as? WebViewFallbackCell
            {
                let particle = newParticles[indexPath.row]
                cell.setDetails(particle: particle)
                cell.delegate = self
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            newParticles .remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        }
    }
    
    //MARK: Reordering
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        return (indexPath.row != newParticles.count)
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let source = newParticles[sourceIndexPath.row]
        let destination = newParticles[destinationIndexPath.row]
        newParticles[sourceIndexPath.row] = destination
        newParticles[destinationIndexPath.row] = source
    }
    
    func didSelectNewParticle(particle:NewParticleObject)
    {
        newParticles.append(particle)
        particlesTable.reloadData()
        self.viewDidLayoutSubviews()
     }
    
    @IBAction func didPressCreateButton(_ sender: Any)
    {
        var storyContent = ""
        
        for index in 0...newParticles.count
        {
            if let particleCell = particlesTable.cellForRow(at: IndexPath(row: index, section:0)) as? WebViewFallbackCell
            {
                storyContent += particleCell.getParticleData()
            }
        }
        
        let alertController = UIAlertController(title: "Story Content", message:
            storyContent, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    struct TitleInputStyle: AnimatedTextInputStyle {
        
        let activeColor = UIColor.white
        let inactiveColor = UIColor.white
        let lineInactiveColor = UIColor.white.withAlphaComponent(0.3)
        let errorColor = UIColor.red
        let textInputFont = UIFont.systemFont(ofSize: 25)
        let textInputFontColor = UIColor.white
        let placeholderMinFontSize: CGFloat = 9
        let counterLabelFont: UIFont? = UIFont.systemFont(ofSize: 9)
        let leftMargin: CGFloat = 0
        let topMargin: CGFloat = 20
        let rightMargin: CGFloat = 15
        let bottomMargin: CGFloat = 10
        let yHintPositionOffset: CGFloat = 7
        let yPlaceholderPositionOffset: CGFloat = 7

    }
    
    struct DescriptionInputStyle: AnimatedTextInputStyle {
        
        let activeColor = UIColor.gray.withAlphaComponent(0.3)
        let inactiveColor = UIColor.gray.withAlphaComponent(0.3)
        let lineInactiveColor = UIColor.clear
        let errorColor = UIColor.red
        let textInputFont = UIFont.systemFont(ofSize: 20)
        let textInputFontColor = UIColor.black
        let placeholderMinFontSize: CGFloat = 9
        let counterLabelFont: UIFont? = UIFont.systemFont(ofSize: 9)
        let leftMargin: CGFloat = 15
        let topMargin: CGFloat = 20
        let rightMargin: CGFloat = 10
        let bottomMargin: CGFloat = 15
        let yHintPositionOffset: CGFloat = 7
        let yPlaceholderPositionOffset: CGFloat = 7
        
    }

}



