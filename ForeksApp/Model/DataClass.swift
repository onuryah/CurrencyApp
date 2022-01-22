//
//  DataClass.swift
//  ForeksApp
//
//  Created by Ceren Çapar on 21.01.2022.
//

import Foundation

struct Currency: Decodable, Encodable {
    let mypageDefaults: [MypageDefault]
    let mypage: [Mypage]
}

struct Mypage: Decodable, Encodable {
    let name, key: String
}

struct MypageDefault: Decodable, Encodable {
    let cod, gro, tke, def: String
}
