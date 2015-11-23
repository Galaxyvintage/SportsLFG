//
// File  : SharedImageCache.swift
// Author: Charles Li
// Date created  : Nov.22 2015
// Date edited   : Nov.22 2015
// Description   : This class is used to create a singleton image cache class 
//                 so that it can be accessed by any view controller 
//

import Foundation


class SharedImageCache
{
  //MARK:Properties
  var imageCache = NSCache()
  static let ImageCache = SharedImageCache()
}
