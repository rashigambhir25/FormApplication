// Rashi Gambhir
import UIKit

class SecondViewController: UIViewController{
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    var formDetails: FormModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Details"
        
        self.firstNameLabel?.text = (formDetails?.firstName)!
        self.lastNameLabel?.text = (formDetails?.lastName)!
        self.ageLabel?.text = String((formDetails?.age)!)
        self.genderLabel?.text = formDetails?.genderValue
    
    }
    
    func setDetails(formDetails: FormModel){
        self.formDetails = formDetails
    }
    
    
}

