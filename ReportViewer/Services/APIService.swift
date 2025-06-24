//
//  APIService.swift
//  ReportViewer
//
//  Created by admin on 23/06/25.
//

import Foundation


class APIService: APIServiceProtocol {
    static let shared = APIService()
    private init() {}

    func fetchObjects(completion: @escaping ([APIObject]) -> Void) {
        guard let url = URL(string: "https://api.restful-api.dev/objects") else {
            completion([])
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("error:", error?.localizedDescription ?? "Unknown")
                completion([])
                return
            }

            do {
                let objects = try JSONDecoder().decode([APIObject].self, from: data)
                completion(objects)
            } catch {
                print("error:", error)
                completion([])
            }
        }.resume()
    }
}

