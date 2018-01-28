//
//  NotesTableViewCell.swift
//  CloudNotes
//
//  Created by Syed  Rafay on 27/01/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit

class NotesTableViewCell: UITableViewCell {

    @IBOutlet var textArea: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
