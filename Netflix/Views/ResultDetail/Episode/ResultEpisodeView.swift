//
//  ResultEpisodeView.swift
//  Netflix
//
//  Created by SERDAR TURAN on 26.12.2020.
//

import UIKit

class ResultEpisodeView: UIView {

    lazy var seasonView: SeasonView = {
        let seasonView = SeasonView()
        seasonView.translatesAutoresizingMaskIntoConstraints = false
        return seasonView
    }()
    
    lazy var episodeView: EpisodeView = {
        let episodeView = EpisodeView()
        episodeView.translatesAutoresizingMaskIntoConstraints = false
        return episodeView
    }()
    
    var episodeResultViewModels: [EpisodeResultViewModel] = [] {
        didSet {
            seasonView.viewModels = episodeResultViewModels
            if episodeViewModels.isEmpty,
               let first = episodeResultViewModels.first,
               let episodes = first.episodeResult.episodes {
                self.episodeViewModels = episodes.filter({ $0.episode != nil }).map({ EpisodeViewModel(episode: $0.episode! )})
            }
        }
    }
    
    var episodeViewModels: [EpisodeViewModel] = [] {
        didSet {
            episodeView.viewModels = episodeViewModels
        }
    }

    init(episodeResultViewModels: [EpisodeResultViewModel] = [], episodeViewModels: [EpisodeViewModel] = []) {
        self.episodeResultViewModels = episodeResultViewModels
        self.episodeViewModels = episodeViewModels
        super.init(frame: .zero)
        
        self.backgroundColor = StyleConstants.Color.lightGray
        configureSubviews()
        
        seasonView.seasonSelected = { [weak self] viewModel in
            guard let self = self else { return }
            guard let episodes = viewModel.episodeResult.episodes else { return }
            self.episodeViewModels = episodes.filter({ $0.episode != nil }).map({ EpisodeViewModel(episode: $0.episode! )})
            for index in 0..<self.episodeResultViewModels.count {
                self.episodeResultViewModels[index].isSelected = self.episodeResultViewModels[index].episodeResult == viewModel.episodeResult ? true : false
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureSubviews() {
        configureSeasonView()
        configureEpisodeView()
    }
    
    func configureSeasonView() {
        self.addSubview(seasonView)
        NSLayoutConstraint.activate([
            seasonView.leftAnchor.constraint(equalTo: self.leftAnchor),
            seasonView.rightAnchor.constraint(equalTo: self.rightAnchor),
            seasonView.topAnchor.constraint(equalTo: self.topAnchor),
            seasonView.heightAnchor.constraint(greaterThanOrEqualToConstant: 46)
        ])
    }
    
    func configureEpisodeView() {
        self.addSubview(episodeView)
        NSLayoutConstraint.activate([
            episodeView.leftAnchor.constraint(equalTo: self.leftAnchor),
            episodeView.rightAnchor.constraint(equalTo: self.rightAnchor),
            episodeView.topAnchor.constraint(equalTo: seasonView.layoutMarginsGuide.bottomAnchor),
            episodeView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            episodeView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0.0)
        ])
    }
    
}
