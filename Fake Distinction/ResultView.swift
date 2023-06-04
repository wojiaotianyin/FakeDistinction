//
//  ResultView.swift
//  Fake Distinction
//
//  Created by Amane Kushima on 2023-02-06.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ViewModel
    private var incorrectArray: [Int]
    private var correctArrray: [Int]
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        self.incorrectArray = viewModel.incorrectArray
        self.correctArrray = viewModel.memorizedArray
    }
    
    var body: some View {
        VStack {
            Text("Your result").font(.system(size: K.Size.idiomTextSize, weight: .black, design: .default))
                .padding(.top, 50)
            
            Spacer()
            
            HStack {
                Text("You need to learn: \(incorrectArray.count) words").font(.system(size: K.Size.expTextSize, weight: .black, design: .default))
                Button(action: {
                    //                    isCorrect.toggle()
                    //                    viewModel.memorizedArray.append(generateIdioms())
                    print("show unmemorized idioms")
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    ZStack{
                        K.Colors.pinkGradient
                        Text("Learn").fontWeight(.bold).foregroundColor(Color.white).padding()
                        
                    }.frame(width: 100, height: 50).cornerRadius(15)
                }.background(RoundedRectangle(cornerRadius: 15))
            }
            
            Spacer()
            
            HStack {
                Text("You memorized: \(correctArrray.count) words").font(.system(size: K.Size.expTextSize, weight: .black, design: .default))
                Button(action: {
                    //                    isCorrect.toggle()
                    //                    viewModel.memorizedArray.append(generateIdioms())
                    print("show memorized idioms")
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    ZStack{
                        K.Colors.pinkGradient
                        Text("Learn").fontWeight(.bold).foregroundColor(Color.white).padding()
                        
                    }.frame(width: 100, height: 50).cornerRadius(15)
                }.background(RoundedRectangle(cornerRadius: 15))
            }
            
            Spacer()
        }
        
        //        let numsString = incorrectArray.map { String($0) }.joined(separator: ", ")
    }
}


//struct ResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultView(viewModel: ViewModel)
//    }
//}
