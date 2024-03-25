//
//  SettingsController.swift
//  MyNotes2
//
//  Created by adyl CEO on 14/03/2024.
//

import Foundation

protocol SettingsControllerProtocol: AnyObject {
    
}

class SettingsController {
    var view: SettingsViewProtocol
    var model: SettingsModelProtocol?
    
    init(view: SettingsViewProtocol) {
        self.view = view
        self.model = SettingsModel(controller: self)
    }
}

extension SettingsController: SettingsControllerProtocol {
    
}

