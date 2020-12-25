//
//  EpisodeResultViewModel.swift
//  Netflix
//
//  Created by SERDAR TURAN on 26.12.2020.
//

import Foundation
import UIKit

struct EpisodeResultViewModel {
    
    var episodeResult: EpisodeResult
    
    var seasonNameText: String {
        return episodeResult.seasnum ?? ""
    }
    
    var itemWidth: CGFloat {
        return 30.0
    }
    
    var itemHeight: CGFloat {
        return 30.0
    }
}
