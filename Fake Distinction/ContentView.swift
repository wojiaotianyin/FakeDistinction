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
    @State private var isLoading = false
    @State private var isCorrect = false
    @State private var isIncorrect = false
    @State var greeting = "Whoa!"
    @State var buttonText = "Button"
    @State var idiom:String = "main"
    @State var idiomExp:String = "daskhdakhdakdhue ashdakdhksad ahsdhakhsdkjafdfdfdfdfdfdfdfdfsffdsfsdfdfsdfsffdfdfdfdfdfshdkja"
    @State var synonym:String = "Sys"
    @Environment(\.colorScheme) var colorScheme
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
                if isCorrect {
                    VStack {
                        Group{
                            // イディオムカード
                            VStack() {
                                Text(idiom).font(.system(size: K.Size.idiomTextSize, weight: .black, design: .default))
                                Text(synonym).font(.system(size: K.Size.synonymTextSize, weight: .bold, design: .default))
                            }.background(RoundedRectangle(cornerRadius: 50)
                                .fill(Color(cardColor))
                                .frame(width: 380, height: 300)
                                .shadow(color:.gray, radius: 2, x:0, y:5)
                            )
                            .offset(x: 50, y: 50)
                            
                        }.transition(AnyTransition.scaleAndSlide)
                    }.animation(.default, value:isCorrect)
                }
                ZStack {
                    Group{
                        // イディオムカード
                        VStack() {
//                            Text(idiom).font(.system(size: K.Size.idiomTextSize, weight: .black, design: .default))
//                            Text(synonym).font(.system(size: K.Size.synonymTextSize, weight: .bold, design: .default))
                        }.background(RoundedRectangle(cornerRadius: 50)
                            .fill(Color(cardColor))
                            .frame(width: 380, height: 300)
                            .shadow(color:.gray, radius: 2, x:0, y:5)
                        )
                        .offset(x: 0, y: -150)

                    }.overlay(Text(idiomExp).font(.system(size: K.Size.expTextSize, weight: .medium, design: .default)).offset(x: 0, y: 100).frame(width: 380, height: 300))
                }
                
                // イディオムの説明
                HStack(spacing:80){
                    Button(action:{
                        buttonText="Tapped!"
                        greeting="HELLOOOO"
                        print("incorrect btn")
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
                        //                    synonym = getCSVData()[0]["synonyms"]!
                        //                    idiom = getCSVData()[0]["expressions"]!
                        //                    idiomExp = getCSVData()[0]["ex"]!
                        isCorrect.toggle()
                        print(wordLambda())
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
                Button(action:{
                    print("EXIT")
                }){
                    ZStack{
                        K.Colors.blueGradient
                        Text("Exit").fontWeight(.bold).foregroundColor(Color.white).padding()
                    }.frame(width: 70, height: 50).cornerRadius(15)
                }.background(RoundedRectangle(cornerRadius: 15)).offset(x: 150, y: 300)
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
    
    func wordLambda()->String!{ // イディオム数は全部で1073個ある。
        for (i,v) in getCSVData().enumerated(){
            return "\(i + 1) - \(v["ex"])"
        }
        return nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


