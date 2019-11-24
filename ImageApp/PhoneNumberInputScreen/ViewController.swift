//
//  ViewController.swift
//  ImageApp
//
//  Created by Stepan Chegrenev on 20.11.2019.
//  Copyright © 2019 Stepan Chegrenev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var goButton: UIButton!

    private var phoneNumber = ""
    private var textFieldFormatter: TextFieldFormatter!
    private var imageDownloader: ImageDownloader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        phoneNumberTextField.delegate = self
        textFieldFormatter = TextFieldFormatter()
        imageDownloader = ImageDownloader()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func goToPhotoStatusScreen(_ sender: Any) {
        validateNumberAndDownloadImage(text: phoneNumberTextField.text!)
    }

    func validateNumberAndDownloadImage(text: String) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            if text.count < 18 || !text.hasPrefix("+7") {
                DispatchQueue.main.async { [weak self] in
                    let alert = UIAlertController(title: "Введите коректный номер", message: nil, preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

                    self?.present(alert, animated: true)
                }
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.view.aj_showDotLoadingIndicator()
                }
                self?.imageDownloader.downloaded(from: "https://eoimages.gsfc.nasa.gov/images/imagerecords/74000/74393/world.topo.200407.3x5400x2700.png") { (image) in
                    DispatchQueue.main.async { [weak self] in
                        self?.view.aj_hideDotLoadingIndicator()
                        let storyboard = UIStoryboard(name: "PhotoStatusScreen", bundle: nil)

                        let viewController = storyboard
                            .instantiateViewController(withIdentifier:
                                String(describing: PhotoStatusScreenViewController.self)) as! PhotoStatusScreenViewController
                        viewController.image = image
                        self?.navigationController?.pushViewController(viewController, animated: true)
                    }
                }
            }
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        textField.text = textFieldFormatter.formattedNumber(number: newString)
        return false
    }
}

