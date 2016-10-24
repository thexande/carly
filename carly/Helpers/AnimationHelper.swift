//
//  AnimationHelper.swift
//  carly
//
//  Created by Alexander Murphy on 10/22/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit

class AnimationHelper {
    static func animateUp(carSubView: UIView, carTable: UIView, searchView: UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            var carViewFrame = carSubView.frame
            var carTableFrame = carTable.frame
            var searchFrame = searchView.frame
            
            carViewFrame.origin.y -= carViewFrame.size.height
            carViewFrame.origin.y -= 50
            carSubView.frame = carViewFrame
            
//            searchFrame.origin.y -= carViewFrame.size.height
//            searchView.frame = searchFrame
            
            carTableFrame.origin.y -= carViewFrame.size.height
            carTableFrame.size.height += carViewFrame.size.height
            carTable.frame = carTableFrame
        })
    }
    static func animateDown(carSubView: UIView, carTable: UIView, searchView: UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            var carViewFrame = carSubView.frame
            var carTableFrame = carTable.frame
            var searchFrame = searchView.frame

            
            carViewFrame.origin.y += carViewFrame.size.height
            carViewFrame.origin.y += 50
            carSubView.frame = carViewFrame
            
//            searchFrame.origin.y += carViewFrame.size.height
//            searchView.frame = searchFrame
            
            carTableFrame.origin.y += carViewFrame.size.height
            carTableFrame.size.height -= carViewFrame.size.height
            carTable.frame = carTableFrame
        })
    }
}
