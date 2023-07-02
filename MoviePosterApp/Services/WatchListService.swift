//
//  WatchListService.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 30.06.2023.
//

import CoreData

// MARK: - WatchListService
final class WatchListService {
    private lazy var context = persistentContainer.viewContext
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MoviePosterApp")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func getFilms() -> [FilmInfo] {
        let fetchRequest: NSFetchRequest<FilmEntity> = FilmEntity.fetchRequest()
        do {
            let savedFilms = try context.fetch(fetchRequest)
            return savedFilms.map { convertEntityToFilmInfo($0) }
        } catch {
            print("Failed to fetch films: \(error)")
            return []
        }
    }
    
    func getFilm(with filmId: Int) -> FilmInfo? {
        let fetchRequest: NSFetchRequest<FilmEntity> = FilmEntity.fetchRequest()
        do {
            if let savedFilm = try context.fetch(fetchRequest).first(where: { $0.id == filmId }) {
                return convertEntityToFilmInfo(savedFilm)
            }
            return nil
        } catch {
            print("Failed to fetch film: \(error)")
            return nil
        }
    }
    
    func saveFilm(filmInfo: FilmInfo) {
        guard !filmIsAdded(filmId: filmInfo.kinopoiskId) else {
            return
        }
        
        let savedFilm = FilmEntity(context: context)
        savedFilm.id = Int64(filmInfo.kinopoiskId)
        savedFilm.nameRu = filmInfo.nameRu
        savedFilm.coverUrl = filmInfo.coverUrl
        savedFilm.year = Int64(filmInfo.year ?? -1)
        savedFilm.filmLength = Int64(filmInfo.filmLength ?? -1)
        savedFilm.filmDescription = filmInfo.description
        savedFilm.ratingImdb = filmInfo.ratingImdb ?? -1
        savedFilm.posterUrl = filmInfo.posterUrl
        savedFilm.posterUrlPreview = filmInfo.posterUrlPreview
        savedFilm.isTicketsAvailable = filmInfo.isTicketsAvailable
        
        do {
            try context.save()
        } catch {
            print("Failed to save film: \(error)")
        }
    }
    
    func deleteFilm(filmId: Int) {
        let fetchRequest: NSFetchRequest<FilmEntity> = FilmEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", filmId)
        do {
            let filmEntities = try context.fetch(fetchRequest)
            for filmEntity in filmEntities {
                context.delete(filmEntity)
            }
            try context.save()
        } catch {
            print("Failed to delete film: \(error)")
        }
    }
    
    func filmIsAdded(filmId: Int) -> Bool {
        let fetchRequest: NSFetchRequest<FilmEntity> = FilmEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", filmId)
        do {
            let savedFilm = try context.fetch(fetchRequest)
            return savedFilm.first != nil
        } catch {
            print("Failed to check if film is added: \(error)")
            return false
        }
    }
    
    private func convertEntityToFilmInfo(_ savedFilm: FilmEntity) -> FilmInfo {
        return FilmInfo(
            kinopoiskId: Int(savedFilm.id),
            nameRu: savedFilm.nameRu,
            coverUrl: savedFilm.coverUrl,
            year: Int(savedFilm.year) != -1 ? Int(savedFilm.year) : nil,
            filmLength: Int(savedFilm.filmLength) != -1 ? Int(savedFilm.filmLength) : nil,
            description: savedFilm.filmDescription,
            ratingImdb: Int(savedFilm.ratingImdb) != -1 ? savedFilm.ratingImdb : nil,
            posterUrl: savedFilm.posterUrl,
            posterUrlPreview: savedFilm.posterUrlPreview,
            isTicketsAvailable: savedFilm.isTicketsAvailable
        )
    }
}
