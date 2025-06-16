////
////  PayUMoney.swift
////  PayUMoney
////
////  Created by Ansar on 22/10/19.
////  Copyright © 2019 Ansar. All rights reserved.
////
//
//import Foundation
//import PlugNPlay
//import CommonCrypto
//
//class PayUMoney: NSObject {
//    static let shared = PayUMoney()
//
//
//    func initiateSdk(data : AddAmountEntity,controller: UIViewController, with predications : @escaping (_ response: [AnyHashable : Any],_ error: String?)->Void) {
//        let transParam = PUMTxnParam()
//        transParam.phone = data.phone
//        transParam.email = data.email
//        transParam.amount = "\(data.amount ?? "0")"
//        transParam.environment = .test
//        transParam.firstname = data.firstName
//        transParam.key = data.KEY
//        transParam.merchantid = data.MerchantId
//        transParam.txnID = "\(data.txnid ?? 0)"
//        transParam.surl = data.surl
//        transParam.furl = data.furl
//        transParam.productInfo = data.productinfo
//        transParam.udf1 = "";
//        transParam.udf2 = "";
//        transParam.udf3 = "";
//        transParam.udf4 = "";
//        transParam.udf5 = "";
//        transParam.udf6 = "";
//        transParam.udf7 = "";
//        transParam.udf8 = "";
//        transParam.udf9 = "";
//        transParam.udf10 = "";
//        transParam.hashValue = data.hash
//
//
//        PlugNPlay.presentPaymentViewController(withTxnParams: transParam, on: controller) { (paymentResponse, error, extraParam) in
//            if error == nil {
//                var message = ""
//                if let paymentRes = paymentResponse?["result"] as? [AnyHashable : Any] {
//                    print(paymentRes)
//                    message = "Hello Asad sucess"
//                } else {
//                    message = paymentResponse?["status"] as? String ?? ""
//                }
//                print(message)
//            }else{
//                print(error?.localizedDescription ?? "")
//            }
//        }
//    }
//}
