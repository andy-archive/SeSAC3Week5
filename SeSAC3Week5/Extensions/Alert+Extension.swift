//
//  Alert+.swift
//  SeSAC3Week5
//
//  Created by Taekwon Lee on 2023/08/17.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, button: String, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: button, style: .default) { action in // showAlert의 생명주기가 끝났으나, 해당 클로저의 정보가 저장이 되었다
            
            completionHandler() // 함수 호출 연산자
        }
        let cancel = UIAlertAction(title: "CANCEL", style: .default)
        
        alert.addAction(button)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}
