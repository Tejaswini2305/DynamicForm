//
//  FormTableViewCell.swift
//  DynamicForm
//
//  Created by tkandimalla on 15/12/22.
//

import UIKit

class FormTableViewCell: UITableViewCell {

    
    @IBOutlet weak var inputTypeLbl: UILabel!
    @IBOutlet weak var textFiledvalidatingLbl: UILabel!
    @IBOutlet weak var textFieldDesign: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textFiledvalidatingLbl.isHidden = true
//        if textFieldDesign.text == ""
//        {
//
//        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
