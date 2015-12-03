//
// File   : MainCVSegue.swift
// Author : Charles Li
// Date created: Oct.11 2015
// Date edited : Nov.22 2015
// Description:

import Foundation

class MainCVSegue: UIStoryboardSegue {
  
  override func perform() {
    
    weak var TabBarController = self.sourceViewController as! MainCVController
    let destinationController = self.destinationViewController as UIViewController
    
    
    //childViewControllers is an array that contains all the childViewControllers
    let childViewControllers  = TabBarController!.childViewControllers
    
    //check if the childViewControllers array is empty or not
    if(childViewControllers.count > 0)
    {
      //only need to check childViewControllers[0] since there must be only 1 child view controller 
      childViewControllers[0].view.removeFromSuperview()
      childViewControllers[0].removeFromParentViewController()
    }
    
    
    NSLog("after ")
    
    //  Add view to placeholder view
    //  TabBarController.addChildViewController(rootViewController)
    TabBarController!.currentViewController = destinationController
    TabBarController!.addChildViewController(destinationController)
    destinationController.didMoveToParentViewController(TabBarController)
    TabBarController!.CV.addSubview(destinationController.view)
    
    
    
    TabBarController!.CV.translatesAutoresizingMaskIntoConstraints = false
    destinationController.view.translatesAutoresizingMaskIntoConstraints = false
    
    
    let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[v1]-0-|", options: .AlignAllTop, metrics: nil, views: ["v1": destinationController.view])
    
    TabBarController!.CV.addConstraints(horizontalConstraint)
    
    let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[v1]-0-|", options: .AlignAllTop, metrics: nil, views: ["v1": destinationController.view])
    
    TabBarController!.CV.addConstraints(verticalConstraint)
    
  }
  
  
  
  
  
  
}