//
//  SummaryView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 25.12.2020.
//

import UIKit

class SummaryView: UIView {
    
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
        label.font = StyleConstants.Font.body!
        label.textColor = StyleConstants.Color.darkGray
        label.textAlignment = .center
        label.text = viewModel.ratingText
        return label
    }()
    
    lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleConstants.Font.body
        label.textColor = StyleConstants.Color.darkGray
        label.text = viewModel.summaryText
        label.numberOfLines = 0
        return label
    }()
    
    var viewModel: ResultDetailViewModel
    
    init(viewModel: ResultDetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.backgroundColor = StyleConstants.Color.lightGray
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        configureImageView()
        if viewModel.ratingIsEnabled {
            configureRatingView()
        }
        configureSummaryLabel()
    }
    
    func configureImageView() {
        imageView.kf.setImage(with: viewModel.imageURL)
        self.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            imageView.widthAnchor.constraint(equalToConstant: ((UIScreen.main.bounds.width - 32) / 2)),
            imageView.heightAnchor.constraint(equalToConstant: ((UIScreen.main.bounds.width - 32) / 2) * 1.4),
            imageView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -8)
        ])
        
    }
    
    func configureRatingView() {
        
        self.addSubview(ratingView)
        NSLayoutConstraint.activate([
            ratingView.rightAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: -8),
            ratingView.topAnchor.constraint(equalTo: self.imageView.topAnchor, constant: 8),
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
    
    func configureSummaryLabel() {
        self.addSubview(summaryLabel)
        NSLayoutConstraint.activate([
            summaryLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 12),
            summaryLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            summaryLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            summaryLabel.bottomAnchor.constraint(lessThanOrEqualTo: imageView.bottomAnchor)
        ])
        
    }

}
