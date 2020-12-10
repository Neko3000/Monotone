//
//  AuthCredential.swift
//  Monotone
//
//  Created by Xueliang Chen on 2020/12/10.
//

import Foundation

let USER_DEFAULTS_KEY_AUTH_CREDENTIAL = "USER_DEFAULT_KEY_AUTH_CREDENTIAL"

// MARK: AuthCredential
class AuthCredential: NSObject, NSCoding, NSSecureCoding{
    
    init(accessToken: String,
         tokenType: String,
         scope: String,
         createdAt: Double){
        
        self._accessToken = accessToken
        self._tokenType = tokenType
        self._scope = scope
        self._createdAt = createdAt
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
    
    public var createdAt : Date{
        get{ return Date(timeIntervalSince1970: _createdAt) }
    }
    
    // MARK: Private
    private var _accessToken : String
    private var _tokenType : String
    private var _scope : String
    private var _createdAt : Double
    
    // MARK: NSCoding
    required init(coder aDecoder: NSCoder) {
        self._accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String ?? ""
        self._tokenType = aDecoder.decodeObject(forKey: "tokenType") as? String ?? ""
        self._scope = aDecoder.decodeObject(forKey: "scope") as? String ?? ""
        self._createdAt = aDecoder.decodeObject(forKey: "createdAt") as? Double ?? 0
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self._accessToken, forKey: "accessToken")
        aCoder.encode(self._tokenType, forKey: "tokenType")
        aCoder.encode(self._scope, forKey: "scope")
        aCoder.encode(self._createdAt, forKey: "createdAt")
    }
    
    // MARK: NSSecureCoding
    static var supportsSecureCoding: Bool{ get{ return true } }
}

// MARK: UserDefaults Presistence.
extension AuthCredential{
    
    public static func localCredential() -> AuthCredential? {
        guard let credential = UserDefaults.standard.data(forKey: USER_DEFAULTS_KEY_AUTH_CREDENTIAL) else { return nil }
        
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: AuthCredential.self, from: credential)
        }
        catch{
            print("Unarchive AuthCredential failed.")
        }
        
        return nil
    }
    
    public static func storeCredential(for credential: AuthCredential?) {
        guard let credential = credential else{
            UserDefaults.standard.setValue(nil, forKey: "authCredential")
            return
        }
        
        do{
            let authCredentialData = try NSKeyedArchiver.archivedData(withRootObject: credential, requiringSecureCoding: true)
            UserDefaults.standard.setValue(authCredentialData, forKey: USER_DEFAULTS_KEY_AUTH_CREDENTIAL)
        }
        catch{
            print("Archive AuthCredential failed.")
        }
    }
}
