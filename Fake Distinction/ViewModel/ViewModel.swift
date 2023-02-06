//
//  ViewModel.swift
//  Fake Distinction
//
//  Created by Kushima Amane on 2023/01/28.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var memorizedArray:[Int]
    @Published var incorrectArray:[Int]
    init(){
        self.memorizedArray = []
        self.incorrectArray = []
    }
}
