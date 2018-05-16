//
//  OneSignal.swift
//  Pop Up Circle Test
//
//  Created by Joseph Hall on 5/10/18.
//  Copyright © 2018 Om Design. All rights reserved.
//

import Foundation

class OneSignalList {
    private var _playerID: String
    private var _senderId: String
    private var _key: String
    
    var playerID: String {
        return _playerID
    }
    
    var senderId: String {
        return _senderId
    }
    var key: String {
        return _key
    }
    
    init(playerID: String, senderId: String, key: String) {
        self._playerID = playerID
        self._senderId = senderId
        self._key = key
    }
}

