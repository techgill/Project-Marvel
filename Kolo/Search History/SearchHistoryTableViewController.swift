//
//  SearchHistoryTableViewController.swift
//  Kolo
//
//  Created by Hardeep on 15/04/22.
//

import UIKit

protocol SearchHistoryTableViewDelegate {
  func didSelect(token: UISearchToken)
}

class SearchHistoryTableViewController: UITableViewController {
    
    var noDataLabel: UILabel!
    var searchTokens: [UISearchToken] = []
    var delegate: SearchHistoryTableViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        addNoDataLabel()
        setUpTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        makeTokens()
    }
    
    func addNoDataLabel() {
        noDataLabel = Utilities.getNoDataLabel(text: AAConstants.nothingHere)
        tableView.addSubview(noDataLabel)
        noDataLabel.isHidden = true
    }
    
    func setUpTableView() {
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: AAConstants.searchHistoryTokenTableViewCell, bundle: nil), forCellReuseIdentifier: AAConstants.searchHistoryTokenTableViewCell)
    }
    
    func makeTokens() {
        searchTokens = Utilities.history.map { (history) -> UISearchToken in
            let token = UISearchToken(icon: nil, text: history)
            token.representedObject = history
            return token
        }
        noDataLabel.isHidden = searchTokens.count != 0
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTokens.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AAConstants.searchHistoryTokenTableViewCell, for: indexPath) as? SearchHistoryTokenTableViewCell else {return UITableViewCell()}
        if let token = searchTokens[indexPath.row].representedObject as? String {
            cell.historyLabel.text = token
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(token: searchTokens[indexPath.row])
    }

}
