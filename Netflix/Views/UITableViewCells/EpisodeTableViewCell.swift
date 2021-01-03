//
//  EpisodeTableViewCell.swift
//  Netflix
//
//  Created by SERDAR TURAN on 26.12.2020.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {

    lazy var episodeImageView: UIImageView = {
       
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleConstants.Font.body!
        label.textColor = StyleConstants.Color.darkGray
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    lazy var summaryLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleConstants.Font.footnote!
        label.textColor = StyleConstants.Color.darkGray
        label.numberOfLines = 0
        return label
    }()
    
    static let identifier = "EpisodeTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = StyleConstants.Color.lightGray
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func configureSubviews() {
        configureImageView()
        configureTitleLabel()
        configureSummaryLabel()
    }
    
    func configureImageView() {
        self.addSubview(episodeImageView)
        NSLayoutConstraint.activate([
            episodeImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            episodeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            episodeImageView.widthAnchor.constraint(equalToConstant: 130.0),
            episodeImageView.heightAnchor.constraint(equalToConstant: 72.0),
            episodeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0)
        ])
    }
    
    func configureTitleLabel() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: episodeImageView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: episodeImageView.rightAnchor, constant: 12.0),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 12.0)
        ])
    }
    
    func configureSummaryLabel() {
        self.addSubview(summaryLabel)
        NSLayoutConstraint.activate([
            summaryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
            summaryLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            summaryLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            summaryLabel.bottomAnchor.constraint(equalTo: episodeImageView.bottomAnchor)
        ])
    }
    
    func configureCell(viewModel: EpisodeViewModel) {
        episodeImageView.kf.setImage(with: viewModel.imageURL)
        titleLabel.text = viewModel.titleText
        summaryLabel.text = viewModel.summaryText
    }

}
