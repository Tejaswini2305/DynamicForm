//
//  ButtonTableViewCell.swift
//  DynamicForm
//
//  Created by tkandimalla on 16/12/22.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var inputTypeLabel: UILabel!
    @IBOutlet weak var buttonDesign: UIButton!
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
