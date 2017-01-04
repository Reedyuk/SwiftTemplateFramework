//
//  QuestionServices.swift
//  SimpleNetworkExample
//
//  Created by Andrew Reed on 04/01/2017.
//  Copyright © 2017 Andrew Reed. All rights reserved.
//

import Foundation
import SwiftTemplateFramework

class QuestionService: NetworkService {

    public static func getQuestions(onSuccess: @escaping (_ data: [String: Any]?) -> (),
                                    onFailure: @escaping (_ error: NetworkRequestError) -> ()) {
        NetworkRequestAdapter.performRequest(path: "/questions",
                                             onSuccess: onSuccess,
                                             onFailure: onFailure)
    }
}
