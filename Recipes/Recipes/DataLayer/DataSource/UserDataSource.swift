//
//  UserDataSource.swift
//  Recipes
//
//  Created by Marian on 11/22/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation
struct UserDataSource {
    
    func loginUser(requestValue: RequestValues, completion: @escaping(_ response: String) -> Void) {
        // save user email to userDefaults
        let userRequestValues = (requestValue as! UserRequestValues)
        UserDefaults.standard.set(userRequestValues.email, forKey: Constants.UserData.email)
        completion("success")
    }
}


