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

    @IBOutlet weak var carSubView: CarlyHeaderView!
    @IBOutlet weak var carTable: UIView!
    
    @IBOutlet weak var carDetailMakeLabel: UILabel!
    @IBOutlet weak var carDetailModelLabel: UILabel!

    
    @IBAction func contract(_ sender: AnyObject) {
        //AnimationHelper.animateDown(carSubView: self.carSubView, carTable: self.carTable)
    }
    
    @IBAction func expandView(_ sender: AnyObject) {
        //AnimationHelper.animateUp(carSubView: self.carSubView, carTable: self.carTable)
    }
    
    override func viewDidLoad() {
        
        //show message for 2 seconds
//        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
//        DispatchQueue.main.asyncAfter(deadline: when) {
//            AnimationHelper.animateUp(carSubView: self.carSubView, carTable: self.carTable)
//        }
        
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
