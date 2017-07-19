//
//  DharmaRock.swift
//  PopUPZendoApp
//
//  Created by Joseph Hall on 5/16/17.
//  Copyright © 2017 Om Design. All rights reserved.
//

import Foundation


class DharmaRock {
    fileprivate var _imageURL: String!
    fileprivate var _videoURL: String!
    fileprivate var _videoTitle: String!
    fileprivate var _contentURL: String!
    fileprivate var _details: String!
    
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

