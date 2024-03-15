//
//  SettingsModel.swift
//  MyNotes2
//
//  Created by adyl CEO on 14/03/2024.
//

import Foundation

protocol SettingsModelProtocol {
    
}

class SettingsModel {
    weak var controller: SettingsControllerProtocol?
    
    init(controller: SettingsControllerProtocol) {
        self.controller = controller
    }
}

extension SettingsModel: SettingsModelProtocol {
    
}
