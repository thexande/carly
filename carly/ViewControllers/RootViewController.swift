//
//  RootViewController.swift
//  carly
//
//  Created by Alexander Murphy on 10/21/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var carSubView: CarlyHeaderView!
    
    @IBAction func expandView(_ sender: AnyObject) {
        UIView.animate(withDuration: 0.7, animations: {
            var carViewFrame = self.carSubView.frame
            carViewFrame.origin.y -= carViewFrame.size.height
            self.carSubView.frame = carViewFrame
        
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
