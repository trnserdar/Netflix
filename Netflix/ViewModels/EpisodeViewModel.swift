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
        return "\(episode.epnum ?? "")." + " " + "\(episode.title ?? "")"
    }
    
    var summaryText: String {
        return episode.synopsis ?? ""
    }
}
