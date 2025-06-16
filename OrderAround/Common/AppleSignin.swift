//
//  AppleSignin.swift
//  applesignin
//
//  Created by Ansar on 06/12/19.
//  Copyright © 2019 Ansar's MacBook Pro. All rights reserved.
//

import UIKit
import AuthenticationServices

class AppleSignin: NSObject {

    static var shared = AppleSignin()
    
    private var onSuccess:((AppleDetails)->())?
    
    @available(iOS 13.0, *)
    public func initAppleSignin(scope: [ASAuthorization.Scope]?,completion: @escaping (AppleDetails)->Void) {
        self.onSuccess = completion
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = scope
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.presentationContextProvider = self
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}

//MARK:- Delegate

extension AppleSignin: ASAuthorizationControllerDelegate {
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let name = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: userIdentifier) {  (credentialState, error) in
                switch credentialState {
                case .authorized: // The Apple ID credential is valid.
                    
                    break
                case .revoked: // The Apple ID credential is revoked.
                    
                    break
                case .notFound:
                    break
                default:
                    break
                }
            }
            let firstName = (name?.givenName ?? "")
            let lastName = (name?.familyName ?? "")
            let appleData = AppleDetails(userId: userIdentifier, firstName: firstName, lastName: lastName, email: email, error: nil)
            self.onSuccess?(appleData)
        }
        
        func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
            let appleData = AppleDetails(userId: nil, firstName: nil, lastName: nil, email: nil, error: error.localizedDescription)
            self.onSuccess?(appleData)
        }
        
    }
}

extension AppleSignin: ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
       let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
        return keyWindow!
    }
    
}

class AppleDetails {
    
    var userId: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var error: String?
    
    init(userId: String?, firstName: String?, lastName: String?, email: String?, error: String?) {
        
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.error = error
        
    }
}
