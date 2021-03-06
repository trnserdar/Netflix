//
//  SearchResultCollectionViewCell.swift
//  Netflix
//
//  Created by SERDAR TURAN on 21.12.2020.
//

import UIKit
import Kingfisher

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false        
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var ratingView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = StyleConstants.Color.turquoise?.withAlphaComponent(0.8)
        view.layer.cornerRadius = 20.0
        return view
    }()
    
    lazy var ratingLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleConstants.Font.headline!
        label.textColor = StyleConstants.Color.darkGray
        label.textAlignment = .center
        return label
    }()
    
    lazy var favoriteView: UIView = {
        
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        view.layer.cornerRadius = 20.0
        return view
    }()
    
    lazy var favoriteButton: UIButton = {
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFill
        button.tintColor = .red
        button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    static let identifier = "SearchResultCollectionViewCell"
    var favoriteButtonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = StyleConstants.Color.lightGray
        configureImageView()
        configureFavoriteView()
        configureRatingView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureImageView() {
        
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            imageView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ])
    }
    
    func configureFavoriteView() {
        self.addSubview(favoriteView)
        NSLayoutConstraint.activate([
            favoriteView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            favoriteView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 8),
            favoriteView.widthAnchor.constraint(equalToConstant: 40.0),
            favoriteView.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
        favoriteView.addSubview(favoriteButton)
        NSLayoutConstraint.activate([
            favoriteButton.centerXAnchor.constraint(equalTo: favoriteView.centerXAnchor),
            favoriteButton.centerYAnchor.constraint(equalTo: favoriteView.centerYAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 40.0),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
    
    func configureRatingView() {
        
        self.addSubview(ratingView)
        NSLayoutConstraint.activate([
            ratingView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8),
            ratingView.topAnchor.constraint(equalTo: self.favoriteView.bottomAnchor, constant: 8),
            ratingView.widthAnchor.constraint(equalToConstant: 40.0),
            ratingView.heightAnchor.constraint(equalToConstant: 40.0)
        ])
        
        ratingView.addSubview(ratingLabel)
        NSLayoutConstraint.activate([
            ratingLabel.leftAnchor.constraint(equalTo: ratingView.leftAnchor),
            ratingLabel.rightAnchor.constraint(equalTo: ratingView.rightAnchor),
            ratingLabel.topAnchor.constraint(equalTo: ratingView.layoutMarginsGuide.topAnchor),
            ratingLabel.bottomAnchor.constraint(equalTo: ratingView.layoutMarginsGuide.bottomAnchor)
        ])
    
    }
    
    func configureCell(viewModel: SearchResultViewModel) {
        imageView.kf.setImage(with: viewModel.imageURL)
        ratingView.isHidden = viewModel.ratingIsHidden
        ratingLabel.text = viewModel.ratingText
        favoriteButton.setImage(viewModel.favoriteButtonImage, for: .normal)
    }

    @objc func favoriteButtonTapped() {
        favoriteButtonAction?()
    }
}
