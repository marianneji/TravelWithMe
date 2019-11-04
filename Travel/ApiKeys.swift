//
//  ApiKey.swift
//  Travel
//
//  Created by Graphic Influence on 30/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation

struct Apikeys {
    static func valueForAPIKey(named keyname:String) -> String {
        guard let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist") else { return "nil"}
        let plist = NSDictionary(contentsOfFile:filePath)
        let value = plist?.object(forKey: keyname) as! String
        return value
    }
}
