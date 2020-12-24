//
//  CategoryView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 24.12.2020.
//

import UIKit

class CategoryView: UIView {

    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = StyleConstants.Font.headline
        label.textColor = StyleConstants.Color.darkGray
        label.text = viewModel?.categoryName ?? ""
        return label
    }()
    
    lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = StyleConstants.Font.headline
        button.titleLabel?.textAlignment = .right
        button.setTitleColor(StyleConstants.Color.darkGray, for: .normal)
        button.setTitle(TextConstants.showAll, for: .normal)
        button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var searchResultView: SearchResultView = {
        let searchResultView = SearchResultView(scrollDirection: .horizontal)
        searchResultView.translatesAutoresizingMaskIntoConstraints = false
        return searchResultView
    }()
    
    var showAllTapped: (([SearchResult]) -> Void)?
    
    var viewModel: CategoryViewModel? {
        didSet {
            
            guard let viewModel = viewModel else {
                return
            }
            
            if viewModel.categoryName != oldValue?.categoryName {
                categoryLabel.text = viewModel.categoryName
            }
            
            searchResultView.searchResultViewModels = viewModel.searchResults.map({ SearchResultViewModel(searchResult: $0, sizeOption: viewModel.sizeOption) })
        }
    }

    init(viewModel: CategoryViewModel? = nil) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        configureSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureSubviews()
    }
    
    func configureSubviews() {
        configureButton()
        configureLabel()
        configureSearchResultView()
        
    }
    
    func configureButton() {
        self.addSubview(categoryButton)
        NSLayoutConstraint.activate([
            categoryButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            categoryButton.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16),
            categoryButton.heightAnchor.constraint(equalToConstant: 20.0),
            categoryButton.widthAnchor.constraint(equalToConstant: 120.0)
        ])
    }
    
    func configureLabel() {
        self.addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            categoryLabel.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16),
            categoryLabel.rightAnchor.constraint(equalTo: categoryButton.leftAnchor, constant: -16),
            categoryLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            categoryLabel.heightAnchor.constraint(equalToConstant: 20.0)
        ])
    }
        
    func configureSearchResultView() {
        self.addSubview(searchResultView)
        NSLayoutConstraint.activate([
            searchResultView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            searchResultView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            searchResultView.topAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: 8.0),
            searchResultView.heightAnchor.constraint(equalToConstant: viewModel?.sizeOption == .small ? 265.0 : 430.0)
        ])
    }
    
    @objc func categoryButtonTapped() {
        showAllTapped?(viewModel?.searchResults ?? [])
    }
    
}
