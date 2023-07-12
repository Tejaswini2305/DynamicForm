//
//  RadioCollectionViewCell.swift
//  DynamicForm
//
//  Created by tkandimalla on 22/12/22.
//

import UIKit

class RadioCollectionViewCell: UICollectionViewCell {
    
 
    @IBOutlet weak var genderRadioBtn: UIButton!
    @IBOutlet weak var radioLbl: UILabel!
    var isCheck = false
    //    static let identifier = "RadioCollectionViewCell"
//    static func nib() -> UINib{
//        return UINib(nibName: "RadioCollectionViewCell", bundle: nil)
//    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        genderRadioBtn.isUserInteractionEnabled = fal
        // Initialization code
    }

//    @IBAction func radioBtn(_ sender: UIButton) {
////        sender.setImage(UIImage(named: "radioselected"), for: .normal)
//    }
}
