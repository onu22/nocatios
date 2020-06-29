//
//  nocatUserJson.swift
//  nocat
//
//  Created by Onuorah Nwachukwu on 17/06/2020.
//  Copyright © 2020 Onuorah Nwachukwu. All rights reserved.
//

import Foundation

struct nocatUser: Encodable {
    var id: Int
    var deviceId: String
    var userName: String
    var latitude: Double
    var longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case id, deviceId, userName,latitude,longitude
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(deviceId, forKey: .deviceId)
        try container.encode(userName, forKey: .userName)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
}

extension nocatUser: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.deviceId = try container.decode(String.self, forKey: .deviceId)
        self.userName = try container.decode(String.self, forKey: .userName)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
    }
}
struct File: Codable {
    var content: String?
}
