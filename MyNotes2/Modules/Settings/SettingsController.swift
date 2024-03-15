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
    var view: SettingsViewController?
    var model: SettingsModelProtocol?
    
    init(view: SettingsViewController? = nil, model: SettingsModelProtocol? = nil) {
        self.view = view
        self.model = model // Здесь исправлено на model
    }
}

extension SettingsController: SettingsControllerProtocol {
    
}

