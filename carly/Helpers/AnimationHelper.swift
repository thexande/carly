//
//  AnimationHelper.swift
//  carly
//
//  Created by Alexander Murphy on 10/22/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit

class AnimationHelper {
    static func animateUp(carSubView: UIView, carTable: UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            var carViewFrame = carSubView.frame
            var carTableFrame = carTable.frame
            carViewFrame.origin.y -= carViewFrame.size.height
            carSubView.frame = carViewFrame
            carTableFrame.origin.y -= carViewFrame.size.height
            carTableFrame.size.height += carViewFrame.size.height
            carTable.frame = carTableFrame
        })
    }
    static func animateDown(carSubView: UIView, carTable: UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            var carViewFrame = carSubView.frame
            var carTableFrame = carTable.frame
            carViewFrame.origin.y += carViewFrame.size.height
            carSubView.frame = carViewFrame
            carTableFrame.origin.y += carViewFrame.size.height
            carTableFrame.size.height -= carViewFrame.size.height
            carTable.frame = carTableFrame
        })
    }
}
