// Rashi Gambhir
import Foundation

enum Gender: Int{
    case male = 0
    case female = 1
    
    func getGender()-> String{
        switch self{
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
}

struct FormModel{
    
    let firstName: String?
    let lastName: String?
    let age: Int?
    let genderValue: String?
    
    init(firstName: String, lastName: String, age: Int, genderValue: Int){
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        
        let gender = Gender(rawValue: genderValue)
        self.genderValue = gender?.getGender()
    }
}




