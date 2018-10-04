import Alamofire
import PromiseKit

class Adapter {
    static let shared = Adapter()

    func classinate(json: [String:Any]) -> Promise<[String:Any]> {
        return Alamofire
            .request("http://localhost:5000/classinate", method: .post, parameters: json, encoding: JSONEncoding.default)
            .responseJSON()
            .then { response -> Promise<[String:Any]> in
                let rawData = response.json as? [String:Any] ?? [:]
                return Promise<[String:Any]>.value(rawData)
        }
    }
}
