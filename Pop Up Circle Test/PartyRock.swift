//
//  PartyRock.swift
//  PartyRockApp
//
//  Created by Joseph Hall on 5/16/17.
//  Copyright © 2017 Om Design. All rights reserved.
//

import Foundation


class PartyRock {
    private var _imageURL: String!
    private var _videoURL: String!
    private var _videoTitle: String!
    private var _contentURL: String!
    private var _details: String!
    
    var imageURL: String {
        return _imageURL
    }
    
    var videoURL: String {
        return _videoURL
    }
    
    var videoTitle: String {
        return _videoTitle
    }
    
    var details: String {
        return _details
    }
    
    var contentURL: String {
        return _contentURL
    }
    
    
    init(imageURL: String, videoURL:String, videoTitle: String, details: String, contentURL: String){
        
        _imageURL = imageURL
        _videoURL = videoURL
        _videoTitle = videoTitle
        _details = details
        _contentURL = contentURL
    }
    
}

