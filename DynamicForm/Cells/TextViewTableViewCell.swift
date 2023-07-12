//
//  TextViewTableViewCell.swift
//  DynamicForm
//
//  Created by tkandimalla on 15/12/22.
//

import UIKit

class TextViewTableViewCell: UITableViewCell {
    

    @IBOutlet weak var inputTypeLbl: UILabel!
    @IBOutlet weak var textViewDesign: UITextView!
    @IBOutlet weak var validatingLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        validatingLbl.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
