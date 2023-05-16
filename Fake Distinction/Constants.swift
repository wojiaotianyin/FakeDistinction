//
//  Constants.swift
//  Fake Distinction
//
//  Created by Kushima Amane on 2023/01/28.
//

import Foundation
import UIKit
import SwiftUI

struct K {
    struct Colors {
        static let learnBtnLeading = UIColor(red: 0.421, green: 0.003, blue: 0.114, alpha: 1.0)
        static let learnBtnTrailing = UIColor(red: 0.989, green: 0.186, blue: 0.951, alpha:1.0)
        static let checkBtnColor = UIColor(red: 0.485, green: 0.999, blue: 0.692,alpha: 1.0)
        static let crossBtnColor = UIColor(red: 1.0, green: 0.512, blue: 0.512, alpha: 1.0)
        static let cardDark = UIColor(red: 0.173, green: 0.173, blue: 0.173, alpha: 1.0)
        static let cardLight = UIColor(red: 0.976, green: 0.976, blue: 0.976, alpha: 1.0)
        static let exitLeading = UIColor(red: 0.009, green: 0.072, blue: 0.315, alpha: 1.0)
        static let exitTrailing = UIColor(red: 0.178, green: 0.352, blue: 0.961, alpha:1.0)
        static let blueGradient = LinearGradient(gradient: Gradient(colors: [Color(K.Colors.exitLeading), Color(K.Colors.exitTrailing)]), startPoint: .leading, endPoint: .trailing)
        static let pinkGradient = LinearGradient(gradient: Gradient(colors: [Color(K.Colors.learnBtnLeading), Color(K.Colors.learnBtnTrailing)]), startPoint: .leading, endPoint: .trailing)
    }
    
    struct Size {
        static let idiomTextSize:CGFloat = 40
        static let synonymTextSize:CGFloat = 25
        static let expTextSize:CGFloat = 20
    }
}

