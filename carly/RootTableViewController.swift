//
//  RootTableViewController.swift
//  carly
//
//  Created by Alexander Murphy on 10/21/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage


class RootTableViewController: UITableViewController {
    
    let carData: JSON = CarModel.getAllCars()!
    var carDataArray: [JSON]?
    
    override func viewDidLoad() {
      
        tableView.rowHeight = 100
        
        self.carDataArray = carData.arrayValue
        
        super.viewDidLoad()
        // register cell nib
        tableView.register(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: "CarCell")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.carData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:CarTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as! CarTableViewCell
        let currentCar = self.carDataArray?[indexPath.row]
//        sd web image
        let remoteImageURLString = currentCar?["image_url"].stringValue
        
        if (remoteImageURLString != nil) {
            let remoteImageURL = NSURL(string: remoteImageURLString!)
            print("url here", remoteImageURL?.absoluteString)
            //        let imageBlock: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType!, imageURL: NSURL!) -> Void in
            //
            //            print("Image with url \(remoteImageURL!.absoluteString) is loaded")
            //
            //        }
            cell.carImageView.sd_setImage(with: remoteImageURL as URL!, placeholderImage: UIImage(named: "github-sign"), options: SDWebImageOptions.progressiveDownload)
        }
        
         //Configure the cell...
        cell.car = currentCar
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
