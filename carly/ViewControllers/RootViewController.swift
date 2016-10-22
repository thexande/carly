//
//  RootViewController.swift
//  carly
//
//  Created by Alexander Murphy on 10/21/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import SwiftyJSON


class RootViewController: UIViewController {

    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var carSubView: CarlyHeaderView!
    @IBOutlet weak var carsTable: UIView!
    
    @IBAction func expandView(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.7, animations: {
            var carViewFrame = self.carSubView.frame
            var carTableFrame = self.carsTable.frame
            
            carViewFrame.origin.y -= carViewFrame.size.height
            self.carSubView.frame = carViewFrame
            
            //CGRect newTableFrame = carTableFrame
            //newTableFrame.size = CGSizeMake(carTableFrame.size.width)
            carTableFrame.origin.y -= carViewFrame.size.height
            carTableFrame.size.height += carViewFrame.size.height
            self.carsTable.frame = carTableFrame
            
            // table view
//            var tableViewFrame = self.carsTable.frame
//            tableViewFrame.origin.y -= carViewFrame.size.height
//            self.tableViewHeight.constant = 500
            self.view.layoutIfNeeded()
            //self.carsTable.frame = tableViewFrame
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
