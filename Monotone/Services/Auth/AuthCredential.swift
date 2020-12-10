//
//  AuthCredential.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/10.
//

import Foundation

// MARK: AuthCredential
class AuthCredential: NSObject, NSCoding{
    
    init(accessToken: String,
         tokenType: String,
         scope: String,
         createAt: Double){
        
        self._accessToken = accessToken
        self._tokenType = tokenType
        self._scope = scope
        self._createAt = createAt
    }
    
    // MARK: Public
    public var accessToken : String{
        get{ return _accessToken }
    }
    
    public var tokenType : String{
        get{ return _tokenType }
    }
    
    public var scope : String{
        get{ return _scope }
    }
    
    public var createAt : Date{
        get{ return Date(timeIntervalSince1970: _createAt) }
    }
    
    // Mark: Private
    private var _accessToken : String
    private var _tokenType : String
    private var _scope : String
    private var _createAt : Double
    
    required init(coder aDecoder: NSCoder) {
        _accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String ?? ""
        _tokenType = aDecoder.decodeObject(forKey: "tokenType") as? String ?? ""
        _scope = aDecoder.decodeObject(forKey: "scope") as? String ?? ""
        _createAt = aDecoder.decodeObject(forKey: "createAt") as? Double ?? 0
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(_accessToken, forKey: "accessToken")
        aCoder.encode(_tokenType, forKey: "tokenType")
        aCoder.encode(_scope, forKey: "scope")
        aCoder.encode(_createAt, forKey: "createAt")
    }
}

// MARK: UserDefaults Presistence.
extension AuthCredential{
    
    public static func localCredential() -> AuthCredential? {
        guard let authCredentialData = UserDefaults.standard.data(forKey: "authCredential") else { return nil }
        
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: AuthCredential.self, from: authCredentialData)
        }
        catch{
            print("Unarchive AuthCredential failed.")
        }
        
        return nil
    }
    
    public static func storeCredential(for credential: AuthCredential) {
        
        do {
            let authCredentialData = try NSKeyedArchiver.archivedData(withRootObject: credential, requiringSecureCoding: false)
            UserDefaults.standard.setValue(authCredentialData, forKey: "authCredential")
        }
        catch{
            print("Archive AuthCredential failed.")
        }
    }
}
