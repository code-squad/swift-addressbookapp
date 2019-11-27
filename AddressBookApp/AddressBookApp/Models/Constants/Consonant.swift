//
//  Consonant.swift
//  AddressBookApp
//
//  Created by CHOMINJI on 2019/11/27.
//  Copyright © 2019 cmindy. All rights reserved.
//

import Foundation

enum Consonant {
    static let all = hangul + english
    static let hangul = Array("ㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎ").map { String($0).precomposedStringWithCompatibilityMapping }
    static let english = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ").map { String($0) }
}
