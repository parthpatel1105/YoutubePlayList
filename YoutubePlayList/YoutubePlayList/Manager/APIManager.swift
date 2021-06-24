//
//  APIManager.swift
//  YoutubePlayList
//
//  Created by Parth Patel on 02/10/20.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidRequest    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
}

enum APIEndpoint{
    case getYoutubeChannel
    case getYoutubePlayList
    case getYoutubeItemList
    case getYoutubeVideoInfo
}

extension APIEndpoint: API{

    var baseURL: URL {
        //URL(string: Localize(.baseURL) + Localize(.youtubeAPIKey))!
        //URL(string: Localize(.baseURL))!
        
        switch self {
        case .getYoutubeChannel:
          return  URL(string: Localize(.baseURL) + Localize(.channelPath) + Localize(.youtubeAPIKey))!
        case .getYoutubePlayList:
            let strPath = "\(Localize(.baseURL))\(Localize(.playListPath))&channelId=\(UserProfileData.youtubeChannelId)&key=\(Localize(.youtubeAPIKey))"
            return  URL(string: strPath)!
          //return  URL(string: Localize(.baseURL) + Localize(.playListPath) + Localize(.youtubeAPIKey))!
        case .getYoutubeItemList:
            let strPath = "\(Localize(.baseURL))\(Localize(.itemListPath))&playlistId=\(UserProfileData.selectedPlayListId)&key=\(Localize(.youtubeAPIKey))"
            return  URL(string: strPath)!
        case .getYoutubeVideoInfo:
            let strPath = "\(Localize(.baseURL))\(Localize(.videoInfoPath))&id=\( APIManager.shared.videoId ?? Localize(.empty))&key=\(Localize(.youtubeAPIKey))"
            return  URL(string: strPath)!

        }
    }
    
    // End point path
    var path: String {
        Localize(.empty)
//        switch self {
//        case .getYoutubePlayList:
//            return Localize(.internetConnectionIssue)
//        case .getYoutubeChannel:
//            return Localize(.internetConnectionIssue)
//        case .getYoutubeItemList:
//            return Localize(.internetConnectionIssue)
//        }
        
    }
    
    // HTTP method of endpoint
    var method: Method {
    
        switch self {
        case .getYoutubeChannel, .getYoutubePlayList, .getYoutubeItemList, .getYoutubeVideoInfo:
            return .get
        }
        
    }
    
    var sampleData: Data {
        // for mocking requests
        Data()
    }
    
    var task: Task {
        switch self {
        
        case .getYoutubeChannel, .getYoutubePlayList, .getYoutubeItemList, .getYoutubeVideoInfo:
            return .requestPlain
        }
    }
    
    // Headers for request
    var headers: [String : String]? {
    
        switch self {
        case .getYoutubeChannel, .getYoutubePlayList, .getYoutubeItemList, .getYoutubeVideoInfo:
            return ["Authorization": "Bearer \(UserProfileData.youtubeAccessToken)", "Accept": "application/json"]
        }
        
    }
    
}

class APIManager {
    static let shared = APIManager()
    var videoId: String!
    
    
    func youtubePlayListAPI<T>(request:URLRequest?, completed: @escaping (Result<T, ErrorMessage>) -> Void) {
        guard let request = request else {return}
        
        NetworkLogger.log(request: request)

        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let task = session.dataTask(with: request) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let responseDictionary = response as? T {
                    completed(.success(responseDictionary))
                }
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func youtubeAPIFetch<T: Codable>(request:URLRequest?, completed: @escaping (Result<T, ErrorMessage>) -> Void) {
        guard let request = request else {return}
        
        NetworkLogger.log(request: request)

        let session = URLSession(configuration: URLSessionConfiguration.ephemeral)
        let task = session.dataTask(with: request) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(T.self, from: data)
                //sprint(responseObject)
                completed(.success(responseObject))
            } catch {
                print("decode error = \(error)")
                completed(.failure(.invalidData))
            }

        }
        task.resume()
    }
    
    func loadMedium() {
        let url = URL(string: "https://www.medium.com")!
        let request = URLRequest(url: url)
        URLSession.shared.loadData(using: request) { (data, response, error) in
        //check for errors
        if let error = error {
            print("Error loading data! \n\(error)")
        return
        }
        if let response = response as? HTTPURLResponse {
            let statusCode = response.statusCode
            //check to make sure medium.com responded to our request with a success code
            if statusCode != 200 {
                print("\(url.absoluteString) returned bad status code: \(statusCode)!")
                } else {
                    print("Loading Medium.com successful!")
                    //print the page's html
                    guard let data = data,
                        let medium = String(data: data, encoding: .utf8)
                    else { return }
                    print(medium)
                }
            }
        }
    }

}


protocol NetworkLoader {
    func loadData(using request: URLRequest, with completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkLoader {
    
    // call dataTask and resume, passing the completionHandler
    func loadData(using request: URLRequest, with completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.dataTask(with: request, completionHandler: completion).resume()
    }
}

//let formatter = DateFormatter()
//formatter.locale = Locale(identifier: "en_US_POSIX")
//formatter.timeZone = TimeZone(secondsFromGMT: 0)
//formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
