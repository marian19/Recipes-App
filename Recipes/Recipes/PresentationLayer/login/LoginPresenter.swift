//  RentBike
//
//  Created by Marian on 10/28/17.
//  Copyright © 2017 Marian. All rights reserved.
//

import Foundation

class LoginPresenter: BasePresenter, LoginPresenterProtocol{
    
    weak var view: LoginViewProtocol?
    
    required init(view: LoginViewProtocol) {
        self.view = view
    }
    
    // MARK: - LoginPresenterProtocol implementation
    
    func login(email: String, password: String) {
        
        if (email.isEmail) {
            if password.isValidPassword {
                let requestValue = UserRequestValues(email: email, password: password)
                UserDataSource().loginUser(requestValue: requestValue, completion: {[weak self] token in
                    
                    self?.view?.success()
                })
                
            }else{
                view?.showErrorMsg(msg: NSLocalizedString("InvalidPassword", comment: ""))
            }
        }else{
            view?.showErrorMsg(msg: NSLocalizedString("InvalidEmail", comment: ""))
        }
        
    }
}

struct UserRequestValues: RequestValues{
    let email: String
    let password: String
}
