//: Playground - noun: a place where people can play

import UIKit
import Foundation


let s = "aabcdb"
var arr = [Character]()
var dic = [Character:Int]()
for character in s {
    if dic.Keys.contains(character) {
        dic[character] += 1
    }else {
        dic[character] = 1
    }
    
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
//aabcdb
