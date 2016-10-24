//
//  SpeechSearchViewController.swift
//  carly
//
//  Created by Alexander Murphy on 10/24/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit

class SpeechSearchViewController: UIViewController {
    @IBOutlet weak var speechButtonImage: UIImageView!

    @IBAction func searchButtonTouchUpInside(_ sender: AnyObject) {
        speechButtonImage.image = UIImage(named: "voice_button_state_1")
    }
    @IBAction func searchButtonTouchDown(_ sender: AnyObject) {
        speechButtonImage.image = UIImage(named: "voice_button_state_2")
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
