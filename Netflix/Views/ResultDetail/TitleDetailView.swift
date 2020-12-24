//
//  TitleDetailView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 24.12.2020.
//

import UIKit

class TitleDetailView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleConstants.Font.largeTitle
        label.textColor = StyleConstants.Color.darkGray
        label.text = viewModel.titleText
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = StyleConstants.Color.lightGray
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10.0
        return stackView
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleConstants.Font.body
        label.textColor = StyleConstants.Color.darkGray
        label.text = viewModel.releaseDateText
        return label
    }()
    
    lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleConstants.Font.body
        label.textColor = StyleConstants.Color.darkGray
        label.text = viewModel.countryText
        return label
    }()
    
    lazy var runtimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleConstants.Font.body
        label.textColor = StyleConstants.Color.darkGray
        label.text = viewModel.runtimeText
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
        configureTitleLabel()
        configureStackView()
        
        if viewModel.releaseDateIsEnabled {
            configureYearLabel()
        }
        
        if viewModel.countryIsEnabled {
            configureCountryLabel()
        }
        
        if viewModel.runtimeIsEnabled {
            configureRuntimeLabel()
        }
    }
    
    func configureTitleLabel() {
        self.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0)
        ])
        
    }
    
    func configureStackView() {
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor),
            stackView.rightAnchor.constraint(lessThanOrEqualTo: self.titleLabel.rightAnchor),
            stackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            stackView.heightAnchor.constraint(equalToConstant: 30.0),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
        ])
    }
    
    func configureYearLabel() {
        stackView.addArrangedSubview(yearLabel)
        NSLayoutConstraint.activate([
            yearLabel.widthAnchor.constraint(equalToConstant: 35.0)
        ])

    }
    
    func configureCountryLabel() {
        stackView.addArrangedSubview(countryLabel)
        NSLayoutConstraint.activate([
            countryLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30.0)
        ])

    }
    
    func configureRuntimeLabel() {
        stackView.addArrangedSubview(runtimeLabel)
        NSLayoutConstraint.activate([
            runtimeLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 30.0)
        ])

    }
    
}
