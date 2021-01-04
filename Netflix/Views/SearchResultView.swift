//
//  SearchResultView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 22.12.2020.
//

import Foundation
import UIKit

class SearchResultView: UIView {
    
    lazy var collectionView: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        layout.minimumLineSpacing = 16.0
        layout.scrollDirection = scrollDirection
        
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = StyleConstants.Color.lightGray
        collectionView.keyboardDismissMode = .onDrag
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
     
    var scrollDirection: UICollectionView.ScrollDirection = .vertical
    var viewModels: [SearchResultViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var resultSelected: ((SearchResult) -> Void)?
    var favoriteSelected: ((SearchResult) -> Void)?
    
    init(scrollDirection: UICollectionView.ScrollDirection = .vertical) {
        self.scrollDirection = scrollDirection
        super.init(frame: .zero)
        configureSubviews()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    func configureSubviews() {
        configureCollectionView()
    }
    
    func configureCollectionView() {
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
}

extension SearchResultView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        resultSelected?(viewModels[indexPath.row].searchResult)
    }
}

extension SearchResultView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.identifier, for: indexPath) as! SearchResultCollectionViewCell
        cell.favoriteButtonAction = { [weak self] in
            guard let self = self else { return }
            self.favoriteSelected?(self.viewModels[indexPath.row].searchResult)
        }
        cell.configureCell(viewModel: viewModels[indexPath.row])
        return cell
    }

}

extension SearchResultView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: viewModels[indexPath.row].itemWidth, height: viewModels[indexPath.row].itemHeight)
    }
}
