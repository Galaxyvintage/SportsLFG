//
// File   : HomeViewController.swift
// Author : Charles Li, Isaac Qiao
// Date created: Oct.13 2015
// Date edited : Nov.22 2015
// Description: This is responsible for the home view controller and further functions need to be added in version 2.0

import Foundation

class HomeViewController : UIViewController, UINavigationBarDelegate, UIBarPositioningDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    //MARK:Properties
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var PhotoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.delegate = self
    }
    
    ////////////////////
    //Delegate Methods//
    ////////////////////
    
    /*UIBar*/
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return UIBarPosition.TopAttached
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        PhotoImageView.image = selectedImage
        
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK:Actions
    @IBAction func Logout(sender: UIButton) {
        //let LoginControllerView=self.storyboard?.instantiateViewControllerWithIdentifier("LoginNavigationController")
        KCSUser.activeUser().logout()
        performSegueWithIdentifier("GoBackToLogin", sender: UIButton.self)
    }
    
    @IBAction func selectImageFromPhotoLibrary(sender: AnyObject) {
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
}