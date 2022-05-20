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

        promiseTest(success: false)

    }

    func promiseTest(success: Bool){

        let promise = Promise<String>(on: .main) { fulfill, reject in

            if success {
                // Resolve with a value.
                fulfill("Hello world.")
            } else {
                // Resolve with an error.
                reject(TestError.testerror)
            }

        }

        promise.then { string in
            print("\(string)")  //Hello world.
        }.catch { error in
            print(error.self)   //testerror
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

