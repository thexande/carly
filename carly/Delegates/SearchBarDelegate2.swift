//
//  SearchBarDelegate.swift
//  carly
//
//  Created by Alexander Murphy on 10/22/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit

protocol SearchBarControllerDelegate {
    func startSearching()
    func searchButtonTapped()
    func cancelButtonTapped()
    func didChangeSearchText(_ searchText: String)
}

class SearchBarDelegate: UISearchBar, UISearchBarDelegate {
    var searchBar: UISearchBar!
    var searchBarControllerDelegate: SearchBarControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
