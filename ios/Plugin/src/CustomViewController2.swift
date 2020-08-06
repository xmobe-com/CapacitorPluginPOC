//
//  CustomViewController2.swift
//  App
//
//  Created by Anh Ngo Quang Tuan on 8/6/20.
//

import UIKit

class CustomViewController2: UIViewController {
    
    var completeHandler: ((String) -> Void)?
    
    @IBAction func inputOTPButtonTapped(_ sender: UIButton) {
        /// Simulate JWT Token response
        completeHandler?("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c")
    }
}
