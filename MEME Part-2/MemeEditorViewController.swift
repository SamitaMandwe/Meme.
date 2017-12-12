//
//  MemeEditorViewController.swift
//  MEME Part-1
//
//  Created by Samita Mandwe on 10/21/17.
//  Copyright © 2017 udacity. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class MemeEditorViewController: MemeTextAttribute,UIImagePickerControllerDelegate , UINavigationControllerDelegate,UITextFieldDelegate  {
    
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTextFields(textField: topTextField, text: "TOP")
        prepareTextFields(textField: bottomTextField, text:"Bottom")
        shareButton.isEnabled = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        subscribeToKeyboardNotifications()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Pick image from photoLibrary or Camera.
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        var sourceType: UIImagePickerControllerSourceType = UIImagePickerControllerSourceType.camera
        
        if sender.title == "Album" {
            sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        self.present( imagePickerController, animated: true, completion: nil)
        
    }
    // MARK: Functinon for when activity button is selected, calling the activityViewController
    @IBAction func shareActivity(_ sender: Any) {
        let memecreated = generateMemedImage()
        let activityController = UIActivityViewController(activityItems: [memecreated], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender as? UIView
        present(activityController, animated: true, completion: nil)
        activityController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func cancelActivity(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        imageView.image = nil
        shareButton.isEnabled = false
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        if let imagePicked = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.contentMode = .scaleAspectFit
            imageView.image = imagePicked
            shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Delegate functions
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text! as NSString
        newText = newText.replacingCharacters(in: range, with: string) as NSString
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if topTextField.text == "TOP" || bottomTextField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK:  Keyboard Functions for subscribing to keyboard notifications and shifting the view whenever the keyboard
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y = getKeyboardHeight(notification) * (-1)
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        if bottomTextField.isFirstResponder {
            return keyboardSize.cgRectValue.height
        } else {
            return 0
        }
    }
    
    func configureNavToolbars (isHidden: Bool) {
        topToolbar.isHidden = isHidden
        bottomToolbar.isHidden = isHidden
        navigationController?.navigationBar.isHidden = isHidden
    }
    
    //MARK: Generate the meme image function
    func generateMemedImage() -> UIImage {
        configureNavToolbars(isHidden: true)
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        configureNavToolbars(isHidden: false)
        return memedImage
    }
    
    // MARK: Configure textfields
    func prepareTextFields(textField: UITextField, text: String){
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = self
        textField.backgroundColor = UIColor.clear
    }
    //MARK: Save function for saving the meme
    func save() {
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        
        //MARK: Code for saving to the app delegate's memes array
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
}
