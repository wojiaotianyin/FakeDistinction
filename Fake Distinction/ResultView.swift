//
//  ResultView.swift
//  Fake Distinction
//
//  Created by Amane Kushima on 2023-02-06.
//

import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: ViewModel
    private var incorrectArray: [Int]
    private var correctArrray: [Int]
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.incorrectArray = viewModel.incorrectArray
        self.correctArrray = viewModel.memorizedArray
    }

    var body: some View {
        Text("Your result").font(.system(size: K.Size.idiomTextSize, weight: .black, design: .default))
        Text("You need to learn: \(incorrectArray.count) words")
        Text("You memorized: \(correctArrray.count) words")
//        let numsString = incorrectArray.map { String($0) }.joined(separator: ", ")
    }
}


//struct ResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultView(viewModel: ViewModel)
//    }
//}
