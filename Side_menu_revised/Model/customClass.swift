//
//  customClass.swift
//  Cryptili
//
//  Created by Arinjay on 22/01/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//

import Foundation

struct Herostats: Decodable {
    let name: String
    let percent_change_1h: String
    let percent_change_24h: String
    let percent_change_7d: String
    let rank: String
    let available_supply: String
    let market_cap_usd: String
}
