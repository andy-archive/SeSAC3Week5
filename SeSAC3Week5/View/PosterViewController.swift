//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by Taekwon Lee on 2023/08/16.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class PosterViewController: UIViewController {

    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    var list: Recommendation = Recommendation(totalResults: 0, totalPages: 0, results: [], page: 0)
    var secondList: Recommendation = Recommendation(totalResults: 0, totalPages: 0, results: [], page: 0)
    var thirdList: Recommendation = Recommendation(totalResults: 0, totalPages: 0, results: [], page: 0)
    var fourthList: Recommendation = Recommendation(totalResults: 0, totalPages: 0, results: [], page: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        LottoManger.shared.callLotto { bonus, number in
        //            print("VALUES FROM CLOSURE: \(bonus), \(number)")
        //        }
        
        //        for item in UIFont.familyNames {
        //            print(item)
        //
        //            for name in UIFont.fontNames(forFamilyName: item) {
        //                print("=======\(name)")
        //            }
        //        }
        
        configureCollectionView()
        configureCollectionViewLayout()
        
        let movieId = [673, 674, 675, 676]
        
        let group = DispatchGroup()
        
        for item in movieId {
            group.enter()
            callRecommendation(movieId: item) { data in
                if item == 673 {
                    self.list = data
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print("====END====")
            self.posterCollectionView.reloadData()
        }
    }
    
    func dispatchGroupEnterLeave() {
        let group = DispatchGroup()
        
        group.enter() // + 1
        callRecommendation(movieId: 671) { data in
            self.list = data
            print("====1====")
            group.leave() // - 1
        }
 
        group.enter() // + 1
        callRecommendation(movieId: 27205) { data in
            self.secondList = data
            print("====2====")
            group.leave() // - 1
        }
        
        group.enter() // + 1
        callRecommendation(movieId: 569094) { data in
            self.thirdList = data
            print("====3====")
            group.leave() // - 1
        }
        
        group.enter() // + 1
        callRecommendation(movieId: 843) { data in
            self.fourthList = data
            print("====4====")
            group.leave() // - 1
        }
        
        group.notify(queue: .main) {
            print("====END====")
            self.posterCollectionView.reloadData()
        }
    }
    
    func dispatchGroupNotify() {

        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(movieId: 671) { data in
                self.list = data
                print("====1====")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(movieId: 27205) { data in
                self.secondList = data
                print("====2====")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(movieId: 569094) { data in
                self.thirdList = data
                print("====3====")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            self.callRecommendation(movieId: 843) { data in
                self.fourthList = data
                print("====4====")
            }
        }
        
        group.notify(queue: .main) {
            print("END")
            self.posterCollectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        showAlert(title: "Test ALERT", message: "DO YOU WANT TO CHANGE?", button: "CHANGE") {
//            print("DID CLICK CHANGE BUTTON") // 실행 순서 (2)
//            self.posterCollectionView.backgroundColor = .lightGray
//        }
//        print("AFTER showAlert") // 실행 순서 (1)
    }
    
    // 해리포터: 671 & 인셉션: 27205 & 스파이더맨 어크로스: 569094 & 화양연화 843
    func callRecommendation(movieId: Int, completionHandler: @escaping (Recommendation) -> Void) {
        
        let url = "https://api.themoviedb.org/3/movie/\(movieId)/recommendations?api_key=\(Key.tmdbKey)&language=ko-KR"
        
        AF.request(url).validate(statusCode: 200...500)
            .responseDecodable(of: Recommendation.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return list.results.count
        } else if section == 1 {
            return secondList.results.count
        } else if section == 2 {
            return thirdList.results.count
        } else if section == 3 {
            return fourthList.results.count
        } else {
            return 9
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.section == 0 {
            let url = "https://www.themoviedb.org/t/p/w220_and_h330_face\(list.results[indexPath.item].posterPath ?? "" )"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if indexPath.section == 1 {
            let url = "https://www.themoviedb.org/t/p/w220_and_h330_face\(secondList.results[indexPath.item].posterPath ?? "" )"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if indexPath.section == 2 {
            let url = "https://www.themoviedb.org/t/p/w220_and_h330_face\(thirdList.results[indexPath.item].posterPath ?? "" )"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        } else if indexPath.section == 3 {
            let url = "https://www.themoviedb.org/t/p/w220_and_h330_face\(fourthList.results[indexPath.item].posterPath ?? "" )"
            cell.posterImageView.kf.setImage(with: URL(string: url))
        }
        
        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier, for: indexPath) as? HeaderPosterCollectionReusableView else { return UICollectionReusableView() }
            
            view.headerLabel.text = "Test Section \(indexPath.section)"
            view.headerLabel.font = UIFont(name: "GmarketSansBold", size: 20)
            
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

// =====================================

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
