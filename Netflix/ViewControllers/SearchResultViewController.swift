//
//  SearchResultViewController.swift
//  Netflix
//
//  Created by SERDAR TURAN on 21.12.2020.
//

import UIKit

class SearchResultViewController: UIViewController {

    var searchResultView = SearchResultView()
    var genre: Genre?
    var searchResults: [SearchResult] = [] {
        didSet {
            searchResultViewModels = searchResults.map({ SearchResultViewModel(searchResult: $0) })
        }
    }
    var searchResultViewModels: [SearchResultViewModel] = [] {
        didSet {
            searchResultView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        view = searchResultView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultView.collectionView.delegate = self
        searchResultView.collectionView.dataSource = self
        navigationItem.title = genre?.name ?? ""
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
