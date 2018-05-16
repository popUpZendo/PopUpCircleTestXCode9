//
//  OneSignal.swift
//  Pop Up Circle Test
//
//  Created by Joseph Hall on 5/10/18.
//  Copyright © 2018 Om Design. All rights reserved.
//

import Foundation

class OneSignal {
    private var _playerID: String
    private var _senderId: String
    
    var playerID: String {
        return _playerID
    }
    
    var senderId: String {
        return _senderId
    }
    
    init(playerID: String, senderId: String) {
        self._playerID = playerID
        self._senderId = senderId
    }
}

