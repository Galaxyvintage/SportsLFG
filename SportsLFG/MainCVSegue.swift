//
// File   : MainCVSegue.swift
// Author : Charles Li
// Date created: Oct.11 2015
// Date edited : Oct.15 2015
// Description:

import Foundation

class MainCVSegue: UIStoryboardSegue {
  
  override func perform() {
    
    let TabBarController      = self.sourceViewController as! MainCVController
    let destinationController = self.destinationViewController as UIViewController
    
    
    for view in TabBarController.CV.subviews as [UIView] {
      view.removeFromSuperview()
      
    }
    NSLog("after ")
    
    //  Add view to placeholder view
    //  TabBarController.addChildViewController(rootViewController)
    TabBarController.currentViewController = destinationController
    TabBarController.CV.addSubview(destinationController.view)
    
    
    
    TabBarController.CV.translatesAutoresizingMaskIntoConstraints = false
    destinationController.view.translatesAutoresizingMaskIntoConstraints = false
    
    
    let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[v1]-0-|", options: .AlignAllTop, metrics: nil, views: ["v1": destinationController.view])
    
    TabBarController.CV.addConstraints(horizontalConstraint)
    
    let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[v1]-0-|", options: .AlignAllTop, metrics: nil, views: ["v1": destinationController.view])
    
    TabBarController.CV.addConstraints(verticalConstraint)
    destinationController.didMoveToParentViewController(TabBarController)
    
  }
  
  
  
  
  
  
}