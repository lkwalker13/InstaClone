//
//  User.swift
//  InstagramClone
//
//  Created by Евгений Лянкэ on 04.05.2022.
//

import Foundation

class User {
    var email:String
    var fullName:String
    var userName:String
    var password:String
    
    init(email:String,fullname:String,userName:String,password:String) {
        self.email = email
        self.fullName = fullname
        self.userName = userName
        self.password = password
    }
   
    
}
