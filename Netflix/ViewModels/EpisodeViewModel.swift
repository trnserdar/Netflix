//
//  EpisodeViewModel.swift
//  Netflix
//
//  Created by SERDAR TURAN on 26.12.2020.
//

import Foundation

struct EpisodeViewModel {
    
    var episode: Episode
    
    var imageURL: URL? {
        
        guard let urlString = episode.image else {
            return nil
        }
        
        return URL(string: urlString)
    }
    
    var titleText: String {
        var titleText = ""
        if episode.epnum != nil {
            titleText += "\(episode.epnum!). "
        }
        
        if episode.title != nil {
            titleText += "\(episode.title!)"
        }

        return titleText
    }
    
    var summaryText: String {
        return episode.synopsis ?? ""
    }
}
