//
//  SecondDataClass.swift
//  ForeksApp
//
//  Created by Ceren Çapar on 22.01.2022.
//

import Foundation

struct Welcome: Codable {
    let l: [L]
    let z: String
}

// MARK: - L
struct L: Codable {
    let tke, clo, pdd, las, ddi, low, hig, buy, sel, pdc, cei, flo, gco: String?
}
