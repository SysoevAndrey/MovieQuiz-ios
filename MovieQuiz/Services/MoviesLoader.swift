//
//  MoviesLoader.swift
//  MovieQuiz
//
//  Created by Andrey Sysoev on 13.10.2022.
//

import Foundation

protocol MoviesLoading {
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void)
}

struct MoviesLoader: MoviesLoading {
    // MARK: - NetworkClient
    private let networkClient = NetworkClient()
    
    // MARK: - URL
    private var mostPopularMoviesUrl: URL {
        guard let url = URL(string: "https://imdb-api.com/en/API/Top250Movies/k_orpdvnde") else {
            preconditionFailure("Unable to construct mostPopularMoviesUrl")
        }
        
        return url
    }
    
    private enum APIError: Error {
        case errorMessage(String)
    }
    
    func loadMovies(handler: @escaping (Result<MostPopularMovies, Error>) -> Void) {
        networkClient.fetch(url: mostPopularMoviesUrl) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONDecoder().decode(MostPopularMovies.self, from: data)
                    
                    if json.errorMessage.isEmpty && !json.items.isEmpty {
                        handler(.success(json))
                    } else {
                        handler(.failure(APIError.errorMessage(json.errorMessage)))
                    }
                } catch {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }

}
