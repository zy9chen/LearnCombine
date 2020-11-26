//
//  Model.swift
//  LearnCombine
//
//  Created by Zhaoyang Chen on 2020-11-25.
//

import Foundation

struct User: Decodable, Identifiable {
    let id: Int
    let name: String
}
