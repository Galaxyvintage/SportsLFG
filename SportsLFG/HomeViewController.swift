//
// File   : HomeViewController.swift
// Author : Charles Li, Isaac Qiao
// Date created: Oct.13 2015
// Date edited : Nov.22 2015
// Description: This is responsible for the home view controller and further functions need to be added in version 2.0

import Foundation
import Charts
   
class HomeViewController : UIViewController, UINavigationBarDelegate, UIBarPositioningDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
  //MARK:Properties
  @IBOutlet weak var navigationBar: UINavigationBar!
  @IBOutlet weak var PhotoImageView: UIImageView!
  
  @IBOutlet weak var barChartView: BarChartView!
  
  var ranges: [String]!
  weak var parent :  MainCVController!
  weak var imageCache : NSCache!
  
  
  func setChart(dataPoints: [String], values: [Double]) {
    barChartView.noDataText = "You need to provide data for the chart."
    var dataEntries: [BarChartDataEntry] = []
    
    for i in 0..<dataPoints.count {
      let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
      dataEntries.append(dataEntry)
    }
    
    let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "number of groups")
    
    let chartData = BarChartData(xVals: ranges, dataSet: chartDataSet)
    barChartView.data = chartData

    
  }
  
  
  
  override func viewDidLoad() 
  { 
    super.viewDidLoad()
    self.navigationBar.delegate = self
    barChartView.noDataText = "Hello, no data is provided"
    
    ranges = ["5km", "15km", "45km", "All"]
    let groupsCount = [10.0,20.0,30.0,190.0]
    setChart(ranges,values:groupsCount)
    
    //Use the SharedImageCache singleton class to store profile images 
    imageCache = SharedImageCache.ImageCache.imageCache
    
    
  }
  
  override func viewDidAppear(animated : Bool) 
  {
    super.viewDidAppear(animated)
    
    
    let image = imageCache.objectForKey("myImage") as? UIImage
    
    if(image != nil)//image is in the cache
    {
      self.PhotoImageView.image = image
    }
    else//the image is not in the cache
    {
      let currentUser = KCSUser.activeUser()
      
      //Download the profile image if it exists 
      KCSFileStore.downloadDataByName(
        (currentUser.userId)!,
        completionBlock: { (downloadedResources: [AnyObject]!, error: NSError!) -> Void in
          //returned data array is empty
          if(downloadedResources.count == 0)
          {
            return
          }
          else if (error == nil)
          {
            let file = downloadedResources[0] as! KCSFile
            let fileData = file.data
            var outputObject: NSObject! = nil
            if file.mimeType.hasPrefix("text") 
            {
              outputObject = NSString(data: fileData, encoding: NSUTF8StringEncoding)
            } 
            else if file.mimeType.hasPrefix("image/jpeg") 
            {
              //save the downloaded image to the NSCache
              outputObject = UIImage(data: fileData)
              self.PhotoImageView.image = outputObject as? UIImage
              self.imageCache.setObject(outputObject, forKey: "myImage") 
            }
            NSLog("downloaded: %@", outputObject)
          } 
          else 
          {
            NSLog("Got an error: %@", error)
          }
        },
        progressBlock: nil
      )
    }
  }
  
  
  //This method prepare the segue and change the sender button's state to selected
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if(segue.identifier == "EditProfile")
    {
      let navigationVC = segue.destinationViewController as! UINavigationController
      let sourceVC     = navigationVC.topViewController as! EditProfileController
      //This sets Editing profile's delegate object to ProfileTableViewController 
      sourceVC.delegateObject = (self.childViewControllers[0] as! ProfileTableViewController)
    }
    
    if(segue.identifier == "EmbedProfile")
    {
      let profileTableViewController = segue.destinationViewController as! ProfileTableViewController
      
      self.addChildViewController(profileTableViewController)
    }
    
    
    
  }  
  ////////////////////
  //Delegate Methods//
  ////////////////////
  
  
  /*UIBar*/
  func positionForBar(bar: UIBarPositioning) -> UIBarPosition 
  {
    return UIBarPosition.TopAttached
  }
  
  // MARK: UIImagePickerControllerDelegate
  func imagePickerControllerDidCancel(picker: UIImagePickerController) 
  {
    // Dismiss the picker if the user canceled.
    picker.dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) 
  {
    // The info dictionary contains multiple representations of the image, and this uses the original.
    let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    
    // Set photoImageView to display the selected image.
    PhotoImageView.image = selectedImage
    let metadata = KCSMetadata()
    metadata.setGloballyReadable(true)
    
    
    //TODO:Check corner
    KCSFileStore.uploadData(
      UIImageJPEGRepresentation(selectedImage,0.1),
      options:[
        KCSFileId       : (KCSUser.activeUser().userId)! ,
        KCSFileFileName : (KCSUser.activeUser().userId)!,
        KCSFileMimeType : "image/jpeg",
        KCSFileACL      : metadata
      ],
      completionBlock: { (uploadInfo: KCSFile!, error: NSError!) -> Void in
        if(error == nil)
        {
          NSLog("Upload finished. File id='%@'", uploadInfo.fileId)
          
          //save the new image to the NSCache dictionary 
          self.imageCache.setObject(selectedImage, forKey: "myImage")
          
          // Dismiss the picker.
          picker.dismissViewControllerAnimated(true, completion: nil)
        }
      }, 
      progressBlock: nil 
      
    )
  }
  
  
  
  //MARK:Actions
  @IBAction func Logout(sender: UIButton) 
  {
    KCSUser.activeUser().logout()
    let transition = CATransition()
    transition.duration = 2.0
    transition.type = kCATransitionReveal// = kCATransitionFade
    transition.subtype = kCATransitionFromRight
    
    if(self.presentingViewController?.restorationIdentifier == "FirstTimeUser")
    {
      self.parent.childViewControllers[0].view.removeFromSuperview()
      self.parent.childViewControllers[0].removeFromParentViewController()
      self.parent.presentingViewController?.presentingViewController?.view.layer.addAnimation(transition, forKey: kCATransition)
      self.parent.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(false, 
        completion: nil)
    }
    else
    {
      self.parent.childViewControllers[0].view.removeFromSuperview()
      self.parent.childViewControllers[0].removeFromParentViewController()
      self.parent.presentingViewController?.view.layer.addAnimation(transition, forKey: kCATransition)
      self.parent.presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }
  }

  
  @IBAction func selectImageFromPhotoLibrary(sender: AnyObject) 
  {
    NSLog("select image")
    // UIImagePickerController is a view controller that lets a user pick media from their photo library.
    let imagePickerController = UIImagePickerController()
    
    // Only allow photos to be picked, not taken.
    imagePickerController.sourceType = .PhotoLibrary
    
    // Make sure ViewController is notified when the user picks an image.
    imagePickerController.delegate = self    
    presentViewController(imagePickerController, animated: true, completion: nil)
  }
}