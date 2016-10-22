
//
//  ImageDownloader.swift
//  carly
//
//  Created by Alexander Murphy on 10/22/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloader {
    static func donwloadImage(image_url: String) {
        let image = NSData(contentsOf: NSURL(string: image_url) as! URL)
        print(image)
        //return UIImage(data: image! as Data)!
    }
}
