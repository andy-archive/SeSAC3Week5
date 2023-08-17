//
//  GCDBasicViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class GCDBasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        globalAsyncTwo()
    }
    
    func globalAsyncTwo() {
        print("Start")
        
        for i in 1...100 {
            DispatchQueue.global().async {
                sleep(1)
                print(i, terminator: " ")
            }

        }
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    func globalAsync() {
        print("Start")
        
        // 멀티 스레드에 대한 비동기적으로 실행
        DispatchQueue.global().async { // 네트워크와 같이 뒤에서 작업이 필요한 것들은 병렬 + 비동기적으로 실행한다
            for i in 1...30 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 31...60 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    func globalSync() {
        print("Start")
        
        // 멀티 스레드에 대한 동기적으로 실행
        DispatchQueue.global().sync { // 멀티 스레드라 하더라도 메인 스레드가 멀티 스레드의 작업이 끝날 때까지 기다리고 있음
            for i in 1...30 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 31...60 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    // 메인 스레드에 대한 비동기적으로 실행
    func serialAsync() {
        print("Start")
        
        DispatchQueue.main.async { // 다른 작업이 실행한 뒤에 실행
            for i in 1...30 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 31...60 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    // 직렬 - 모든 코드가 메인 스레드에 대한 동기적으로 실행
    func serialSync() { // 메인 스레드에서 혼자 다 실행하고 있다
        print("Start")
        
        for i in 1...30 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        // 무한 대기 상태, 교착 상태(deadlock)가 발생
        DispatchQueue.main.sync {
            for i in 31...60 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        print("End")
    }
}
