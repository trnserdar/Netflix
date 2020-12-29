//
//  GenresView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 22.12.2020.
//

import Foundation
import UIKit

class GenresView: BaseView {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = StyleConstants.Color.lightGray
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundColor = StyleConstants.Color.lightGray
        searchBar.isTranslucent = true
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = TextConstants.searchPlaceholder
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = .search
        searchBar.delegate = self
        return searchBar
    }()
    
    var filteredViewModels: [GenreViewModel] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var searchBarTextDidChange: ((String) -> Void)?
    var genreSelected: ((Genre) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSubviews()
    }

    func configureSubviews() {
        
        configureSearchBar()
        configureTableView()
    }
    
    func configureSearchBar() {
        self.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            searchBar.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor)
        ])
        
    }
    
    func configureTableView() {
        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
    }
    
}

extension GenresView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarTextDidChange?(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension GenresView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        genreSelected?(filteredViewModels[indexPath.row].genre)
    }
}

extension GenresView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = StyleConstants.Color.lightGray
        cell.selectionStyle = .none
        cell.textLabel?.font = StyleConstants.Font.body
        cell.textLabel?.text = filteredViewModels[indexPath.row].nameText
        return cell
    }
}
