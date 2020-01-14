//
//  CountryAPIClient.swift
//  CollectionView-Lab
//
//  Created by casandra grullon on 1/14/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import Foundation
import NetworkHelper

struct CountryAPICountry {
    static func getCountry(for search: String, completion: @escaping (Result<[Country], AppError>) -> () ) {
        
        let searchQuery = search.lowercased().addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "china"
        
        let endpointURL = "https://restcountries.eu/rest/v2/name/\(searchQuery)"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let countries = try JSONDecoder().decode([Country].self, from: data)
                    completion(.success(countries))
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
