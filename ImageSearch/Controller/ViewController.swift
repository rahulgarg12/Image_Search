//
//  ViewController.swift
//  ImageSearch
//
//  Created by Rahul Garg on 17/04/19.
//  Copyright © 2019 Rahul Garg. All rights reserved.
//

import UIKit
import RealmSwift


class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    @IBOutlet weak var imageCollectionView: UICollectionView! {
        didSet {
            imageCollectionView.delegate = self
            imageCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var gridOptionButton: UIButton! {
        didSet {
            gridOptionButton.addTarget(self,
                                       action: #selector(didTapGridOptionButton(_:)),
                                       for: .touchUpInside)
            updateGridOptionButtonText()
        }
    }
    
    
    var gridColumn: GridColumnOption = .two
    
    var viewModel: ViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
}


//MARK:- Helper Methods
extension ViewController {
    
    func loadMoreImages(for searchText: String? = nil) {
        viewModel?.fetchImagesFor(searchText: searchText) { [weak self] success in
            if !success {
                return
            }
            
            self?.viewModel?.page += 1
            DispatchQueue.main.async {
                self?.reloadCollectionView()
            }
        }
    }
    
    func reloadCollectionView() {
        imageCollectionView.reloadData()
    }
    
    private func updateGridOptionButtonText() {
        gridOptionButton.setTitle("Select Grid (\(gridColumn.rawValue) columns)", for: .normal)
    }
}



//MARK: Alert Helpers
extension ViewController {
    
    private func showGridColumnOptionsView() {
        let alert = UIAlertController(title: "Select Grid Columns",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        let grid2 = UIAlertAction(title: "2 Columns", style: .default) { _ in
            self.gridColumn = .two
            self.reloadCollectionView()
            self.updateGridOptionButtonText()
        }
        let grid3 = UIAlertAction(title: "3 Columns", style: .default) { _ in
            self.gridColumn = .three
            self.reloadCollectionView()
            self.updateGridOptionButtonText()
        }
        let grid4 = UIAlertAction(title: "4 Columns", style: .default) { _ in
            self.gridColumn = .four
            self.reloadCollectionView()
            self.updateGridOptionButtonText()
        }
        let cancel = UIAlertAction(title: "Dimsiss", style: .cancel, handler: nil)
        
        [grid2, grid3, grid4, cancel].forEach { alert.addAction($0) }
        
        present(alert,
                animated: true,
                completion: nil)
    }
    
    
    func showCachedDataFoundAlert(searchText: String, cachedItems: Results<ImageModel>) {
        let alert = UIAlertController(title: "Cached result found!",
                                      message: "Do you want to see the cached result for \(searchText) or fetch the latest one?", preferredStyle: .alert)
        
        let cachedAction = UIAlertAction(title: "Cached", style: .default) { (_) in
            self.viewModel?.addToList(items: cachedItems)
            self.reloadCollectionView()
        }
        let latestAction = UIAlertAction(title: "Fetch", style: .default) { (_) in
            DispatchQueue.main.async {
                self.viewModel?.removeCachedDataFor(searchText: searchText)
                
                self.loadMoreImages(for: searchText)
            }
        }
        
        [cachedAction,latestAction].forEach { alert.addAction($0) }
        
        present(alert,
                animated: true,
                completion: nil)
    }
}


//MARK: Selectors
extension ViewController {
    
    @objc func didTapGridOptionButton(_ sender: UIButton) {
        showGridColumnOptionsView()
    }
}
