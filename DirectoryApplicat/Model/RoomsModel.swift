//
//  RoomsModel.swift
//  Directory App
//
//  Created by SAISURAJ on 3/18/22.
//  Copyright © 2022 SAISURAJ. All rights reserved.
//

import Foundation

struct RoomsModel : Codable {
    let createdAt : String?
    let isOccupied : Bool?
    let maxOccupancy : Int?
    let id : String?

    enum CodingKeys: String, CodingKey {

        case createdAt = "createdAt"
        case isOccupied = "isOccupied"
        case maxOccupancy = "maxOccupancy"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        isOccupied = try values.decodeIfPresent(Bool.self, forKey: .isOccupied)
        maxOccupancy = try values.decodeIfPresent(Int.self, forKey: .maxOccupancy)
        id = try values.decodeIfPresent(String.self, forKey: .id)
    }

}

