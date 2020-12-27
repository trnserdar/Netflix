//
//  ResultCategoryView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 25.12.2020.
//

import UIKit

class ResultCategoryView: UIView {

    lazy var collectionView: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        layout.minimumLineSpacing = 8
        
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = StyleConstants.Color.lightGray
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(ResultCategoryCollectionViewCell.self, forCellWithReuseIdentifier: ResultCategoryCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.old, context: nil)
        return collectionView
    }()
    
    var viewModels: [GenreViewModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var heightConstraint: NSLayoutConstraint?
    var genreSelected: ((GenreViewModel) -> Void)?
    
    init(viewModels: [GenreViewModel] = []) {
        self.viewModels = viewModels
        super.init(frame: .zero)
        self.backgroundColor = StyleConstants.Color.lightGray
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        configureCollectionView()
    }

    func configureCollectionView() {
        self.addSubview(collectionView)
        heightConstraint = collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 46)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            heightConstraint!
        ])
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if object != nil,
            let collectionView = object as? UICollectionView,
            keyPath != nil,
            keyPath == "contentSize",
            change != nil {
            
            heightConstraint?.constant = collectionView.contentSize.height
            collectionView.removeObserver(self, forKeyPath: "contentSize")
        }
    }
}

extension ResultCategoryView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        genreSelected?(viewModels[indexPath.row])
    }
}

extension ResultCategoryView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResultCategoryCollectionViewCell.identifier, for: indexPath) as! ResultCategoryCollectionViewCell
        cell.configureCell(viewModel: viewModels[indexPath.row])
        return cell
    }

}

extension ResultCategoryView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: viewModels[indexPath.row].itemWidth, height: viewModels[indexPath.row].itemHeight)
    }
}
