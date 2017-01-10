//
//  NetworkRequestAdapter.swift
//
//
//  Created by Andrew Reed on 15/12/2016.
//  Copyright © 2016. All rights reserved.
//

import UIKit
import Siesta

public protocol NetworkRequestAdapterDelegate {
    func setupTransformers()
    func resourceChangedForGetUser()
    func userLoggedIn()
    func logNetworkRequest(url: String, responseCode: Int?)
}

public class NetworkRequestAdapter: ResourceObserver {

    public static let sharedInstance = NetworkRequestAdapter()   //singleton

    /// The web services we use for network requests.
    var webServices = [ApiService: Service]()

    public var networkRequestAdapterDelegate: NetworkRequestAdapterDelegate?

    private static func webService(service: ApiService) -> Service {
        return NetworkRequestAdapter.sharedInstance.webServices[service]!
    }

    public func initialise() {
        //#if DEBUG
        LogCategory.enabled = LogCategory.all
        //#endif
        LoggingService.sharedInstance.initialise()
        setupTransformers()
    }

    public func createNewInstancesOfServices(networkRequestAdapterDelegate: NetworkRequestAdapterDelegate?) {
        self.networkRequestAdapterDelegate = networkRequestAdapterDelegate
        for webService in webServices {
            webService.value.wipeResources()
            webService.value.invalidateConfiguration()
        }
        webServices.removeAll()
        Urls.resetConfig()
        let authService = createWebService(baseUrl: Urls.baseUrl(.auth))
        authService.relativeResource(Urls.AuthService.loginUser).addObserver(self, owner: self)
            webServices = [.auth: authService,
                       .all: createWebService(baseUrl: Urls.baseUrl(.all))]
        NetworkRequestAdapter.sharedInstance.initialise()
    }

    private func createWebService(baseUrl: String) -> Service {
        let service = Service(baseURL: baseUrl)
        configureWebService(service: service)
        return service
    }

    private func configureWebService(service: Service) {
        service.configure {
            if let shortVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
                $0.headers["APP-VERSION"] = shortVersion
            }
            $0.useNetworkActivityIndicator()
            $0.listenToRequests()
        }
    }

    public func setupTransformer<I, O>(_ path: String,
                                  service: ApiService = .all,
                                  requestMethods: [RequestMethod]? = nil,
                                  contentTransform: @escaping ResponseContentTransformer<I, O>.Processor) {
        let webService = NetworkRequestAdapter.webService(service: service)
        webService.configureTransformer(path, requestMethods: requestMethods, contentTransform: contentTransform)
    }

    private func setupTransformers() {
        networkRequestAdapterDelegate?.setupTransformers()
    }

    public static func performRequest(path: String,
                               requestType: RequestType = .get,
                               service: ApiService = .all,
                               payload: [String: Any]? = nil,
                               onSuccess: ((_ data: [String: Any]?) -> ())? = nil,
                               onFailure: ((_ error: NetworkRequestError) -> ())? = nil) {
        let webService = NetworkRequestAdapter.webService(service: service)
        let resource = webService.relativeResource(path)
        var request: Request
        if let forcedPayload = payload {
            request = resource.request(requestType.siestaMethodForType(), json: forcedPayload)
        } else {
            request = resource.request(requestType.siestaMethodForType())
        }
        let completedRequest = resource.load(using: request)
        completedRequest.onSuccess { (entity) in
                if let block = onSuccess {
                    if entity.jsonArray.count > 0 {
                        block(["path": entity.jsonArray])
                    } else {
                        block(entity.jsonDict)
                    }
                }
            }.onNotModified {
                if let block = onSuccess {
                    block(resource.latestData?.jsonDict)
                }
            }.onFailure { (error) in
                if let block = onFailure {
                    block(NetworkRequestError(siestaError: error))
                }
        }
    }

    public func resourceChanged(_ resource: Resource, event: ResourceEvent) {
        //capture and deal with requests.
        switch event {
        case .error:
            if let error = resource.latestError {
                networkRequestAdapterDelegate?.logNetworkRequest(url: resource.url.absoluteString, responseCode: error.httpStatusCode)
            }
            break
        case .newData, .notModified:
            break
        default: break
        }
    }
}

public class NetworkRequestError {
    public var httpStatusCode: Int?
    public var message: Error?
    public var jsonDict: [String: Any]

    init(siestaError: RequestError) {
        httpStatusCode = siestaError.httpStatusCode
        message = siestaError.cause
        jsonDict = siestaError.jsonDict
    }
}

public enum RequestType: String {
    /// GET
    case get

    /// POST. Just POST.
    case post

    case put

    case patch

    case delete

    func siestaMethodForType() -> RequestMethod {
        switch self {
            case .get:
                return .get
            case .post:
                return .post
            case .put:
                return .put
            case .patch:
                return .patch
            case .delete:
                return .delete
        }
    }
}

extension Service {
    func relativeResource(_ path: String, useParams: Bool = false) -> Resource {
        return resource("/").relative("."+path)
    }
}

extension Configuration {
    public mutating func listenToRequests() {
        decorateRequests {
            resource, request in
            request.onSuccess { _ in
                if !resource.url.absoluteString.contains(Urls.AuthService.loginUser) {
                    NetworkRequestAdapter.sharedInstance.resourceChanged(resource, event: .newData(.network))
                }
            }
            request.onFailure { _ in
                NetworkRequestAdapter.sharedInstance.resourceChanged(resource, event: .error)
            }
            return request
        }
    }
}
