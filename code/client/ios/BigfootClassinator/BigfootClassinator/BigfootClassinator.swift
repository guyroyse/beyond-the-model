import Foundation
import Alamofire
import PromiseKit

class BigfootClassinator {

    static let shared = BigfootClassinator()

    func classinate(sighting: String) -> Promise<BigfootClassination> {

        let parameters: Parameters = [ "sighting" : sighting ]

        return Alamofire
            .request("http://localhost:5000/classinate", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON()
            .then { response -> Promise<BigfootClassination> in
                let rawData = response.json as? [String:Any] ?? [:]
                let rawClassination = rawData["classination"] as? [String:Any] ?? [:]
                let rawSelected = rawClassination["selected"] as? String ?? ""
                let selected = Classination.init(rawValue: rawSelected) ?? .classA

                let message = classinationMessages[selected] ?? ""

                let classination = BigfootClassination(classination: selected, message: message)
                return Promise<BigfootClassination>.value(classination)
            }
    }
}

struct BigfootClassination {
    var classination: Classination
    var message: String
}

enum Classination: String {
    case classA = "Class A"
    case classB = "Class B"
    case classC = "Class C"
}

let classinationMessages = [
    Classination.classA : "You saw bigfoot! That's a Class A sighting.",
    Classination.classB : "You found some evidence of bigfoot like a footprint! That's a Class B sighting.",
    Classination.classC : "Someone told you about seeing bigfoot! That's a Class C sighting"
]
