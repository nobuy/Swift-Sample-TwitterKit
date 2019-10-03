//
//  ViewController.swift
//  Swift-Sample-TwitterKit
//
//  Created by nobuy on 2019/09/25.
//  Copyright © 2019 A10 Lab Inc. All rights reserved.
//

import UIKit
import TwitterCore
import TwitterKit

let defaultColor = UIColor(red: 89.0 / 255, green: 173.0 / 255, blue: 236.0 / 255, alpha: 1.0)
let highlightedColor = UIColor(red: 89.0 / 255 * 0.5, green: 173.0 / 255 * 0.5, blue: 236.0 / 255 * 0.5, alpha: 1.0)

class ViewController: UIViewController {

    private let shareButton = TwitterShareButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Twitter Share"
        view.backgroundColor = .white
        shareButton.addTarget(self, action: #selector(onTwitterShareTapped(_:)), for: .touchUpInside)

        view.addSubview(shareButton)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        shareButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        shareButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        shareButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    @objc private func onTwitterShareTapped(_ sender: UIButton) {
        showImagePicker()
    }

    private func showImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:  [UIImagePickerController.InfoKey : Any]) {
        let composer = TWTRComposer()
        composer.setText("hogehoge")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            composer.setImage(image)
        }
        dismiss(animated: true, completion: {
            DispatchQueue.main.async {
                composer.show(from: self, completion: nil)
            }
        })
    }
}

private class TwitterShareButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    convenience init(title: String) {
        self.init(frame: CGRect.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("not supported")
    }

    fileprivate func initView() {
        layer.cornerRadius = 2.0
        backgroundColor = defaultColor
        contentMode = .center
        setImage(UIImage(named: "icon_tw"), for: UIControl.State())
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = highlightedColor
            } else {
                backgroundColor = defaultColor
            }
        }
    }
}
