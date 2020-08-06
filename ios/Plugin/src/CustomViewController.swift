//
//  CustomViewController.swift
//  App
//
//  Created by Anh Ngo Quang Tuan on 8/5/20.
//

import UIKit
import Capacitor

class CustomViewController: UIViewController {

    var cancelHandler: (() -> Void)?
    var completeHandler: ((String) -> Void)?

    @IBAction private func getOTPButtonTapped(_ sender: Any) {
        let bundle = Bundle(for: Self.classForCoder())
        let storyboard = UIStoryboard(name: "Login", bundle: bundle)
        let controller = storyboard.instantiateViewController(withIdentifier: "CustomViewController2") as! CustomViewController2
        controller.completeHandler = completeHandler
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction private func dismissButtonTapped(_ sender: Any) {
        cancelHandler?()
    }
}
