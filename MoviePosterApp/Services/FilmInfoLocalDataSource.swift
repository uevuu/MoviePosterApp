//
//  FilmInfoLocalDataSource.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 02.07.2023.
//

import Foundation

final class FilmInfoLocalDataSource {
    private var films: Set<FilmInfo> = Set()
    
    func cachedFilm(_ filmInfo: FilmInfo) {
        films.insert(filmInfo)
    }
    
    func getFilm(with filmId: Int) -> FilmInfo? {
        return films.first(where: { $0.kinopoiskId == filmId })
    }
}