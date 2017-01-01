//
//  NetworkService.swift
//
//
//  Created by Andrew Reed on 24/03/2016.
//  Copyright © 2016 . All rights reserved.
//

import Foundation
import UIKit

/// Root class used to inherit network related operations
open class NetworkService: NSObject {

    public class func serviceType() -> ApiService {
        return .all
    }
}
