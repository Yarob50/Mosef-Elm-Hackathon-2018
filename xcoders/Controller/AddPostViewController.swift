//
//  AddPostViewController.swift
//  DesignerNewsApp
//
//  Created by Ammar.
//  Copyright (c) 2018. All rights reserved.
//

import UIKit
import Spring

protocol AddPostViewControllerDelegate: class {
    func resetButtonPressed(_ sender: AnyObject)
}

class AddPostViewController: UIViewController {
    
    @IBOutlet weak var modelView: SpringView!
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var criticalitySlider: UISlider!
    @IBOutlet weak var criticalityLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    weak var delegate: AddPostViewControllerDelegate?
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modelView.transform = CGAffineTransform(translationX: 0, y: 400)
        modelView.animation = AnimationPreset.SqueezeUp.rawValue
        modelView.animateFrom = true
        resetButton.alpha = 0
        criticalitySlider.value = 0
        
        locationLabel.text = address
        
        picker.delegate = self
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        sender.value = sender.value.rounded()
        if sender.value == 1 {
            criticalityLabel.text = "عادية"
            criticalityLabel.textColor = Color.criticality[2]
            sender.minimumTrackTintColor = Color.criticality[2]
        } else if sender.value == 2 {
            criticalityLabel.text = "متوسطة"
            criticalityLabel.textColor = Color.criticality[1]
            sender.minimumTrackTintColor = Color.criticality[1]
        } else if sender.value == 3 {
            criticalityLabel.text = "خطيرة"
            criticalityLabel.textColor = Color.criticality[0]
            sender.minimumTrackTintColor = Color.criticality[0]
        }
    }
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        guard let lat = latitude, let long = longitude, let token = defaults.string(forKey: "token"), let add = address else { return }
        let params: [String: Any] = [
            "latitude": lat,
            "longitude": long,
            "description": add,
            "metadata_key": "IncidentCriticality",
            "metadata": [
                "criticality": Int(criticalitySlider.value),
                "status": 1
            ]
        ]
        
        let headers: [String: String] = [
            "Authorization": "bearer 8dd766e8360a959695fef66fe53489d3ed6fd971aa97e004d6748e15554646b5"
        ]
        
        let image = imageButton.image(for: .normal)
        if image == #imageLiteral(resourceName: "upload") {
            PostRequest.addPost(with: params, headers: headers) { (err, res) in
                
            }
        } else {
            PostRequest.addPost(with: params, headers: headers, image: image!) { (err) in
                guard err == nil else { return }
                print(err)
            }
        }
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func imageButtonTapped(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.picker.allowsEditing = false
            self.picker.sourceType = UIImagePickerControllerSourceType.camera
            self.picker.cameraCaptureMode = .photo
            self.picker.modalPresentationStyle = .fullScreen
            self.present(self.picker,animated: true,completion: nil)
        } else {
            self.noCamera()
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        
//        UIApplication.shared.sendAction(#selector(SpringViewController.maximizeView(_:)), to: nil, from: self, for: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
//        UIApplication.shared.sendAction(#selector(SpringViewController.minimizeView(_:)), to: nil, from: self, for: nil)
        
        modelView.animate()
        UIView.animate(withDuration: 0.2) {
            self.resetButton.alpha = 1
        }
        
    }
}

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageButton.setImage(chosenImage, for: .normal)
        imageButton.setRounded()
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
}

