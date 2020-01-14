//
//  Country.swift
//  CollectionView-Lab
//
//  Created by casandra grullon on 1/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let name: String?
    let alpha2Code: String?
    let capital: String?
    let region: String?
    let population: Int?
    let currencies: [Currencies]?
    let latlng: [Double]?
}
struct Currencies: Decodable {
    let code: String?
    let name: String?
    let symbol: String?
}
