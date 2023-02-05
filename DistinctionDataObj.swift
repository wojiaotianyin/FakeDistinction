//
//  DistinctionDataObj.swift
//  Fake Distinction
//
//  Created by Kushima Amane on 2023/01/28.
//

import Foundation

class DistinctionData: ObservableObject {
    struct JsonData:Codable {
        let ex: String?
        let expressions: String?
        let synonyms: String?
    }
    let jsonData:[JsonData]? = nil
    
    func getJson()->Void{
        
    }
}

