//
//  ServiceLocator.swift
//  MoviePosterApp
//
//  Created by Nikita Marin on 21.04.2023.
//

import Swinject

protocol ServiceLocatorProtocol {
    func getResolver() -> Resolver
}

final class ServiceLocator: ServiceLocatorProtocol {
    private var container: Container
    private var assembler: Assembler
    
    init() {
        self.container = Container()
        self.assembler = Assembler(
            [
                NetworkAssembly(),
                CoreDataAssembly(),
                LocalDataSourceAssembly()
            ],
            container: container
        )
    }
    
    func getResolver() -> Resolver {
        return assembler.resolver
    }
}
