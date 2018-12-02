//
//  Consonant.swift
//  AddressBookApp
//
//  Created by oingbong on 02/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

enum KoreanConsonant: Int, CaseIterable, CustomStringConvertible {
    case ㄱ = 0, ㄲ, ㄴ, ㄷ, ㄸ, ㄹ, ㅁ, ㅂ, ㅃ, ㅅ, ㅆ, ㅇ, ㅈ, ㅉ, ㅊ, ㅋ, ㅌ, ㅍ, ㅎ
    
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
        }
    }
}
