import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sightingTextView: UITextView!

    private var classinator = BigfootClassinator.shared

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func classinateButtonTapped(_ sender: Any) {
        let sighting: String = self.sightingTextView?.text ?? ""
        self.classinator.classinate(sighting: sighting)
            .done { classination in
                let title: String = classination.classination.rawValue
                let message: String = classination.message
                self.showAlert(title: title, message: message)
            }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }

}

