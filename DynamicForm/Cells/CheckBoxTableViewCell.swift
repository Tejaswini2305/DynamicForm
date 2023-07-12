//
//  CheckBoxTableViewCell.swift
//  DynamicForm
//
//  Created by tkandimalla on 05/01/23.
//

import UIKit

class CheckBoxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkBoxLbl: UILabel!
    @IBOutlet weak var checkBoxCollectionView: UICollectionView!
    
    var checkBoxData: FormFields?
    var checkBoxBtnData: [String:Any] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxCollectionView.delegate = self
        checkBoxCollectionView.dataSource = self
        checkBoxCollectionView.register(UINib(nibName: "CheckBoxCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CheckBoxCollectionViewCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension CheckBoxTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return checkBoxData?.fields?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = checkBoxCollectionView.dequeueReusableCell(withReuseIdentifier: "CheckBoxCollectionViewCell", for: indexPath) as! CheckBoxCollectionViewCell
        cell.checkBoxBtn.tag = indexPath.row
        cell.checkBoxLbl.text = checkBoxData?.fields?[indexPath.row]
        cell.checkBoxBtn.setImage(UIImage(named: "UnCheckbox"),for: .normal)
        cell.checkBoxBtn.addTarget(self, action: #selector(whichButtonPressed(sender:)), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Checkbox collection view selected")
        let cell = checkBoxCollectionView.dequeueReusableCell(withReuseIdentifier: "CheckBoxCollectionViewCell", for: indexPath) as! CheckBoxCollectionViewCell
        if cell.checkBoxBtn.currentImage == UIImage(named: "UnCheckbox"){
            cell.checkBoxBtn.setImage(UIImage(named: "CheckBox"),for: .normal)
            cell.checkBoxBtn.tag = indexPath.row
        }
        else
        {
            cell.checkBoxBtn.setImage(UIImage(named: "UnCheckbox"),for: .normal)
        }
//        if cell.checkBoxImageView.image == UIImage(named: "UnCheckbox"){
//            cell.checkBoxImageView.image == UIImage(named: "CheckBox")
//            cell.checkBoxI
//        }
//        else {
//            cell.checkBoxImageView.image == UIImage(named: "UnCheckbox")
//        }
        
    }
    
    @objc func whichButtonPressed(sender: UIButton) {
        if sender.currentImage == UIImage(named: "UnCheckbox") {
            sender.setImage(UIImage(named: "CheckBox"), for: .normal)
        }
        else{
            sender.setImage(UIImage(named: "UnCheckbox"), for: .normal)
        }
        checkBoxBtnData[checkBoxData?.name ?? ""] = checkBoxData?.fields?[sender.tag]
        print(checkBoxBtnData)
        print("checkBoxBtnData")
    }
    
}
