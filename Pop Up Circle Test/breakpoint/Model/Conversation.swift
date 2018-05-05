//
//  Conversation.swift
//  breakpoint
//
//  Created by Joseph Hall on 5/2/18.
//  Copyright © 2018 Om Design. All rights reserved.
//

import Foundation

class Conversation {
    private var _conversationTitle: String
    private var _key: String
    private var _conversationMemberCount: Int
    private var _conversationMembers: [String]
    
    var conversationTitle: String {
        return _conversationTitle
    }
    
    var key: String {
        return _key
    }
    
    var conversationMemberCount: Int {
        return _conversationMemberCount
    }
    
    var conversationMembers: [String] {
        return _conversationMembers
    }
    
    init(conversationTitle: String, key: String, conversationMembers: [String], conversationMemberCount:Int) {
        self._conversationTitle = conversationTitle
        self._key = key
        self._conversationMembers = conversationMembers
        self._conversationMemberCount = conversationMemberCount
    }
    
}
