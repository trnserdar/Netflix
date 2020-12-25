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
    
    var viewModels: [EpisodeResultViewModel] = [] {
        didSet {
            seasonView.viewModels = viewModels
        }
    }
    
    init(viewModels: [EpisodeResultViewModel] = []) {
        self.viewModels = viewModels
        super.init(frame: .zero)
        
        self.backgroundColor = StyleConstants.Color.lightGray
        configureSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureSubviews() {
        configureSeasonView()
    }
    
    func configureSeasonView() {
        self.addSubview(seasonView)
        NSLayoutConstraint.activate([
            seasonView.leftAnchor.constraint(equalTo: self.leftAnchor),
            seasonView.rightAnchor.constraint(equalTo: self.rightAnchor),
            seasonView.topAnchor.constraint(equalTo: self.topAnchor),
            seasonView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            seasonView.heightAnchor.constraint(greaterThanOrEqualToConstant: 46)
        ])
    }
    
}
