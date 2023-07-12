//
//  ViewController.swift
//  DynamicForm
//
//  Created by tkandimalla on 06/12/22.
//

import UIKit
import Foundation

class ViewController: UIViewController{
    
    @IBOutlet weak var genderTF: UITextField!
    
    var result: HeaderFields?
    var myTextField: UITextField!
    var genderTextField: UITextField!
    let pickerView = UIPickerView()
    var textView = UITextView()
//    var listOfTextFields : [UITextField] = []
//    var yourArray = [String]()
    var dropBoxIndex = Int()
    //    var fieldindex:Int?
    var tag = 100
    var labeltag = 200
    //    var size: Double
    var size = 50
    var dropBoxTF = UITextField()
    var label = UILabel()
    var dynamicFormData: [String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parseJSON()
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        print("ViewwillTransition")
    }
    public func parseJSON(){
        guard let path = Bundle.main.path(forResource: "HeaderFieldsInfo", ofType: "json") else {
            return
        }
        let url = URL(fileURLWithPath: path)
        do {
            let jsonData = try Data(contentsOf: url)
            result = try JSONDecoder().decode(HeaderFields.self, from: jsonData)
            
            for i in 0..<(result?.formFields?.count ?? 0){
                
                if result?.formFields?[i].input_type == "TextField" {
                    myTextField = UITextField(frame: CGRect(x: 100, y: Double((Int(i) + 1) * Int(size)), width: 200.00, height: 30.00));
                    //myTextField.center = CGPoint(x: 200, y: 100)
                    myTextField?.placeholder = result?.formFields?[i].name
                    myTextField?.textAlignment = .center
                    myTextField?.borderStyle = UITextField.BorderStyle.line
                    myTextField?.backgroundColor = UIColor.white
                    myTextField?.textColor = UIColor.black
                    myTextField.tag = tag + i
                    myTextField.delegate = self
                    //                    yourArray = listOfTextFields[i]
                    self.view.addSubview(myTextField!)
                    //                    print(listOfTextFields[i])
                }
                if result?.formFields?[i].input_type == "TextView" {
                    textView = UITextView(frame: CGRect(x: 100, y: Double((Int(i) + 1) * Int(size)), width: 200.0, height: 30.0))
                    textView.contentInsetAdjustmentBehavior = .automatic
                    //textView.center = self.view.center
                    textView.textAlignment = NSTextAlignment.justified
                    textView.text = result?.formFields?[i].name
                    textView.textColor = UIColor.black
                    textView.backgroundColor = UIColor.white
                    textView.layer.borderColor = UIColor.black.cgColor
                    textView.layer.borderWidth = 1.0
                    textView.tag = tag + i
                    textView.clearsOnInsertion = true
                    textView.delegate = self
                    
                    self.view.addSubview(textView)
                }
                if result?.formFields?[i].input_type == "Button" {
                    let myFirstButton = UIButton()
                    myFirstButton.setTitle("Button", for: .normal)
                    myFirstButton.setTitleColor(.black, for: .normal)
                    myFirstButton.frame = CGRect(x: 150, y: Double((Int(i) + 1) * Int(size)), width: 100, height: 50)
                    //myFirstButton.center = CGPoint(x: 200, y: 200)
                    myFirstButton.tintColor = .black
                    myFirstButton.layer.borderColor = UIColor.black.cgColor
                    myFirstButton.layer.borderWidth = 1.0
                    myFirstButton.tag = tag + i
                    myFirstButton.addTarget(self, action: #selector(pressed(sender:)), for: .touchUpInside)
                    self.view.addSubview(myFirstButton)
                }
                if result?.formFields?[i].input_type == "DropBox"{
                    genderTextField = UITextField(frame: CGRect(x: 100, y: Double((Int(i) + 1) * Int(size)), width: 200.00, height: 30.00));
                    genderTextField.placeholder = result?.formFields?[i].name
                    genderTextField.textAlignment = .center
                    genderTextField.borderStyle = UITextField.BorderStyle.line
                    genderTextField.backgroundColor = UIColor.white
                    genderTextField.textColor = UIColor.black
                    genderTextField.tag = tag + i
                    print("index...\(i)")
                    genderTextField.delegate = self
                    self.view.addSubview(genderTextField)
                    genderTextField.inputView = pickerView
                }
                if result?.formFields?[i].input_type != "Button" {
                    label = UILabel(frame: CGRect(x: 50, y: Double((Int(i) + 1) * Int(size)) + 25, width: 300, height: 21))
                    label.textAlignment = .center
                    label.text = "Please enter the data in \(result?.formFields?[i].name ?? "") field"
                    label.textColor = .red
                    label.font = label.font.withSize(10)
                    label.numberOfLines = 2
                    label.tag = labeltag + i
                    self.view.addSubview(label)
                    label.isHidden = true
                }
                
            }
            
            if let result = result{
                print("\(result)")
                print("\(String(describing: result.formFields?[0].name))")
            }
            else {
                print("Failed to parse")
            }
        }
        
        catch{
            print("Error \(error)")
        }
        
    }
    //    let obj = result?.formFields?[textField.tag - tag]
    //    dynamicFormData[obj?.name ?? ""] = textField.text
    //    print(dynamicFormData)
    func textFieldMethod(TF: UITextField) {
        let obj = result?.formFields?[TF.tag - tag]
        dynamicFormData[obj?.name ?? ""] = TF.text
        print(" Form Data is \(dynamicFormData)")
    }
    func textViewMethod(TV: UITextView){
        let obj = result?.formFields?[TV.tag - tag]
        dynamicFormData[obj?.name ?? ""] = TV.text
        print(" Form Data is \(dynamicFormData)")
    }
    func validateMethod(validateField: UITextField) {
        let enabledIndex = validateField.tag - tag
        let index = validateField.tag + 100
        if let tfObj = self.view.viewWithTag(index) as? UIView {
            if let tempNameObj = tfObj as? UILabel {
                if validateField.text == ""{
                    tempNameObj.isHidden = false
                }
                else {
                    tempNameObj.isHidden = true
                }
            }
        }
        if result?.formFields?[enabledIndex].is_enabled == true{
            validateField.isEnabled = true
            genderTextField.isEnabled = true
        }
        if result?.formFields?[enabledIndex].is_enabled == false {
            validateField.isEnabled = false
            genderTextField.isEnabled = false
        }
    }
    func validateTextViewMethod(validateView: UITextView){
        let enabledIndex = validateView.tag - tag
        let index = validateView.tag + 100
        if let tfObj = self.view.viewWithTag(index) as? UIView {
            if let tempNameObj = tfObj as? UILabel {
                if validateView.text == ""{
                    tempNameObj.isHidden = false
                }
                else {
                    tempNameObj.isHidden = true
                }
            }
        }
        if result?.formFields?[enabledIndex].is_enabled == true{
            validateView.isEditable = true
        }
        if result?.formFields?[enabledIndex].is_enabled == false{
            validateView.isEditable = false
        }
    }
    @objc func pressed(sender:UIButton) {
        var firstName = String()
        if let tfObj = self.view.viewWithTag(100) as? UIView {
            if let tempNameObj = tfObj as? UITextField {
                print(tempNameObj.text)
                firstName = tempNameObj.text ?? ""
            }
        }
        
        var middleName = String()
        if let tfObj = self.view.viewWithTag(101) as? UIView {
            if let tempNameObj = tfObj as? UITextField {
                print(tempNameObj.text)
                middleName = tempNameObj.text ?? ""
            }
        }
        
        
        print(self.view.viewWithTag(100))
        //        for textfield in listOfTextFields{
        //            print("Hi")
        //            print(textfield.text)
        //        }
        var formData: [String:Any] = [:]
        for i in 0..<((result?.formFields?.count ?? 0) - 1){
            if let tfObj = self.view.viewWithTag(tag + i) as? UIView {
                if let tempNameObj = tfObj as? UITextField {
                    print(tempNameObj)
                    print(tempNameObj.text)
                    let obj = result?.formFields?[i]
                    formData[obj?.name ?? ""] = tempNameObj.text
                    if tempNameObj.text == ""{
                        let label = UILabel(frame: CGRect(x: 50, y: Double((Int(i) + 1) * Int(size)) + 25, width: 300, height: 21))
                        //label.center = CGPoint(x: 160, y: 285)
                        label.textAlignment = .center
                        label.text = "Please enter the data in \(result?.formFields?[i].name ?? "") field"
                        label.textColor = .red
                        label.font = label.font.withSize(10)
                        label.numberOfLines = 2
                        self.view.addSubview(label)
                    }
                }
                else if let tempNameObj = tfObj as? UITextView {
                    print(tempNameObj)
                    print(tempNameObj.text)
                    let obj = result?.formFields?[i]
                    formData[obj?.name ?? ""] = tempNameObj.text
                    if tempNameObj.text == ""{
                        let label = UILabel(frame: CGRect(x: 50, y: Double((Int(i) + 1) * Int(size)) + 100, width: 300, height: 21))
                        //label.center = CGPoint(x: 160, y: 285)
                        label.textAlignment = .center
                        label.text = "Please enter the data in \(result?.formFields?[i].name ?? "") field"
                        label.textColor = .red
                        label.font = label.font.withSize(10)
                        label.numberOfLines = 2
                        self.view.addSubview(label)
                    }
                }
            }
            print(i)
        }
        print("Final object")
        print(formData)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextVC = storyBoard.instantiateViewController(withIdentifier: "CustomCellFormVC") as! CustomCellFormVC
        nextVC.modalPresentationStyle  = .fullScreen
        nextVC.cellResult = result
        self.present(nextVC, animated:true, completion:nil)
    }
    
}
extension ViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        dropBoxIndex = textField.tag - tag
        dropBoxTF = textField
        print(dropBoxTF)
        let obj = result?.formFields?[textField.tag - tag]
        pickerView.reloadAllComponents()
        //        validateMethod(validateField: textField)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldMethod(TF: textField)
        validateMethod(validateField: textField)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        validateMethod(validateField: textField)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        validateMethod(validateField: textField)
        return true
    }
    
}
extension ViewController: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        textViewMethod(TV: textView)
        validateTextViewMethod(validateView: textView)
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        validateTextViewMethod(validateView: textView)
        return true
    }
}
extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return result?.formFields?[dropBoxIndex].fields?.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return result?.formFields?[dropBoxIndex].fields?[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //genderTextField.text = result?.formFields?[dropBoxIndex].fields?[row]
        dropBoxTF.text = result?.formFields?[dropBoxIndex].fields?[row]
        dropBoxTF.resignFirstResponder()
    }
}

struct HeaderFields: Codable{
    var formFields: [FormFields]?
    enum CodingKeys: String,CodingKey{
        case formFields = "FormFields"
    }
}
struct FormFields: Codable{
    let name: String?
    let type: String?
    var index: Int?
    let input_type: String?
    let fields: [String]?
    let is_enabled: Bool?
    enum CodingKeys: String,CodingKey{
        case name = "Name"
        case type = "Type"
        case index = "Index"
        case input_type = "InputType"
        case fields = "Fields"
        case is_enabled = "isEnable"
    }
}

