//
//  CustomCellFormVC.swift
//  DynamicForm
//
//  Created by tkandimalla on 14/12/22.
//

import UIKit

class CustomCellFormVC: UIViewController, UITextViewDelegate, UICollectionViewDelegate{
    
    var cellResult: HeaderFields?
    let pickerView = UIPickerView()
    var dropBoxIndex = Int()
    var dropBoxTF = UITextField()
    var textView = UITextView()
    var textField = UITextField()
    var myFirstButton = UIButton()
    var dropBoxTextField = UITextField()
    
    var tag = 100
    var labelTag = 200
    var refresh = true
    var dynamicFormData: [String:Any] = [:]
    
    enum designType: String{
        case textFieldDesign = "TextField"
        case textViewDesign = "TextView"
        case dropBoxDesign = "DropBox"
        case buttonDesign = "Button"
        case radioBtnDesign = "RadioBtn"
        case checkBoxDesign = "CheckBox"
    }
    //    var request: designType.textFieldDesign
    @IBOutlet weak var formTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(cellResult)
        self.formTableView.delegate = self
        self.formTableView.dataSource = self
        self.formTableView.register(UINib(nibName: "FormTableViewCell", bundle:  nil), forCellReuseIdentifier: "FormTableViewCell")
        self.formTableView.register(UINib(nibName: "TextViewTableViewCell", bundle:  nil), forCellReuseIdentifier: "TextViewTableViewCell")
        self.formTableView.register(UINib(nibName: "DropDownTableViewCell", bundle:  nil), forCellReuseIdentifier: "DropDownTableViewCell")
        self.formTableView.register(UINib(nibName: "ButtonTableViewCell", bundle:  nil), forCellReuseIdentifier: "ButtonTableViewCell")
        self.formTableView.register(UINib(nibName: "RadioBtnTableViewCell", bundle:  nil), forCellReuseIdentifier: "RadioBtnTableViewCell")
        self.formTableView.register(UINib(nibName: "RadioCollectionViewCell", bundle:  nil), forCellReuseIdentifier: "RadioCollectionViewCell")
        self.formTableView.register(UINib(nibName: "CheckBoxTableViewCell", bundle:  nil), forCellReuseIdentifier: "CheckBoxTableViewCell")
        self.formTableView.register(UINib(nibName: "CheckBoxCollectionViewCell", bundle:  nil), forCellReuseIdentifier: "CheckBoxCollectionViewCell")
        formTableView.separatorStyle = .none
        formTableView.isUserInteractionEnabled = true
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        //formTableView.isScrollEnabled = false
        //        formTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(CustomCellFormVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//            NotificationCenter.default.addObserver(self, selector: #selector(CustomCellFormVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        if refresh == true {
            //No need to use DispatchQueue.main.async here
            
