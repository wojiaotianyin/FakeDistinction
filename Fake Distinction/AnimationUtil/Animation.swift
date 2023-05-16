//
//  Animation.swift
//  Fake Distinction
//
//  Created by Amane Kushima on 2023-05-16.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
}
