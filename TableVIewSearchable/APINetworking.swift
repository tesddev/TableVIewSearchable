//
//  APINetworking.swift
//  TableVIewSearchable
//
//  Created by GIGL iOS on 02/06/2022.
//

import Foundation

class APINetworking: NSObject {
    
    static let shared = APINetworking()
    
    func getInternationalShipmentInstructionNotAlamoFire(completionHandler:@escaping ((_ theResponseValue: CategoryModel?,_ errorMessage:String?) -> Void)) {
        
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYW1laWQiOiJkNmY2MmZlOS0yNTQ5LTQ1ZjEtODkxMC0wNTE0MGMxZTgzMTMiLCJ1bmlxdWVfbmFtZSI6InN1bmRheWRhdmlkOTg5QGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vYWNjZXNzY29udHJvbHNlcnZpY2UvMjAxMC8wNy9jbGFpbXMvaWRlbnRpdHlwcm92aWRlciI6IkFTUC5ORVQgSWRlbnRpdHkiLCJBc3BOZXQuSWRlbnRpdHkuU2VjdXJpdHlTdGFtcCI6IjI4ODk2NDVhLTU1ODQtNGJiOC1hYzI2LWQ0ZjE5ZDczNmRmZCIsImlzcyI6Imh0dHBzOi8vYWdpbGl0eXN5c3RlbWFwaWRldm0uYXp1cmV3ZWJzaXRlcy5uZXQvIiwiYXVkIjoiNDE0ZTE5MjdhMzg4NGY2OGFiYzc5ZjcyODM4MzdmZDEiLCJleHAiOjE2NTQ1MjYxMDMsIm5iZiI6MTY1NDA5NDEwM30.Y7IA4rxVMhN0Kl1sW1zr41maZZTxIkD9bbWulyp_zso"
        ]
//        let theValueNow = getInternationalInstruction.replacingOccurrences(of: "{value}", with: theCountryCode)
                
        let countryCode = "207"
        let baseUrl = "https://agilitysystemapidevm.azurewebsites.net/api/portal/inbundcategory/"
        
        let request = NSMutableURLRequest(url: NSURL(string: baseUrl + countryCode)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 90.0)
        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data, error == nil else {
                
                return
            }
            do{
                let results = try JSONDecoder().decode(CategoryModel.self, from: data)
                completionHandler(results, nil)
            } catch {
                print("unable to decode")
                completionHandler(nil, "error")
            }
        })
        
        dataTask.resume()
    }
}