            self.refresh = false
        }
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//            NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    @objc func keyboardWillShow(notification: Notification) {
//        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
//            print("Notification: Keyboard will show")
//            formTableView.setBottomInset(to: keyboardHeight)
//        }
//    }
//
//
//    @objc func keyboardWillHide(notification: Notification) {
//        print("Notification: Keyboard will hide")
//        formTableView.setBottomInset(to: 0.0)
//    }
    @IBAction func customBackBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        //        self.navigationController?.popViewController(animated: true)
    }
    func textFieldMethod(TF: UITextField) {
        let obj = cellResult?.formFields?[TF.tag - tag]
        dynamicFormData[obj?.name ?? ""] = TF.text
        print(" Form Data is \(dynamicFormData)")
    }
    
    func validateMethod(validateField: UITextField) {
        //        let enabledIndex = validateField.tag - tag
        let index = validateField.tag + 100
        if let tfObj = self.view.viewWithTag(index) as? UIView {
            if let tempNameObj = tfObj as? UILabel {
                if validateField.text == ""{
                    tempNameObj.isHidden = false
                    tempNameObj.text = "Please enter the text"
                    tempNameObj.textColor = .red
                }
                else {
                    tempNameObj.isHidden = true
                }
            }
        }
    }
}
extension CustomCellFormVC: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellResult?.formFields?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellObj = cellResult?.formFields?[indexPath.row]
        if cellObj?.input_type == designType.textFieldDesign.rawValue {
            if let cell = formTableView.dequeueReusableCell(withIdentifier: "FormTableViewCell", for: indexPath) as? FormTableViewCell {
                cell.inputTypeLbl.text = cellObj?.name
                textField = UITextField(frame: CGRect(x: 0, y: 20, width: 350, height: 50.00));
                cell.textFieldDesign.placeholder = cellObj?.name
                textField.textAlignment = .center
                textField.borderStyle = UITextField.BorderStyle.line
                textField.layer.borderWidth = 1.0
                textField.textColor = UIColor.black
                textField.backgroundColor = UIColor.white
                cell.textFiledvalidatingLbl.tag = labelTag + indexPath.row
                cell.textFieldDesign.delegate = self
                cell.textFieldDesign.tag = tag + indexPath.row
//                cell.textFieldDesign.inputAccessoryView = addDoneButtonOnKeyboard()
                //                textField.isEnabled = true
                //cell.designView.addSubview(textField)
                cell.selectionStyle = .none
                
//                var dictionaryData = Array(self.dynamicFormData.keys)
                var title = cellObj?.name
                if let textObj = dynamicFormData[title ?? ""] as? String {
                    cell.textFieldDesign.text = textObj
                } else {
                    cell.textFieldDesign.text = ""
                }
                
                return cell
            }
            
        } else if cellObj?.input_type == designType.textViewDesign.rawValue {
            if let cell = formTableView.dequeueReusableCell(withIdentifier: "TextViewTableViewCell", for: indexPath) as? TextViewTableViewCell {
                cell.inputTypeLbl.text = cellObj?.name
                textView = UITextView(frame: CGRect(x: 0, y: 20 , width: 350.0, height: 50.0))
                textView.contentInsetAdjustmentBehavior = .automatic
                //textView.center = self.view.center
                textView.textAlignment = NSTextAlignment.justified
                textView.textColor = UIColor.black
                textView.backgroundColor = UIColor.white
                textView.layer.borderColor = UIColor.black.cgColor
                textView.layer.borderWidth = 1.0
                textView.clearsOnInsertion = true
                cell.validatingLbl.tag = labelTag + indexPath.row
                cell.textViewDesign.delegate = self
                cell.textViewDesign.tag = tag + indexPath.row
                //cell.designView.addSubview(textView)
                cell.selectionStyle = .none
                var title = cellObj?.name
                if let textObj = dynamicFormData[title ?? ""] as? String {
                    cell.textViewDesign.text = textObj
                } else {
                    cell.textViewDesign.text = ""
                }
                return cell
            }
        } else if cellObj?.input_type == designType.buttonDesign.rawValue {
            if let cell = formTableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as? ButtonTableViewCell {
                cell.inputTypeLabel.text = cellObj?.name
                myFirstButton = UIButton(frame: CGRect(x: 0, y: 5 , width: 350.0, height: 50.0))
                myFirstButton.setTitle("Button", for: .normal)
                myFirstButton.setTitleColor(.black, for: .normal)
                //                myFirstButton.frame = CGRect(x: 0, y: 20, width: 350, height: 50)
                //                myFirstButton.center = CGPoint(x: 200, y: 200)
                myFirstButton.tintColor = .black
                myFirstButton.layer.borderColor = UIColor.black.cgColor
                myFirstButton.layer.borderWidth = 2.0
                myFirstButton.layer.cornerRadius = 10
                cell.buttonDesign.addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
//                cell.validatingLbl.tag = labelTag + indexPath.row
                cell.buttonDesign.tag = tag + indexPath.row
                // cell.designView.addSubview(myFirstButton)
                cell.selectionStyle = .none
                
                return cell
            }
        }
        else if cellObj?.input_type == designType.dropBoxDesign.rawValue {
            if let cell = formTableView.dequeueReusableCell(withIdentifier: "DropDownTableViewCell", for: indexPath) as? DropDownTableViewCell {
                cell.inputTypeLbl.text = cellObj?.name
                dropBoxTextField = UITextField(frame: CGRect(x: 0, y: 5, width: 350.00, height: 50.00));
                //dropBoxTextField.placeholder = cellObj?.name
                cell.dropDownTFDesign.placeholder = cellObj?.name
                dropBoxTextField.textAlignment = .center
                dropBoxTextField.borderStyle = UITextField.BorderStyle.line
                dropBoxTextField.backgroundColor = UIColor.white
                dropBoxTextField.textColor = UIColor.black
                //dropBoxTextField.delegate = self
                cell.dropDownTFDesign.delegate = self
                //dropBoxTextField.tag = tag + indexPath.row
                cell.dropDownTFDesign.tag = tag + indexPath.row
                //cell.designView.addSubview(dropBoxTextField)
                dropBoxTextField.inputView = pickerView
                cell.dropDownTFDesign.inputView = pickerView
                cell.validatingLbl.tag = labelTag + indexPath.row
                cell.selectionStyle = .none
                //                if dropBoxTextField.text == ""{
                //                    cell.validatingLbl.isHidden = false
                //                    cell.validatingLbl.text = "Please enter the data"
                //                }
                var title = cellObj?.name
                if let textObj = dynamicFormData[title ?? ""] as? String {
                    cell.dropDownTFDesign.text = textObj
                } else {
                    cell.dropDownTFDesign.text = ""
                }
                return cell
            }
        }
            else if cellObj?.input_type == designType.radioBtnDesign.rawValue {
            if let cell = formTableView.dequeueReusableCell(withIdentifier: "RadioBtnTableViewCell", for: indexPath) as? RadioBtnTableViewCell {
                cell.genderLbl.text = cellObj?.name
                cell.dataObj = cellResult?.formFields?[indexPath.row]
//                dynamicFormData[cellObj?.name ?? ""] = cell.buttonPressed
//                print(dynamicFormData)
                return cell
            }
        }
        else if cellObj?.input_type == designType.checkBoxDesign.rawValue {
            if let cell = formTableView.dequeueReusableCell(withIdentifier: "CheckBoxTableViewCell", for: indexPath) as? CheckBoxTableViewCell {
                cell.checkBoxLbl.text = cellObj?.name
                cell.checkBoxData = cellResult?.formFields?[indexPath.row]
                return cell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        if let cell = cell as? RadioBtnTableViewCell {
            cell.RadioBtncollectionView.delegate = self
            cell.RadioBtncollectionView.tag = indexPath.section
            cell.RadioBtncollectionView.reloadData()

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("TableViewCell Selected")
    }
    @objc func pressed(sender:UIButton) {

    }
}

extension CustomCellFormVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        dropBoxIndex = textField.tag - tag
        dropBoxTF = textField
        print(dropBoxTF)
        //        let obj = cellResult?.formFields?[textField.tag - tag]
        pickerView.reloadAllComponents()
        //        validateMethod(validateField: textField)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        textFieldMethod(TF: textField)
        validateMethod(validateField: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String){
    //        var changedText = textField.text
    //        textField.text = changedText
    ////        validateMethod(validateField: textField)
    //
    //    }
    
}
extension CustomCellFormVC: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cellResult?.formFields?[dropBoxIndex].fields?.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  cellResult?.formFields?[dropBoxIndex].fields?[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //genderTextField.text = result?.formFields?[dropBoxIndex].fields?[row]
        dropBoxTF.text = cellResult?.formFields?[dropBoxIndex].fields?[row]
        dropBoxTF.resignFirstResponder()
    }
}
//extension UITableView {
//
//    func setBottomInset(to value: CGFloat) {
//        let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: value, right: 0)
//
//        self.contentInset = edgeInset
//        self.scrollIndicatorInsets = edgeInset
//    }
//}
extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}

