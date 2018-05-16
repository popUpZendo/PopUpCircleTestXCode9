//
//  Zazen.swift
//  Pop Up Circle Test
//
//  Created by Joseph Hall on 5/15/18.
//  Copyright © 2018 Om Design. All rights reserved.
//

import Foundation

class Zazen {
    private var _date: String
    private var _duration: String
    private var _key: String
    
    
    var date: String {
        return _date
    }
    
    var duration: String {
        return _duration
    }
    
    var key: String {
        return _key
    }
    
    
    init(date: String, duration: String, key:String) {
        self._date = date
        self._duration = duration
        self._key = key
    }
    
}
