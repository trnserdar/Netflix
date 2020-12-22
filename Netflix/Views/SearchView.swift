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
        return collectionView
    }()
    
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
