//: Playground - noun: a place where people can play

import UIKit
import Foundation


let s = "abcddfegsabfesbbcg"
var arr = [Character]()

for character in s {
    if arr.contains(character) {
        arr.remove(at: arr.index(of: character)!)
    } else {
        arr.append(character)
    }
}

if arr.isEmpty { print("YES") }
else { print("NO") }

//aabbcd
//aabbccddeefghi
