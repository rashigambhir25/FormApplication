// Rashi Gambhir
import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var fillDetailsLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var segementGender: UISegmentedControl!
    @IBOutlet weak var ageLimitLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var field: UITextField?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startButton.isEnabled = true
        submitButton.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.ageTextField.delegate = self
        
        //        submitButton.isEnabled = false
        ageLimitLabel.isHidden = true
        
        title = "Form"
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.touch))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        scrollView.addGestureRecognizer(recognizer)
        
    }
    
    //MARK: - Functions
    
    func ageBonus(){
        
        if let ageLimit = Int(ageTextField.text ?? "0"){
            if(ageLimit > 150){
                ageLimitLabel.isHidden = false
            }
            else{
                ageLimitLabel.isHidden = true
                submitButton.isEnabled = true
                startButton.isEnabled = false
            }
        }
    }
    
    private func switchBasedNextTextField(_ textField: UITextField?) {
        
        switch textField {
        case self.firstNameTextField:
            self.lastNameTextField.becomeFirstResponder()
            field = lastNameTextField ??  field
        case self.lastNameTextField:
            self.ageTextField.becomeFirstResponder()
            field = ageTextField ?? field
        case self.ageTextField:
            field = ageTextField ?? field
        default:
            self.firstNameTextField.becomeFirstResponder()
            field = firstNameTextField
        }
    }
    
    // MARK: - Button Funtionality
    
    
    @IBAction func buttonStart(_ sender: UIButton) {
        
        self.switchBasedNextTextField(field)
        
        if(firstNameTextField.text != ""){
            startButton.setTitle("Next", for: .normal)
        }else{
            field?.placeholder = "Type something"
        }
        
        if(lastNameTextField.text != "" || ageTextField.text != ""){
            fillDetailsLabel.isHidden = true
            ageBonus()
        }
        else{
            fillDetailsLabel.isHidden = false
        }
    }
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        self.view.backgroundColor = .systemPurple
        startButton.setTitle("Next", for: .normal)
    }
    
    @IBAction func genderSegement(_ sender: Any) {
        self.view.backgroundColor = .systemPurple
    }
    
    @IBAction func lastNameChanged(_ sender: UITextField) {
        self.view.backgroundColor = .systemPurple
    }
    
    @IBAction func ageChanged(_ sender: UITextField) {
        self.view.backgroundColor = .systemPurple
    }
    
    @IBAction func tapOnSubmitButton(_ sender: UIButton) {
        
        let secondViewController = storyboard?.instantiateViewController(withIdentifier:"secondViewController") as! SecondViewController
        secondViewController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(secondViewController, animated: true)
        
        self.view.backgroundColor = .white
        
        ageBonus()
        
        if let firstName = firstNameTextField.text ,let lastName = lastNameTextField.text ,let age = ageTextField.text{
            
            let formModel = FormModel(firstName: firstName, lastName: lastName, age: Int(age) ?? 0, genderValue: segementGender.selectedSegmentIndex)
            secondViewController.setDetails(formDetails: formModel)
            
        }
    }
    
    // MARK: - UITextFieldDelegate
    
    @objc func touch(){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.switchBasedNextTextField(textField)
        
        if(lastNameTextField.text != "" || ageTextField.text != ""){
            fillDetailsLabel.isHidden = true
            submitButton.isEnabled = true
        }
        else{
            fillDetailsLabel.isHidden = false
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }
        else{
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    let allowedCharacters = CharacterSet(charactersIn:"0123456789").inverted
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if (textField == ageTextField!){
            
            let components = string.components(separatedBy: allowedCharacters)
//            print(components)
            
            let filtered = components.joined(separator: "")
//            print(filtered + "filtered")
            
            if string == filtered  {
                
                return true
                
            } else {
                
                return false
            }
        }
        else {
            return true
        }
    }
    
}

