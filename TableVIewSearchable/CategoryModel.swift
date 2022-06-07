//
//  CategoryModel.swift
//  TableVIewSearchable
//
//  Created by GIGL iOS on 02/06/2022.
//

import Foundation

struct CategoryModel: Codable {
    let code, shortDescription: String
    let object: [Object]
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case shortDescription = "ShortDescription"
        case object = "Object"
    }
}

// MARK: - Object
struct Object: Codable {
    let inboundShipmentCategoryID, shipmentCategoryName, countryName: String
    let isGoStandard, isGoFaster: Bool
    
    enum CodingKeys: String, CodingKey {
        case inboundShipmentCategoryID = "InboundShipmentCategoryId"
        case shipmentCategoryName = "ShipmentCategoryName"
        case countryName = "CountryName"
        case isGoStandard = "IsGoStandard"
        case isGoFaster = "IsGoFaster"
    }
}
