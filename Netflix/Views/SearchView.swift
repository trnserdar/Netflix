//
//  SearchView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 22.12.2020.
//

import Foundation
import UIKit

class SearchView: UIView {
    
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
    
    lazy var collectionView: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16.0
        
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = StyleConstants.Color.lightGray
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    var searchResultViewModels: [SearchResultViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var searchButtonTapped: ((String) -> Void)?
    var resultSelected: ((SearchResultViewModel) -> Void)?
    
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
        configureCollectionView()
    }
    
    func configureSearchBar() {
        self.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            searchBar.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor)
        ])
        
    }
    
    func configureCollectionView() {
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ])
        
    }
}

extension SearchView: UISearchBarDelegate {
        
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        
        guard let query = searchBar.text,
              query != "" else {
            return
        }
        
        searchButtonTapped?(query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension SearchView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        resultSelected?(searchResultViewModels[indexPath.row])
    }
}

extension SearchView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        cell.configureCell(viewModel: searchResultViewModels[indexPath.row])
        return cell
    }

}

extension SearchView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: searchResultViewModels[indexPath.row].itemWidth, height: searchResultViewModels[indexPath.row].itemHeight)
    }
}
