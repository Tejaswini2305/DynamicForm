//
//  RadioBtnTableViewCell.swift
//  DynamicForm
//
//  Created by tkandimalla on 22/12/22.
//

import UIKit

class RadioBtnTableViewCell: UITableViewCell {

    var radioResult: HeaderFields?
    var index: Int?
    var dataObj: FormFields?
    var btn = UIButton()
    var isCheck = false
    var genderIndex: Int?
    var buttonPressed: String?
    var radioBtnData: [String:Any] = [:]
    
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var RadioBtncollectionView: UICollectionView!

    struct TeamSelected {
    var logoImage: String
    var isImageSelected: Bool }
    
    var selection = Set<Int>()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(index)
        self.RadioBtncollectionView.dataSource = self
        self.RadioBtncollectionView.delegate = self
        self.RadioBtncollectionView.isUserInteractionEnabled = true
        self.RadioBtncollectionView.allowsSelection = true
        self.RadioBtncollectionView.register(UINib(nibName: "RadioCollectionViewCell", bundle:  nil), forCellWithReuseIdentifier: "RadioCollectionViewCell")
//        self.RadioBtncollectionView.rowHeight = 100
        // Initialization code
    }

    func radioSelection(input: UIButton){
        if input.currentImage == UIImage(named: "radioselected"){
            input.setImage(UIImage(named: "radiounselected"), for: .normal)
        }
        else{
            input.setImage(UIImage(named: "radioselected"), for: .normal)
        }
//        RadioBtncollectionView.reloadData()
//         var a = input.tag
//          if self.radioResult?.formFields?[index ?? 0].index == input.tag{
//              input.setImage(UIImage(named: "radioselected"), for: .normal)
//          }
//        else if self.radioResult?.formFields?[index ?? 0].index != input.tag{
//            input.setImage(UIImage(named: "radiounselected"), for: .normal)
//        }
    }
}

extension RadioBtnTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return cellResult?.formFields?[index]
        return dataObj?.fields?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = RadioBtncollectionView.dequeueReusableCell(withReuseIdentifier: "RadioCollectionViewCell", for: indexPath) as! RadioCollectionViewCell
        cell.radioLbl.text = dataObj?.fields?[indexPath.row]
        cell.genderRadioBtn.tag = indexPath.row
        cell.tag = indexPath.row
//        radioBtnData["index"] as? Int == dataObj?.index
//        if indexPath.row == radioBtnData["index"] as? Int {
//            cell.genderRadioBtn.setImage(UIImage(named: "radioselected"), for: .normal)
//        }
        if cell.genderRadioBtn.tag == dataObj?.index ?? 0
        {
            cell.genderRadioBtn.setImage(UIImage(named: "radioselected"), for: .normal)
        }
        else
        {
            cell.genderRadioBtn.setImage(UIImage(named: "radiounselected"), for: .normal)
        }
        cell.genderRadioBtn.addTarget(self, action: #selector(whichButtonPressed(sender:)), for: .touchUpInside)
        genderIndex = indexPath.row
        //        cell?.collectionRadioLbl.text = radioResult?.formFields?[index ?? 0].fields?[indexPath.row]
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = RadioBtncollectionView.cellForItem(at: indexPath) as! RadioCollectionViewCell
        if cell.isCheck == false{
            cell.isCheck = true
            cell.genderRadioBtn.setImage(UIImage(named: "radioselected"), for: .selected)
        }
        else {
            cell.isCheck = false
            cell.genderRadioBtn.setImage(UIImage(named: "radiounselected"), for: .normal)
        }
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = RadioBtncollectionView.cellForItem(at: indexPath) as! RadioCollectionViewCell
//        cell.genderRadioBtn.setImage(UIImage(named: "radiounselected"), for: .normal)
//    }

    @objc func whichButtonPressed(sender: UIButton) {
        
        RadioBtncollectionView.reloadData()
        //RadioBtncollectionView.reloadSections(IndexSet(integer: 0))
        self.dataObj?.index = sender.tag
        radioSelection(input: sender)
        buttonPressed = dataObj?.fields?[sender.tag]
        radioBtnData[dataObj?.name ?? ""] = dataObj?.fields?[sender.tag]
        radioBtnData["index"] = sender.tag
        print("radioBtnData")
        print(radioBtnData)
//        RadioBtncollectionView.reloadData()
//        var buttonNumber = sender.tag
//                if isCheck == false {
//                    isCheck = true
//                    sender.setImage(UIImage(named: "radioselected"), for: .normal)
//                }
//                else {
//                    isCheck = false
//                    sender.setImage(UIImage(named: "radiounselected"), for: .normal)
//                }
        //        var buttonNumber = sender.tag
        //        //var genderBtn = sender.tag as? UIButton
        //        sender.setImage(UIImage(named: "radioselected"), for: .normal)
        
                //        if let tfObj = self.viewWithTag(buttonNumber) as? UIView {
                //            if let tempNameObj = tfObj as? UIButton {
                //                tempNameObj.setImage(UIImage(named: "radioselected"), for: .selected)
                //            }
                //        }
                //    }
        
    }
}

