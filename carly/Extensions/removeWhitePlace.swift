//
//  removeWhitePlace.swift
//  carly
//
//  Created by Alexander Murphy on 10/24/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import Foundation
extension String {
    func filter(pred: (Character) -> Bool) -> String {
        var res = String()
        for c in self.characters {
            if pred(c) {
                res.append(c)
            }
        }
        return res
    }
}
