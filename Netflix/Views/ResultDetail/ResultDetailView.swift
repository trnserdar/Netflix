//
//  ResultDetailView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 24.12.2020.
//

import UIKit

class ResultDetailView: UIView {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = StyleConstants.Color.lightGray
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = StyleConstants.Color.lightGray
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 0.0
        return stackView
    }()
    
    lazy var titleDetailView: TitleDetailView = {
        let titleDetailView = TitleDetailView(viewModel: viewModel!)
        titleDetailView.translatesAutoresizingMaskIntoConstraints = false
        return titleDetailView
    }()
    
    var viewModel: ResultDetailViewModel?
    
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
        configureScrollView()
        configureStackView()
        
        if viewModel != nil {
            configureTitleDetailView()
        }
    }
    
    func configureScrollView() {
        self.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: self.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])

    }
    
    func configureStackView() {
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    func configureTitleDetailView() {
        stackView.addArrangedSubview(titleDetailView)
        NSLayoutConstraint.activate([
            titleDetailView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            titleDetailView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100.0)
        ])
    }
}
