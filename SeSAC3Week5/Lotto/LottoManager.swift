//
//  LottoManager.swift
//  SeSAC3Week5
//
//  Created by Taekwon Lee on 2023/08/17.
//

import Foundation
import Alamofire

class LottoManger {
    
    static let shared = LottoManger()
    
    func callLotto(completionHandler: @escaping (Int, Int) -> Void) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
        
        // 네트워크 통신(1)과 응답(2)
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Lotto.self) { response in
                guard let value = response.value else { return }
                print("responseDecodable:", value)
                print(value.bnusNo, value.drwtNo3)
                
                completionHandler(value.bnusNo, value.drwtNo3)
            }
    }
}
