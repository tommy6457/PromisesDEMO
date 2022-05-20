//
//  ViewController.swift
//  PromisesDEMO
//
//  Created by FETC_iMac2 on 2022/5/19.
//

import UIKit
import Promises

enum TestError: Error {
    case testerror
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        promiseTest(success: true)
    }

    func promiseTest(success: Bool){



        all(doPromise1(),
            doPromise2()
        ).then{ _,_ in
            print("都成功")
        }.catch{ (error) in
            print(error)
        }

    }

    func doPromise1() -> Promise<String>{

        return Promise<String>(on: .main) { fulfill, reject in
//            print("任務1成功")
//            fulfill("任務1成功")
            print("任務1失敗")
            reject(TestError.testerror)
        }
    }

    func doPromise2() -> Promise<String> {

        return Promise<String>(on: .main) { fulfill, reject in
            print("任務2成功")
            fulfill("任務2成功")
//            print("任務2失敗")
//            reject(TestError.testerror)
        }
    }

    func doPromise3() -> Promise<String> {

        return Promise<String>(on: .main) { fulfill, reject in
            print("任務3成功")
            fulfill("任務3成功")
        }
    }

    func work1(_ string: String) -> Promise<String> {
      return Promise {
        return string
      }
    }

    func work2(_ string: String) -> Promise<Int> {
        return Promise {
            return Int(string) ?? 0
      }
    }

    func work3(_ number: Int) -> Int {
      return number * number
    }

    func work4(){

        work1("123zz").then { string in
            return self.work2(string)
        }.then { number in
            return self.work3(number)
        }.then { number in
          print(number)  // 100
        }.catch { error in
            print("error:\(error.localizedDescription)")
        }

    }



}

