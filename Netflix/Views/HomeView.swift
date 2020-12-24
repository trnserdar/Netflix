//
//  HomeView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 23.12.2020.
//

import UIKit

class HomeView: UIView {

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
    
    lazy var newReleaseView : CategoryView = {
        let categoryView = CategoryView(viewModel: viewModel.newRelease)
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        return categoryView
    }()
    
    lazy var actionView : CategoryView = {
        let categoryView = CategoryView(viewModel: viewModel.action)
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        return categoryView
    }()
    
    var viewModel: HomeViewModel = HomeViewModel() {
        didSet {
            
            newReleaseView.viewModel = viewModel.newRelease
            actionView.viewModel = viewModel.action
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSubviews()
    }

    func configureSubviews() {
        configureScrollView()
        configureStackView()
        configureNewReleaseView()
        configureActionView()
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
    
    func configureNewReleaseView() {
        stackView.addArrangedSubview(newReleaseView)
        NSLayoutConstraint.activate([
            newReleaseView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            newReleaseView.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            newReleaseView.topAnchor.constraint(equalTo: stackView.topAnchor),
            newReleaseView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            newReleaseView.heightAnchor.constraint(equalToConstant: 482)
        ])
    }
    
    func configureActionView() {
        stackView.addArrangedSubview(actionView)
        NSLayoutConstraint.activate([
            actionView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            actionView.heightAnchor.constraint(equalToConstant: 317)
        ])
    }
}
