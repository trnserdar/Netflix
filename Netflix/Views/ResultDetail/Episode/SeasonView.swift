//
//  SeasonView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 26.12.2020.
//

import UIKit

class SeasonView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleConstants.Font.title2
        label.textColor = StyleConstants.Color.darkGray
        label.text = TextConstants.seasons
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        layout.minimumLineSpacing = 8.0
        
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = StyleConstants.Color.lightGray
        collectionView.keyboardDismissMode = .onDrag
        collectionView.register(SeasonCollectionViewCell.self, forCellWithReuseIdentifier: SeasonCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    var viewModels: [EpisodeResultViewModel] = [] {
        didSet {
            collectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.old, context: nil)
            collectionView.reloadData()
        }
    }

    var heightConstraint: NSLayoutConstraint?
    var seasonSelected: ((EpisodeResultViewModel) -> Void)?
    
    init(viewModels: [EpisodeResultViewModel] = []) {
        self.viewModels = viewModels
        super.init(frame: .zero)
        self.backgroundColor = StyleConstants.Color.lightGray
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        configureLabel()
        configureCollectionView()
    }

    func configureLabel() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            titleLabel.heightAnchor.constraint(equalToConstant: 20.0)
        ])
        
    }
    
    func configureCollectionView() {
        self.addSubview(collectionView)
        heightConstraint = collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 46)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0),
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

extension SeasonView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        seasonSelected?(viewModels[indexPath.row])
    }
}

extension SeasonView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCollectionViewCell.identifier, for: indexPath) as! SeasonCollectionViewCell
        cell.configureCell(viewModel: viewModels[indexPath.row])
        return cell
    }
}

extension SeasonView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: viewModels[indexPath.row].itemWidth, height: viewModels[indexPath.row].itemHeight)
    }
}
