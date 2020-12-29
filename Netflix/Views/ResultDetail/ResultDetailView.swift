//
//  ResultDetailView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 24.12.2020.
//

import UIKit

class ResultDetailView: BaseView {

    lazy var favoriteBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: StyleConstants.Image.heart, style: .plain, target: self, action: #selector(favoriteBarButtonItemTapped))
        barButtonItem.tintColor = .red
        return barButtonItem
    }()
    
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
        let titleDetailView = TitleDetailView()
        titleDetailView.translatesAutoresizingMaskIntoConstraints = false
        return titleDetailView
    }()
    
    lazy var summaryView: SummaryView = {
        let summaryView = SummaryView()
        summaryView.translatesAutoresizingMaskIntoConstraints = false
        return summaryView
    }()
    
    lazy var resultCategoryView: ResultCategoryView = {
        let resultCategoryView = ResultCategoryView()
        resultCategoryView.translatesAutoresizingMaskIntoConstraints = false
        return resultCategoryView
    }()
    
    lazy var resultAllCastView: ResultAllCastView = {
        let resultAllCastView = ResultAllCastView()
        resultAllCastView.translatesAutoresizingMaskIntoConstraints = false
        return resultAllCastView
    }()
    
    lazy var resultEpisodeView: ResultEpisodeView = {
        let resultEpisodeView = ResultEpisodeView()
        resultEpisodeView.translatesAutoresizingMaskIntoConstraints = false
        return resultEpisodeView
    }()
    
    var viewModel: ResultDetailViewModel? {
        didSet {
            configureSubviews()
            
            guard let viewModel = viewModel else {
                return
            }
            
            self.configureView(viewModel: viewModel)
        }
    }
    
    var favoriteSelected: ((SearchResult) -> Void)?

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
            configureSummaryView()
            configureResultCategoryView()
        }
        
        if viewModel != nil &&
            viewModel!.allCastIsEnabled {
            configureResultAllCastView()
        }
        
        if viewModel != nil &&
            viewModel!.episodesIsEnabled {
            configureResultEpisodeView()
        }
    }
    
    func configureScrollView() {
        guard !self.subviews.contains(scrollView) else { return }
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
        guard !scrollView.subviews.contains(stackView) else { return }
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
        guard !stackView.subviews.contains(titleDetailView) else { return }
        stackView.addArrangedSubview(titleDetailView)
        NSLayoutConstraint.activate([
            titleDetailView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            titleDetailView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50.0)
        ])
        
    }
    
    func configureSummaryView() {
        guard !stackView.subviews.contains(summaryView) else { return }
        stackView.addArrangedSubview(summaryView)
        NSLayoutConstraint.activate([
            summaryView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            summaryView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100.0)
        ])
        
    }
    
    func configureResultCategoryView() {
        guard !stackView.subviews.contains(resultCategoryView) else { return }
        stackView.addArrangedSubview(resultCategoryView)
        NSLayoutConstraint.activate([
            resultCategoryView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            resultCategoryView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0)
        ])
        
    }
    
    func configureResultAllCastView() {
        guard !stackView.subviews.contains(resultAllCastView) else { return }
        stackView.addArrangedSubview(resultAllCastView)
        NSLayoutConstraint.activate([
            resultAllCastView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            resultAllCastView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0)
        ])
        
    }
    
    func configureResultEpisodeView() {
        guard !stackView.subviews.contains(resultEpisodeView) else { return }
        stackView.addArrangedSubview(resultEpisodeView)
        NSLayoutConstraint.activate([
            resultEpisodeView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            resultEpisodeView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0)
        ])
        
    }
    
    func configureView(viewModel: ResultDetailViewModel) {
        titleDetailView.viewModel = viewModel
        summaryView.viewModel = viewModel
        resultCategoryView.viewModels = viewModel.genreViewModels
        resultAllCastView.viewModel = viewModel
        favoriteBarButtonItem.image = viewModel.favoriteButtonImage
    }
    
    @objc func favoriteBarButtonItemTapped() {
        
        guard let viewModel = self.viewModel,
              let netflixInfo = viewModel.titleDetail.nfinfo else {
            return
        }
        
        favoriteSelected?(netflixInfo)
    }
}
