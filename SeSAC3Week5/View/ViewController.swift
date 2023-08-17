//
//  ViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var syncButton: UIButton!
    @IBOutlet var asyncButton: UIButton!
    @IBOutlet var groupButton: UIButton!
     
    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    @IBOutlet var fourthImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        syncButton.addTarget(self, action: #selector(syncButtonClicked), for: .touchUpInside)
        
        asyncButton.addTarget(self, action: #selector(asyncButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func asyncButtonClicked() { // 비동기적으로 진행
        print("async start")
        asyncDownloadImage(imageView: firstImageView, value: "First")
//        asyncDownloadImage(imageView: secondImageView, value: "Second")
//        asyncDownloadImage(imageView: thirdImageView, value: "Third")
//        asyncDownloadImage(imageView: fourthImageView, value: "Fourth")
        
        print("async end")
    }
        
    @objc func syncButtonClicked() { // 동기적으로 진행
        
        print("sync start")
        print("sync end")
        
    }
    
    // 비동기 -> 일단 다른 스레드에게 작업을 보내어 나머지를 실행하게 한다
    // 이때, 작업이 언제 끝나는지는 정확한 시점은 알기 어렵다
    // UI는 메인 스레드에서 해야 한다!
    func asyncDownloadImage(imageView: UIImageView, value: String) {
         
        print("===1===\(value)===", Thread.isMainThread)
        DispatchQueue.global().async { // 병렬적으로 비동기 진행
            print("===2===\(value)", Thread.isMainThread)
            let data = try! Data(contentsOf: Nasa.photo)
            
            DispatchQueue.main.async { // UIImage만 메인 스레드에서 실행 -> 다른 비동기가 모두 끝난 이후에 실행
                imageView.image = UIImage(data: data)
                print("===3===\(value)===", Thread.isMainThread)
            }
            
            print("===4===\(value)===", Thread.isMainThread)
        }
        print("===5===\(value)===", Thread.isMainThread)
    }
     
}

//extension ViewController: CollectionViewAttributeProtocol {
//    
//    func configureCollectionView() {
//        <#code#>
//    }
//    
//    func configureCollectionViewLayout() {
//        <#code#>
//    }
//    
//}
