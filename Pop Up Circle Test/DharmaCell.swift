//
//  DharmaCell.swift
//  PopUpZendoApp
//
//  Created by Joseph Hall on 5/16/17.
//  Copyright © 2017 Om Design. All rights reserved.
//

import UIKit

class DharmaCell: UITableViewCell {
    
    @IBOutlet weak var videoPreviewImage: UIImageView!
    
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var details: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateUI(_ dharmaRock: DharmaRock) {
        videoTitle.text = dharmaRock.videoTitle
        details.text = dharmaRock.details
        
        let url = URL(string: dharmaRock.imageURL)!
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.sync {
                    self.videoPreviewImage.image = UIImage(data: data)
                }
                
            } catch  {
                //handle the error
                
                
            }
            
        }
    }
}

