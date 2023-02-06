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
    @State private var isIncorrect: Bool = false
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
            var cardColor = colorScheme == .dark ? K.Colors.cardDark : K.Colors.cardLight
            VStack {
                ZStack {
                    Group{
                        // イディオムカード
                        VStack() {
                            Text(idiom).font(.system(size: K.Size.idiomTextSize, weight: .black, design: .default))
                                .padding()
                            Text(synonym).font(.system(size: K.Size.synonymTextSize, weight: .bold, design: .default))
                        }.background(RoundedRectangle(cornerRadius: 50)
                            .fill(Color(cardColor))
                            .frame(width: 380, height: 300)
                            .shadow(color:.gray, radius: 2, x:0, y:5)
                        )
                        .offset(x: 0, y: -150)
                        
                    }.overlay(Text(idiomExp).font(.system(size: K.Size.expTextSize, weight: .medium, design: .default)).offset(x: 0, y: 100).frame(width: 380, height: 300))
                }
                //                if isCorrect {
                //                    VStack {
                //                        Group{
                //                            // イディオムカード
                //                            VStack() {
                //                                Text(idiom).font(.system(size: K.Size.idiomTextSize, weight: .black, design: .default))
                //                                Text(synonym).font(.system(size: K.Size.synonymTextSize, weight: .bold, design: .default))
                //                            }.background(RoundedRectangle(cornerRadius: 50)
                //                                .fill(Color(cardColor))
                //                                .frame(width: 380, height: 300)
                //                                .shadow(color:.gray, radius: 2, x:0, y:5)
                //                            )
                //                            .offset(x: 50, y: 50)
                //
                //                        }.transition(AnyTransition.scaleAndSlide).rotationEffect(.degrees(30))
                //                    }.animation(.default, value:isCorrect)
                //                }
                
                
                // イディオムの説明
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
                    Button(action:{
                        isCorrect.toggle()
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
                }.offset(x: 0, y: 200)
                ZStack {
//                    NavigationView {
//
//                        K.Colors.blueGradient
//                        Text("Exit").fontWeight(.bold).foregroundColor(Color.white).padding()
//                        NavigationLink(destination: ResultView()) {
//                            Text("Do Something")
//                        }
//
//                    }
                }
//                NavigationView {
//                    ZStack {
//                        K.Colors.blueGradient
//                        Text("Exit").fontWeight(.bold).foregroundColor(Color.white).padding()
//                        NavigationLink(destination: ResultView()) {Text("dhaskdh")}
//                    }
//                }.frame(width: 70, height: 50).cornerRadius(15).offset(x: 150, y: 300)
                Button(action:{
                    isShowingView.toggle()
                }){
                    ZStack{
                        K.Colors.blueGradient
                        Text("Exit").fontWeight(.bold).foregroundColor(Color.white).padding()

                    }.frame(width: 70, height: 50).cornerRadius(15)
                }.background(RoundedRectangle(cornerRadius: 15)).offset(x: 150, y: 300).sheet(isPresented: $isShowingView) {
                    ResultView()
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


