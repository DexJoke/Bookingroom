//
//  APIService.swift
//  livestream
//
//  Created by DaoVanSon on 3/10/20.
//  Copyright © 2020 nguyen tung anh. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol APIDatasource {
    func method() -> HTTPMethod
    func api() -> String
    func parameters() -> Parameters
    func paramEncoding() -> ParameterEncoding
    func isSecret() -> Bool
}

typealias onRequestSuccess = (_ apiResult: JSON) -> Void
typealias onRequestError = (_ errorCode: Int?, _ errorMessage: String?) -> Void

class BaseAPI {
    
    var apiSource: APIDatasource {
        return self as! APIDatasource
    }
    
    var onSuccess: onRequestSuccess!
    var onError: onRequestError!
    
    private func getBasicHeaders(withAuth: Bool) -> HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
    
    private func addCommonJson(_ json : [String:Any],_ isSecret: Bool)  -> [String:Any]? {
        var jsonArray = json
        jsonArray["os"] = "ios"
        jsonArray["osver"] = UIDevice.current.systemVersion
        jsonArray["device_name"] = DeviceUtil.deviceType
        jsonArray["ver"] = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String?
        jsonArray["zipver"] = "1.0.0.72"

        if isSecret {
            jsonArray["sign"] = ""
        }
        
        return jsonArray
    }
    
    func request(_ onSuccess: @escaping onRequestSuccess, onError: @escaping onRequestError) {
        self.onSuccess = onSuccess
        self.onError = onError
        let url = apiSource.api()
        
        let params = addCommonJson(apiSource.parameters(), apiSource.isSecret())
        let method = apiSource.method()
        let paramEncoding = apiSource.paramEncoding()
        let header = getBasicHeaders(withAuth: false)
        
        AF.request(url, method: method, parameters: params, encoding: paramEncoding , headers: header).responseJSON { (response) in
            self.handleResponse(response)
        }
    }
    
    private func handleResponse(_ response: DataResponse<Any, AFError>) {
        switch response.result {
        case .success:
            handleSuccess(response)
            break
        case .failure (let error):
            handleError(error)
            break
        }
    }
    
    private func handleSuccess(_ response: DataResponse<Any, AFError>) {
        guard let json = try? JSON(data: response.data!) else {
            self.onError(9999,"Parse Failed")
            return
        }
        
        onSuccess(json)
    }
    
    private func handleError(_ error: Error) {
        onError(error._code, error.localizedDescription)
    }
    
    static func getTimeStamp() -> String? {
        //タイムスタンプ取得
        let today = Date();
        let sec = today.timeIntervalSince1970
        let millisec = UInt64(sec * 1000)
        return String(millisec)
    }
}

