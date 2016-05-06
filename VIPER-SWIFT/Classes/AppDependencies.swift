//
//  AppDependencies.swift
//  VIPER TODO
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class AppDependencies {
    var listWireframe: ListWireframe!    

    init() {
        let r = configureDependencies()
        listWireframe = r.resolve(ListWireframe.self)
    }
    
    func installRootViewControllerIntoWindow(window: UIWindow) {
        listWireframe.presentListInterfaceFromWindow(window)
    }

    func configureDependencies() -> ResolverType {
        let container = Container()
        container.register(DataStore.self) { _ in CoreDataStore() }
                 .inObjectScope(.Container)
        container.register(Clock.self) { _ in DeviceClock() }
                 .inObjectScope(.Container)
        container.register(RootWireframe.self) { _ in RootWireframe() }         

        // *** List Module *** //
        container.register(ListInteractor.self) { r in 
            return ListInteractor(dataStore: r.resolve(DataStore.self)!, 
                                  clock: r.resolve(Clock.self)!)
        }
        container.register(ListPresenter.self) { _ in ListPresenter() }
        container.register(ListWireframe.self) { r in
            let wireframe  = ListWireframe()
            let interactor = r.resolve(ListInteractor.self)!
            let presenter  = r.resolve(ListPresenter.self)!
            interactor.output = presenter
            presenter.listInteractor = interactor
            presenter.listWireframe  = wireframe
            wireframe.listPresenter  = presenter
            wireframe.rootWireframe  = r.resolve(RootWireframe.self)
            wireframe.addWireframe   = r.resolve(AddWireframe.self)
            return wireframe
        }

        // *** Add Module *** //
        container.register(AddInteractor.self) { r in 
            AddInteractor(dataStore: container.resolve(DataStore.self)!) 
        }
        container.register(AddPresenter.self) { _ in AddPresenter() }
        container.register(AddWireframe.self) { r in 
            let wireframe  = AddWireframe()
            let interactor = r.resolve(AddInteractor.self)!
            let presenter  = r.resolve(AddPresenter.self)!
            presenter.addWireframe  = wireframe
            presenter.addInteractor = interactor
            wireframe.addPresenter  = presenter
            return wireframe
        }

        return container
    }
}
