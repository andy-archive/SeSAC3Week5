//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by Taekwon Lee on 2023/08/16.
//

import UIKit
import Alamofire

class PosterViewController: UIViewController {

    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        LottoManger.shared.callLotto { bonus, number in
//            print("VALUES FROM CLOSURE: \(bonus), \(number)")
//        }
        
        configureCollectionView()
        configureCollectionViewLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        showAlert(title: "Test ALERT", message: "DO YOU WANT TO CHANGE?", button: "CHANGE") {
//            print("DID CLICK CHANGE BUTTON") // 실행 순서 (2)
//            self.posterCollectionView.backgroundColor = .lightGray
//        }
//        print("AFTER showAlert") // 실행 순서 (1)
    }
    
}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
        
        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier, for: indexPath) as? HeaderPosterCollectionReusableView else { return UICollectionReusableView() }
            
            view.headerLabel.text = "Test Section"
            
            return view
        } else {
            return UICollectionReusableView()
        }
    }
}

extension PosterViewController: CollectionViewAttributeProtocol {
    // Protocol as Type
    func configureCollectionView() {
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        posterCollectionView.register(UINib(nibName: PosterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: "PosterCollectionViewCell")
        posterCollectionView.register(UINib(nibName: HeaderPosterCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier)
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        posterCollectionView.collectionViewLayout = layout
    }
}

protocol Test {
    func test()
}

class A: Test {
    func test() {
    }
    
}

class B: Test {
    func test() {
    }
}

class C: A {
    
}

let example: Test = B() // 클래스가 프로토콜을 충족한다면 타입처럼 사용이 되어서 꼭 상속을 받지 않더라도 할당할 수 있다

let value: A = C() // 타입이 A이더라도 C를 할당해도 A갸 C를 상속하기에 상관이 없다
