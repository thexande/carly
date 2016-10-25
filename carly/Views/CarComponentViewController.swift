//
//  CarComponentViewController.swift
//  carly
//
//  Created by Alexander Murphy on 10/22/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage
import DZNEmptyDataSet
import Foundation


class CarComponentViewController:
    UIViewController,
    UITableViewDelegate,
    UITableViewDataSource,
    UISearchResultsUpdating,
    UISearchBarDelegate,
    CustomSearchControllerDelegate,
    DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate {

    @IBOutlet weak var tblSearchResults: UITableView!
    @IBOutlet weak var carDetailView: UIView!
    @IBOutlet weak var carDetailImage: UIImageView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var carDetailFooter: UIView!
    @IBOutlet weak var carDetailMakeLabel: UILabel!
    @IBOutlet weak var carDetailModelLabel: UILabel!
    @IBOutlet weak var carDetailYearLabel: UILabel!
    @IBOutlet weak var carDetailMileage: UILabel!
    
    let carData: JSON = CarModel.getAllCars()!
    var carDataArray: [JSON]? = []
    var filteredCarArray: [JSON]? = []
    
    var dataArray = [String]()
    var filteredArray = [String]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    var customSearchController: CustomSearchController!
    var carDetailVisible: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // register cell nib
        tblSearchResults.register(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: "CarCell")
        // set car data array
        self.carDataArray = carData.arrayValue

        tblSearchResults.delegate = self
        tblSearchResults.dataSource = self
        tblSearchResults.separatorColor = UIColor.white
        
        //empty data set
        tblSearchResults.emptyDataSetSource = self
        tblSearchResults.emptyDataSetDelegate = self
        tblSearchResults.tableFooterView = UIView()
        tblSearchResults.reloadData()
        
        // Uncomment the following line to enable the default search controller.
        //configureSearchController()
        
        // Our custom search bar configuration
        configureCustomSearchController()
        
        // animate car detail view
        print("animate")
        AnimationHelper.animateUp(carSubView: self.carDetailView, carTable: self.tblSearchResults, searchView: self.searchView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: public recieveVoiceText
    public func recieveVoiceText(voice: String) {
        // load table view results from user speech string
        print("in view controller!!", voice)
        
        // set car data array
        self.carDataArray = carData.arrayValue
        
        
        print("car data here !", carDataArray)
        
        self.filteredCarArray = carDataArray?.filter({ (car) -> Bool in
            
            let carMake: NSString = car["make"].stringValue as NSString
            let carModel: NSString = car["model"].stringValue as NSString
            let carYear: NSString = car["year"].stringValue as NSString
            
            let carDataString: String = "\(carMake),\(carModel),\(carYear)" as String
            print(carDataString.score(voice))
            
            return (carDataString.score(voice) > 0.1)
        })
//        // Reload the tableview.
       shouldShowSearchResults = true
        
        //tblSearchResults.reloadData()
    }
    
    // MARK: DZNDataSource
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No cars have matched your search. \n\n\n\n\n\n\n\n"
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    
    // MARK: UITableView Delegate and Datasource functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return self.filteredCarArray!.count
        }
        else {
            return self.carDataArray!.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath) as! CarTableViewCell
        if shouldShowSearchResults {
            let currentCar = self.filteredCarArray?[indexPath.row]
           
            let remoteImageURLString = currentCar?["image_url"].stringValue
            if (remoteImageURLString != nil) {
                let remoteImageURL = NSURL(string: remoteImageURLString!)
                cell.carImageView.sd_setImage(with: remoteImageURL as URL!, placeholderImage: UIImage(named: "car"), options: SDWebImageOptions.progressiveDownload)
            }
            cell.car = currentCar
        }
        else {
            let currentCar = self.carDataArray?[indexPath.row]
            let remoteImageURLString = currentCar?["image_url"].stringValue
            if (remoteImageURLString != nil) {
                let remoteImageURL = NSURL(string: remoteImageURLString!)
                cell.carImageView.sd_setImage(with: remoteImageURL as URL!, placeholderImage: UIImage(named: "car"), options: SDWebImageOptions.progressiveDownload)
            }
            cell.car = currentCar
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        print("row selected: ", indexPath.row)
        if !carDetailVisible {
            carDetailVisible = true
            let selectedCar = self.carDataArray?[indexPath.row]
            print(selectedCar)
            carDetailMakeLabel.text = selectedCar?["make"].stringValue
            carDetailModelLabel.text = selectedCar?["model"].stringValue
            carDetailYearLabel.text = selectedCar?["year"].stringValue
            carDetailMileage.text = selectedCar?["mileage"].stringValue
            
            AnimationHelper.animateDown(carSubView: self.carDetailView, carTable: self.tblSearchResults, searchView: self.searchView)
        } else {
            let selectedCar = self.carDataArray?[indexPath.row]
            print(selectedCar)
            carDetailMakeLabel.text = selectedCar?["make"].stringValue
            carDetailModelLabel.text = selectedCar?["model"].stringValue
            carDetailYearLabel.text = selectedCar?["year"].stringValue
            carDetailMileage.text = selectedCar?["mileage"].stringValue
        }
        
        
        if shouldShowSearchResults {
            let currentCar = self.filteredCarArray?[indexPath.row]
            carDetailMakeLabel.text = currentCar?["make"].stringValue
            carDetailModelLabel.text = currentCar?["model"].stringValue
            carDetailYearLabel.text = currentCar?["year"].stringValue
            carDetailMileage.text = currentCar?["mileage"].stringValue
            
            let remoteImageURLString = currentCar?["image_url"].stringValue
            if (remoteImageURLString != nil) {
                let remoteImageURL = NSURL(string: remoteImageURLString!)
                carDetailImage.sd_setImage(with: remoteImageURL as URL!, placeholderImage: UIImage(named: "car"), options: SDWebImageOptions.progressiveDownload)
            }
        }
        else {
            let currentCar = self.carDataArray?[indexPath.row]
            carDetailMakeLabel.text = currentCar?["make"].stringValue
            carDetailModelLabel.text = currentCar?["model"].stringValue
            carDetailYearLabel.text = currentCar?["year"].stringValue
            carDetailMileage.text = currentCar?["mileage"].stringValue
            let remoteImageURLString = currentCar?["image_url"].stringValue
            if (remoteImageURLString != nil) {
                let remoteImageURL = NSURL(string: remoteImageURLString!)
                carDetailImage.sd_setImage(with: remoteImageURL as URL!, placeholderImage: UIImage(named: "car"), options: SDWebImageOptions.progressiveDownload)
            }
        }
    }
    
    // MARK: Custom functions
    func configureSearchController() {
        // Initialize and perform a minimum configuration to the search controller.
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        // Include the search bar within the navigation bar.
        //navigationItem.titleView = searchController.searchBar;
        
        // Place the search bar view to the tableview headerview.
        tblSearchResults.tableHeaderView = searchController.searchBar
    }
    
    func configureCustomSearchController() {
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRect(x: 0.0, y: 0.0, width: tblSearchResults.frame.width, height: 50.0), searchBarFont: UIFont(name: "Arial Rounded MT Bold", size: 16.0)!, searchBarTextColor: UIColor.white, searchBarTintColor: UIColor(red:0.56, green:0.07, blue:1.00, alpha:1.0))
        customSearchController.customSearchBar.placeholder = "Search For Your Next Car!"
        searchView.addSubview(customSearchController.customSearchBar)
        customSearchController.customDelegate = self
    }
    
    // MARK: UISearchBarDelegate functions
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tblSearchResults.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tblSearchResults.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tblSearchResults.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
    
    // MARK: UISearchResultsUpdating delegate function
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else {
            return
        }

        
        filteredCarArray = carDataArray?.filter({ (car) -> Bool in
            let carMake: NSString = car["make"].stringValue as NSString
            let carModel: NSString = car["model"].stringValue as NSString
            let carYear: NSString = car["year"].stringValue as NSString
            
            
            let carDataNSString: NSString = "\(carMake),\(carModel),\(carYear)" as NSString
            let carDataString: String = "\(carMake),\(carModel),\(carYear)" as String
            
            print(searchString)
            print(carDataString.score(searchString))
            
            return (carDataString.score(searchString) > 0.1)
            //return (carDataNSString.range(of: searchString, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        
        // Reload the tableview.
        tblSearchResults.reloadData()
    }
    
    
    // MARK: CustomSearchControllerDelegate functions
    
    func didStartSearching() {
        if carDetailVisible {
            AnimationHelper.animateUp(carSubView: self.carDetailView, carTable: self.tblSearchResults, searchView: self.searchView)
            carDetailVisible = false
        }
        shouldShowSearchResults = true
        tblSearchResults.reloadData()
    }
    
    
    func didTapOnSearchButton() {
         if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tblSearchResults.reloadData()
        }
    }
    
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        tblSearchResults.reloadData()
    }
    
    
    func didChangeSearchText(_ searchText: String) {

        filteredCarArray = carDataArray?.filter({ (car) -> Bool in
            let carMake: NSString = car["make"].stringValue as NSString
            let carModel: NSString = car["model"].stringValue as NSString
            let carYear: NSString = car["year"].stringValue as NSString
            
            
            let carDataNSString: NSString = "\(carMake),\(carModel),\(carYear)" as NSString
            let carDataString: String = "\(carMake),\(carModel),\(carYear)" as String
            print(searchText)
            print(carDataString.score(searchText))
            
            return (carDataString.score(searchText) > 0.1)
            //return (carDataNSString.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        // Reload the tableview.
        tblSearchResults.reloadData()
    }
}
