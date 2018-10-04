import PromiseKit

class Classinator {

    static let shared = Classinator()

    private var adapter = Adapter.shared

    func classinate(sighting: String) -> Promise<Classination> {
        return adapter.classinate(json: [ "sighting" : sighting ])
            .then { Promise<Classination>.value(Classination(data: $0)) }
    }
}

struct Classination {
    init(data: [String : Any]) {
        let rawClassination = data["classination"] as? [String:Any] ?? [:]
        let rawSelected = rawClassination["selected"] as? String ?? ""
        self.type = ClassinationType.init(rawValue: rawSelected) ?? .classA
        self.message = classinationMessages[self.type] ?? ""
    }

    var type: ClassinationType
    var message: String
}

enum ClassinationType: String {
    case classA = "Class A"
    case classB = "Class B"
    case classC = "Class C"
}

let classinationMessages = [
    ClassinationType.classA : "You saw bigfoot! That's a Class A sighting.",
    ClassinationType.classB : "You found some evidence of bigfoot like a footprint! That's a Class B sighting.",
    ClassinationType.classC : "Someone told you about seeing bigfoot! That's a Class C sighting"
]
