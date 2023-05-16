//
//  ContentView.swift
//  Fake Distinction
//
//  Created by Kushima Amane on 2023/01/28.
//

import SwiftUI
import UIKit
import CSV

extension AnyTransition {
    static var scaleAndSlide:AnyTransition {
        AnyTransition.scale.combined(with: .slide)
    }
}

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var isLoading: Bool = true // ここをtrueにする
    @State private var isCorrect: Bool = false
    @State private var isIncorrect: Bool = true
    @State private var isShowingView: Bool = false
    @State var idiom:String = ""
    @State var idiomExp:String = ""
    @State var synonym:String = ""
    @Environment(\.colorScheme) var colorScheme
    //    @State var memorizedIdioms: [Int]
    init(){
        self.viewModel = ViewModel()
        generateIdioms()
    }
    var body: some View {
        var cardColor = self.colorScheme == .dark ? K.Colors.cardDark : K.Colors.cardLight
        if isLoading { // スプラッシュ画面
            ZStack {
                Image("launch_screen").aspectRatio(contentMode: .fit).ignoresSafeArea()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        isLoading = false
                    }
                }
            }
        } else {
            
            
            Spacer()
            
            VStack {
                Group{
                    
                    if isCorrect {
                        idiomCard()
                            .transition(.slide)
                    } else {
                        idiomCard()
                            .transition(.scale)
                    }
                    
                    //                    isIncorrect ? idiomCard().transition(.slide) : idiomCard().transition(.scale(scale: .greatestFiniteMagnitude))
                    // イディオムの例文
                    Text(idiomExp).font(.system(size: K.Size.expTextSize, weight: .medium, design: .default)).frame(width: 380, height: 300)
                }
                
                
                Group {
                    VStack(spacing: 10) {
                        // チェック・バツボタン
                        HStack(spacing:80){
                            Button(action:{
                                isIncorrect.toggle()
                                viewModel.incorrectArray.append(generateIdioms())
                            }) {
                                Image("cross")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.all)
                                    .background(RoundedRectangle(cornerRadius: 25)
                                        .fill(Color(K.Colors.crossBtnColor))
                                        .frame(width: 100, height: 100)
                                        .shadow(color:.gray, radius: 2, x:0, y:5)
                                    )
                                    .frame(width: 100, height: 100)
                            }
                            Button(action: {
                                withAnimation {
                                    isCorrect.toggle()
                                }
                                
                                viewModel.memorizedArray.append(generateIdioms())
                            }){
                                Image("check-mark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding(.all)
                                    .background(RoundedRectangle(cornerRadius: 25)
                                        .fill(Color(K.Colors.checkBtnColor))
                                        .frame(width: 100, height: 100)
                                        .shadow(color:.gray, radius: 2, x:0, y:5)
                                    )
                                    .frame(width: 100, height: 100)
                                
                            }
                        }
                        
                        Button(action:{
                            isShowingView.toggle()
                        }){
                            ZStack{
                                K.Colors.blueGradient
                                Text("Result").fontWeight(.bold).foregroundColor(Color.white).padding()
                                
                            }.frame(width: 100, height: 50).cornerRadius(15)
                        }.background(RoundedRectangle(cornerRadius: 15)).offset(x: 150, y: 0).sheet(isPresented: $isShowingView) {
                            ResultView(viewModel: viewModel)
                        }
                    }
                }
            }
        }
    }
    
    func getCSVData() -> [Dictionary<String, String>] {
        do {
            if let path = Bundle.main.path(forResource: "distinction_all", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) // shows bytes
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    // NSArray of NSDictionary -> Array of Dictionary
                    var dicarr: [Dictionary<String, String>] = jsonResult as! [Dictionary<String, String>]
                    return dicarr
                } catch {
                    return []
                }
            }
            return []
        }
        catch {
            return []
        }
    }
    
    // idiom card itself
    func idiomCard() -> AnyView {
        var cardColor = self.colorScheme == .dark ? K.Colors.cardDark : K.Colors.cardLight
        return AnyView(
            VStack(alignment: .center, spacing: 4) {
                
                // main idiom
                Text(idiom).font(.system(size: K.Size.idiomTextSize, weight: .black, design: .default))
                    .padding()
                
                // synonim
                Text(synonym).font(.system(size: K.Size.synonymTextSize, weight: .bold, design: .default))
                    .padding(.horizontal, 70)
                
            }.background(RoundedRectangle(cornerRadius: 50)
                .fill(Color(cardColor))
                .frame(width: 380, height: 300)
                .shadow(color:.gray, radius: 2, x:0, y:5)
                .padding(.horizontal, 50)
            )
        )
    }
    
    // ランダムモード
    func randomMode() -> (id: Int, ex: String, expression: String, synonym: String) {
        let n = Int.random(in: 0...1072)
        let word = getCSVData()[n]
        let ex = word["ex"]
        let expression = word["expressions"]
        let synonym = word["synonyms"]
        return (id: n, ex!, expression!, synonym!)
    }
    
    func generateIdioms() -> Int{
        let idiomTuple = randomMode()
        let idiomId = idiomTuple.id
        idiom = idiomTuple.expression
        idiomExp = idiomTuple.ex
        synonym = idiomTuple.synonym
        return idiomId
    }
    
    func newIdioms(){ // 今まで出てこなかった単語を配列に格納する。
        
    }
    
    // ノーマルモード（順番にイディオムを返す。アプリの状態が消えれば最初から)
    func wordLambda()-> String?{ // イディオム数は全部で1073個ある。
        for (i,v) in getCSVData().enumerated(){
            let word = v["ex"]
            guard let word = word else { fatalError() }
            return word
        }
        return nil
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}


