import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sightingTextView: UITextView!

    private var classinator = Classinator.shared
    private var messages = Messages.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func classinateButtonTapped(_ sender: Any) {
        let sighting: String = self.sightingTextView?.text ?? ""
        _ = classinator.classinate(sighting: sighting)
            .done { classination in
                let title = classination.rawValue
                let message = self.messages.fetchMessage(classination: classination)
                self.showAlert(title: title, message: message)
            }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }

}

