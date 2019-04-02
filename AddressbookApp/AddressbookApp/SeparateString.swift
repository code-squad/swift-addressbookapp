//
//  SeparateString.swift
//  AddressbookApp
//
//  Created by 윤동민 on 02/04/2019.
//  Copyright © 2019 윤동민. All rights reserved.
//

import Foundation

struct Extractor {
    static func extractInitial(from string: String) -> String {
        let koreanInitial = ["ㄱ", "ㄲ", "ㄴ", "ㄷ", "ㄸ", "ㄹ", "ㅁ", "ㅂ", "ㅃ", "ㅅ", "ㅆ", "ㅇ", "ㅈ", "ㅉ", "ㅊ", "ㅋ", "ㅌ", "ㅍ", "ㅎ"]
        
        guard let firstCharactor = string.first else { return "" }
        guard let charactorUnicode = firstCharactor.unicodeScalars.first else { return "" }
        
        if charactorUnicode.value >= 44032 && charactorUnicode.value <= 55203 {
            let index = (charactorUnicode.value - 0xAC00) / 28 / 21
            return koreanInitial[Int(index)]
        } else {
            return String(charactorUnicode)
        }
    }
}

