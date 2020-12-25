//
//  ResultAllCastView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 25.12.2020.
//

import Foundation
import UIKit

class ResultAllCastView: UIView {
    
    lazy var allCastButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(StyleConstants.Color.darkGray, for: .normal)
        button.setTitle("All Cast", for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = StyleConstants.Color.darkGray!.cgColor
        button.layer.cornerRadius = 15.0
        button.addTarget(self, action: #selector(allCastButtonTapped), for: .touchUpInside)
        return button
    }()

    var viewModel: ResultDetailViewModel? 
    var allCastButtonAction: ((ResultDetailViewModel) -> Void)?
    
    init(viewModel: ResultDetailViewModel? = nil) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        self.backgroundColor = StyleConstants.Color.lightGray
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureSubviews() {
        configureAllCastButton()
    }
    
    func configureAllCastButton() {
        self.addSubview(allCastButton)
        NSLayoutConstraint.activate([
            allCastButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            allCastButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            allCastButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            allCastButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0),
            allCastButton.heightAnchor.constraint(equalToConstant: 30.0)
        ])
    }

    @objc func allCastButtonTapped() {
        
        guard let viewModel = viewModel else {
            return
        }
        
        allCastButtonAction?(viewModel)
    }
}
