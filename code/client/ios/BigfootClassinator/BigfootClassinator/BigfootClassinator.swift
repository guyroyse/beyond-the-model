import PromiseKit

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

class Classinator {

    static let shared = Classinator()

    private var adapter = Adapter.shared

    func classinate(sighting: String) -> Promise<BigfootClassination> {

        return adapter.classinate(json: [ "sighting" : sighting ])
            .then { data -> Promise<BigfootClassination> in
                let rawClassination = data["classination"] as? [String:Any] ?? [:]
                let rawSelected = rawClassination["selected"] as? String ?? ""
                let selected = Classination.init(rawValue: rawSelected) ?? .classA

                let message = classinationMessages[selected] ?? ""

                let classination = BigfootClassination(classination: selected, message: message)
                return Promise<BigfootClassination>.value(classination)
            }
    }
}

