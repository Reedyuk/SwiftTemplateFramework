//
//  UserService.swift
//
//
//  Created by Andrew Reed on 13/06/2016.
//  Copyright © 2016. All rights reserved.
//

/// Class used to handle network related requests for user.
public class UserService: NetworkService {

    override public class func serviceType() -> ApiService {
        return .auth
    }

    /// Method used to login user.
    /// - Parameter username: The username of the user
    /// - Parameter password: The password for the account
    /// - Parameter onSuccess: The code block to run when successful request
    /// - Parameter onFailure: The code block to run when failed request.
    public static func loginUser(_ username: String,
                          password: String,
                          onSuccess: @escaping (_ data: [String: Any]?) -> (),
                          onFailure: @escaping (_ error: NetworkRequestError) -> ()) {
        NetworkRequestAdapter.performRequest(path: Urls.AuthService.loginUser,
                                             requestType: .post,
                                             service: .auth,
                                             payload: ["email": username, "password": password],
                                             onSuccess: onSuccess,
                                             onFailure: onFailure)
    }
}
