//
//  Protocols.swift
//  SeSAC3Week5
//
//  Created by Taekwon Lee on 2023/08/17.
//

import UIKit

protocol ReusableViewProtocol { // 주로 명시적으로 "Protocol"이라는 명칭을 뒤에 쓴다
    static var identifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
}
