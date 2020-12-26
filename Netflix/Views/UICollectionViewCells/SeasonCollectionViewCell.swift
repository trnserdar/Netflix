//
//  SeasonCollectionViewCell.swift
//  Netflix
//
//  Created by SERDAR TURAN on 26.12.2020.
//

import UIKit

class SeasonCollectionViewCell: UICollectionViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleConstants.Font.body!
        label.textAlignment = .center
        label.layer.borderWidth = 1.0
        label.layer.borderColor = StyleConstants.Color.gray!.cgColor
        label.layer.cornerRadius = 15.0
        return label
    }()
    
    static let identifier = "SeasonCollectionViewCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = StyleConstants.Color.lightGray
        configureSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSubviews() {
        configureLabel()
    }
    
    func configureLabel() {
        self.addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: self.leftAnchor),
            label.rightAnchor.constraint(equalTo: self.rightAnchor),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configureCell(viewModel: EpisodeResultViewModel) {
        label.text = viewModel.seasonNameText
        label.layer.borderColor = viewModel.borderColor.cgColor
    }
}
