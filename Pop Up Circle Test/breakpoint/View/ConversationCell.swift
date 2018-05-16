//
//  ConversationCell.swift
//  Pop Up Circle Test
//
//  Created by Joseph Hall on 5/2/18.
//  Copyright © 2018 Om Design. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell {

    @IBOutlet weak var conversationTitleLbl: UILabel!
    @IBOutlet weak var conversationDescLbl: UILabel!
    @IBOutlet weak var memberCountLbl: UILabel!
    
    func configureCell(title: String, description: String, memberCount: Int) {
        self.conversationTitleLbl.text = title
        self.conversationDescLbl.text = description
        self.memberCountLbl.text = "\(memberCount) members."
    }
    
}


