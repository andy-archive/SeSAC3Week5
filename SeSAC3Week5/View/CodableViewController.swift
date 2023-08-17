//
//  CodableViewController.swift
//  SeSAC3Week5
//
//  Created by Taekwon Lee on 2023/08/16.
//

import UIKit
import Alamofire

// 열거형은 컴파일 시점에 확정 - 오류 타입을 알 수 있다
enum ValidationError: Error {
    case emptyString
    case isNotInt
    case isNotDate
}

class CodableViewController: UIViewController {
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    
    var resultText = "Apple"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        fetchTranslateData(source: "ko", target: "en", text: "안녕하세요")
//        fetchLottoData()
        
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        
        guard let text = dateTextField.text else { return }
        
        do {
            let _ = try validateUserInputError(text: text)
        } catch {
            print("VALIDATION ERROR")
        }
        
//        } catch ValidationError.emptyString {
//            print(ValidationError.emptyString)
//        } catch ValidationError.isNotInt {
//            print(ValidationError.isNotInt)
//        } catch ValidationError.isNotDate {
//            print(ValidationError.isNotDate)
//        }
        
//        if validateUserInput(text: text) {
//            print("IT IS ABLE TO SEARCH AND DO NETWORK REQUEST")
//        } else {
//            print("NOT ABLE TO SEARCH")
//        }
        
    }
    
    func validateUserInputError(text: String) throws -> Bool {
        
        // 빈 칸일 경우
        guard !(text.isEmpty) else {
            print("EMPTY VALUE")
            throw ValidationError.emptyString
        }
        
        // 숫자 여부
        guard Int(text) != nil else {
            print("IT IS NOT AN INTEGER")
            throw ValidationError.isNotInt
        }
        
        // 날짜 형식으로 변환이 되는지?
        guard checkDataFormat(text: text) else {
            print("WRONG DATE FORMAT")
            throw ValidationError.isNotDate
        }
        
        return true
    }
    
    func validateUserInput(text: String) -> Bool {
        
        // 빈 칸일 경우
        guard !(text.isEmpty) else {
            print("EMPTY VALUE")
            return false
        }
        
        // 숫자 여부
        guard Int(text) != nil else {
            print("IT IS NOT AN INTEGER")
            return false
        }
        
        // 날짜 형식으로 변환이 되는지?
        guard checkDataFormat(text: text) else {
            print("WRONG DATE FORMAT")
            return false
        }
        
        return true
    }
    
    func checkDataFormat(text: String) -> Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        
        guard let _ = format.date(from: text) else { return false }
        
        return true
    }
    
    func fetchTranslateData(source: String, target: String, text: String) {
        
        print("fetchTranslateData", source, target, text)
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": Key.clientID,
            "X-Naver-Client-Secret": Key.clientSecret
        ]
        let parameters: Parameters = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Translation.self) { response in
                guard let value = response.value else { return }
                print(value.message.result.translatedText)
                
                self.resultText = value.message.result.translatedText
                print("확인: \(self.resultText)")
                
                self.fetchTranslateData2(source: "en", target: "ko", text: self.resultText) // 재귀 호출에 따른 무한루프가 발생할 수 있다
            }
    }
    
    func fetchTranslateData2(source: String, target: String, text: String) {
        
        print("fetchTranslateData", source, target, text)
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": Key.clientID,
            "X-Naver-Client-Secret": Key.clientSecret
        ]
        let parameters: Parameters = [
            "source": source,
            "target": target,
            "text": text
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: header)
            .validate(statusCode: 200...500)
            .responseDecodable(of: Translation.self) { response in
                guard let value = response.value else { return }
                print(value.message.result.translatedText)
                
                self.resultText = value.message.result.translatedText
                print("확인 22: \(self.resultText)")
            }
    }
    
    //    func fetchLottoData() {
    //        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
    //
    //        // 1
    //        AF.request(url, method: .get).validate() // AF 안에서 자체적으로 global()로 보내기에, 따로 DispatchQueue.global()를 할 필요가 없다
    //            .responseData { response in
    //                guard let value = response.value else { return }
    //                print("responseData:", value)
    //
    //                DispatchQueue.main.async {
    //                    // UI 관련 코드 (UIImage, UILabel, ...)
    //                }
    //            }
    //
    //        // 2
    //        AF.request(url, method: .get).validate()
    //            .responseString { response in
    //                guard let value = response.value else { return }
    //                print("responseString:", value)
    //            }
    //
    //        // 3
    //        AF.request(url, method: .get).validate()
    //            .response { response in
    //                guard let value = response.value else { return }
    //                print("response:", value)
    //            }
    //
    //        // Codable를 이용한 json
    //        AF.request(url, method: .get).validate()
    //            .responseDecodable(of: Lotto.self) { response in
    //                guard let value = response.value else { return }
    //                print("responseDecodable:", value)
    //                print(value.bnusNo, value.drwtNo3)
    //            }
    //
    //    }
    
}
