//
//  SearchResultViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 21.12.2020.
//

import UIKit

class SearchResultViewController: UIViewController {

    lazy var collectionView: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16.0
        
        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = StyleConstants.Color.lightGray
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    
    var searchResults: [SearchResult] = [] {
        didSet {
            searchResultViewModels = searchResults.map({ SearchResultViewModel(searchResult: $0) })
        }
    }
    var searchResultViewModels: [SearchResultViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillLayoutSubviews() {
        configureCollectionView()
    }
    
    func configureCollectionView() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ])
        
    }
    
}

extension SearchResultViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("SearchResultViewController selected: \(searchResults[indexPath.row])")
    }
}

extension SearchResultViewController: UICollectionViewDataSource {
    
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

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: searchResultViewModels[indexPath.row].itemWidth, height: searchResultViewModels[indexPath.row].itemHeight)
    }
}
