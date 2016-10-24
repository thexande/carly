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

class CarComponentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, UISearchBarDelegate, CustomSearchControllerDelegate {

    @IBOutlet weak var tblSearchResults: UITableView!
    @IBOutlet weak var carDetailView: UIView!
    @IBOutlet weak var carDetailImage: UIImageView!
    
    let carData: JSON = CarModel.getAllCars()!
    var carDataArray: [JSON]? = []
    var filteredCarArray: [JSON]? = []
    
    var dataArray = [String]()
    var filteredArray = [String]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    var customSearchController: CustomSearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // register cell nib
        tblSearchResults.register(UINib(nibName: "CarTableViewCell", bundle: nil), forCellReuseIdentifier: "CarCell")
        // set car data array
        self.carDataArray = carData.arrayValue

        tblSearchResults.delegate = self
        tblSearchResults.dataSource = self
        tblSearchResults.separatorColor = UIColor.black
        
        loadListOfCountries()
        
        // Uncomment the following line to enable the default search controller.
        //configureSearchController()
        
        // Comment out the next line to disable the customized search controller and search bar and use the default ones. Also, uncomment the above line.
        configureCustomSearchController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                cell.carImageView.sd_setImage(with: remoteImageURL as URL!, placeholderImage: UIImage(named: "github-sign"), options: SDWebImageOptions.progressiveDownload)
            }
            cell.car = currentCar
        }
        else {
            let currentCar = self.carDataArray?[indexPath.row]
            let remoteImageURLString = currentCar?["image_url"].stringValue
            if (remoteImageURLString != nil) {
                let remoteImageURL = NSURL(string: remoteImageURLString!)
                cell.carImageView.sd_setImage(with: remoteImageURL as URL!, placeholderImage: UIImage(named: "github-sign"), options: SDWebImageOptions.progressiveDownload)
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
        
        if shouldShowSearchResults {
            let currentCar = self.filteredCarArray?[indexPath.row]
            
            let remoteImageURLString = currentCar?["image_url"].stringValue
            if (remoteImageURLString != nil) {
                let remoteImageURL = NSURL(string: remoteImageURLString!)
                carDetailImage.sd_setImage(with: remoteImageURL as URL!, placeholderImage: UIImage(named: "github-sign"), options: SDWebImageOptions.progressiveDownload)
            }
        }
        else {
            let currentCar = self.carDataArray?[indexPath.row]
            let remoteImageURLString = currentCar?["image_url"].stringValue
            if (remoteImageURLString != nil) {
                let remoteImageURL = NSURL(string: remoteImageURLString!)
                carDetailImage.sd_setImage(with: remoteImageURL as URL!, placeholderImage: UIImage(named: "github-sign"), options: SDWebImageOptions.progressiveDownload)
            }
        }
    }
    // MARK: Custom functions
    
    func loadListOfCountries() {
        // Specify the path to the countries list file.
        let pathToFile = Bundle.main.path(forResource: "countries", ofType: "txt")
        
        if let path = pathToFile {
            // Load the file contents as a string.
            let countriesString = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
            
            // Append the countries from the string to the dataArray array by breaking them using the line change character.
            dataArray = countriesString.components(separatedBy: "\n")
            
            // Reload the tableview.
            tblSearchResults.reloadData()
        }
    }
    
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
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRect(x: 0.0, y: 0.0, width: tblSearchResults.frame.size.width, height: 50.0), searchBarFont: UIFont(name: "Futura", size: 16.0)!, searchBarTextColor: UIColor.white, searchBarTintColor: UIColor.purple)
        customSearchController.customSearchBar.placeholder = "Search For Your Next Car!"
        carDetailView.addSubview(customSearchController.customSearchBar)
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
        
        // Filter the data array and get only those countries that match the search text.
        filteredArray = dataArray.filter({ (country) -> Bool in
            let countryText:NSString = country as NSString
            
            return (countryText.range(of: searchString, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        filteredCarArray = carDataArray?.filter({ (car) -> Bool in
            let carMake: NSString = car["make"].stringValue as NSString
            return (carMake.range(of: searchString, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        
        // Reload the tableview.
        tblSearchResults.reloadData()
    }
    
    
    // MARK: CustomSearchControllerDelegate functions
    
    func didStartSearching() {
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
        // Filter the data array and get only those countries that match the search text.
        filteredArray = dataArray.filter({ (country) -> Bool in
            let countryText: NSString = country as NSString
            
            return (countryText.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        filteredCarArray = carDataArray?.filter({ (car) -> Bool in
            let carMake: NSString = car["make"].stringValue as NSString
            return (carMake.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        // Reload the tableview.
        tblSearchResults.reloadData()
    }
}
