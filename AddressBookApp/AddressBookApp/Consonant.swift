//
//  Consonant.swift
//  AddressBookApp
//
//  Created by oingbong on 02/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

enum Consonant: Int, CaseIterable, CustomStringConvertible {
    case ㄱ = 0, ㄲ, ㄴ, ㄷ, ㄸ, ㄹ, ㅁ, ㅂ, ㅃ, ㅅ, ㅆ, ㅇ, ㅈ, ㅉ, ㅊ, ㅋ, ㅌ, ㅍ, ㅎ
    case A = 19, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
    var description: String {
        switch self {
        case .ㄱ: return "ㄱ"
        case .ㄲ: return "ㄲ"
        case .ㄴ: return "ㄴ"
        case .ㄷ: return "ㄷ"
        case .ㄸ: return "ㄸ"
        case .ㄹ: return "ㄹ"
        case .ㅁ: return "ㅁ"
        case .ㅂ: return "ㅂ"
        case .ㅃ: return "ㅃ"
        case .ㅅ: return "ㅅ"
        case .ㅆ: return "ㅆ"
        case .ㅇ: return "ㅇ"
        case .ㅈ: return "ㅈ"
        case .ㅉ: return "ㅉ"
        case .ㅊ: return "ㅊ"
        case .ㅋ: return "ㅋ"
        case .ㅌ: return "ㅌ"
        case .ㅍ: return "ㅍ"
        case .ㅎ: return "ㅎ"
        case .A: return "A"
        case .B: return "B"
        case .C: return "C"
        case .D: return "D"
        case .E: return "E"
        case .F: return "F"
        case .G: return "G"
        case .H: return "H"
        case .I: return "I"
        case .J: return "J"
        case .K: return "K"
        case .L: return "L"
        case .M: return "M"
        case .N: return "N"
        case .O: return "O"
        case .P: return "P"
        case .Q: return "Q"
        case .R: return "R"
        case .S: return "S"
        case .T: return "T"
        case .U: return "U"
        case .V: return "V"
        case .W: return "W"
        case .X: return "X"
        case .Y: return "Y"
        case .Z: return "Z"
        }
    }
}
