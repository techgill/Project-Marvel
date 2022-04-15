//
//  CharactersViewController.swift
//  Kolo
//
//  Created by Hardeep on 14/04/22.
//

import UIKit
import SafariServices

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var vm: CharactersViewModel
    
    var noDataLabel: UILabel!
    var searchController: UISearchController!
    var searchHistoryTableViewController: SearchHistoryTableViewController!
    
    init() {
        self.vm = CharactersViewModel()
        super.init(nibName: "CharactersViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addNoDataLabel()
        setUpNavBar()
        setUpCollectionView()
        vm.callNetCharcters(offset: 0)
        bindUI()
        
    }
    
    func addNoDataLabel() {
        noDataLabel = Utilities.getNoDataLabel(text: AAConstants.nothingHere)
        collectionView.addSubview(noDataLabel)
        noDataLabel.isHidden = true
    }
    
    func setUpNavBar() {
        searchHistoryTableViewController = SearchHistoryTableViewController()
        searchHistoryTableViewController.delegate = self
        
        searchController = UISearchController(searchResultsController: searchHistoryTableViewController)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = AAConstants.searchBarPlaceholder
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
    }
    
    func setUpCollectionView() {
        collectionView.register(UINib(nibName: AAConstants.comicCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: AAConstants.comicCollectionViewCell)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func bindUI() {
        vm.observer.bind {[weak self] _ in
            DispatchQueue.main.async {
                self?.updateBindUI()
            }
        }
    }
    
    func updateBindUI() {
        noDataLabel.isHidden = vm.getCellCount() != 0
        collectionView.reloadData()
    }

}

extension CharactersViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            Utilities.history.insert(searchText, at: 0)
            Utilities.saveHistory()
            searchController.isActive = false
            searchController.searchBar.text = searchText
            vm.searchText = searchText
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = vm.searchText, searchText != "" {
            vm.searchText = ""
        }
    }
}

extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.searchTextField.isFirstResponder {
          searchController.showsSearchResultsController = true
        }
    }
 }

extension CharactersViewController: SearchHistoryTableViewDelegate {
    func didSelect(token: UISearchToken) {
        if let searchText = token.representedObject as? String {
            vm.searchText = searchText
            searchController.isActive = false
            searchController.searchBar.text = searchText
        }
    }
}

extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return vm.getCellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.getCellCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AAConstants.comicCollectionViewCell, for: indexPath) as? ComicCollectionViewCell else {return UICollectionViewCell()}
        cell.fillDetails(vm: self.vm, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == vm.getCellCount() - 1 {
            vm.callPagination(index: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let url = URL(string: vm.getUrl(index: indexPath.row)) {
            let safariVC = SFSafariViewController(url: url)
            self.present(safariVC, animated: true, completion: nil)
        }
    }
}
