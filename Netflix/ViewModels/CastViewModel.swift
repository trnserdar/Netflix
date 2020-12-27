//
//  CastViewModel.swift
//  Netflix
//
//  Created by SERDAR TURAN on 27.12.2020.
//

import Foundation

struct CastViewModel {
    
    var person: Person
    
    var sectionCount: Int {
        return 3
    }
    
    func getRowCount(section: Int) -> Int {
        switch section {
        case 0:
            return person.director?.count ?? 0
        case 1:
            return person.creator?.count ?? 0
        case 2:
            return person.actor?.count ?? 0
        default:
            return 0
        }
    }
    
    func getPerson(section: Int, row: Int) -> String {
        switch section {
        case 0:
            if person.director != nil,
               person.director!.count > row {
                return person.director![row]
            }
            return ""
        case 1:
            if person.creator != nil,
               person.creator!.count > row {
                return person.creator![row]
            }
            return ""
        case 2:
            if person.actor != nil,
               person.actor!.count > row {
                return person.actor![row]
            }
            return ""
        default:
            return ""
        }
    }
    
    func getTitle(section: Int) -> String {
        switch section {
        case 0:
            return TextConstants.director
        case 1:
            return TextConstants.creator
        case 2:
            return TextConstants.actor
        default:
            return ""
        }
    }
}
