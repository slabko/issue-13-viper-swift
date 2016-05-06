//
//  AddPresenter.swift
//  VIPER TODO
//
//  Created by Conrad Stoll on 6/4/14.
//  Copyright (c) 2014 Mutual Mobile. All rights reserved.
//

import Foundation

class AddPresenter : NSObject, AddModuleInterface {
    var addInteractor : AddInteractor?
    var addWireframe : AddWireframe?
    
    func cancelAddAction() {
        addWireframe?.dismissAddInterface()
    }
    
    func saveAddActionWithName(name: NSString, dueDate: NSDate) {
        addInteractor?.saveNewEntryWithName(name, dueDate: dueDate);
        addWireframe?.dismissAddInterface()
    }
    
    func configureUserInterfaceForPresentation(addViewUserInterface: AddViewInterface) {
        addViewUserInterface.setMinimumDueDate(NSDate())
    }
}
