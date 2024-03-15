//
//  HomeModel.swift
//  MyNotes2
//
//  Created by adyl CEO on 14/03/2024.
//

protocol HomeModelProtocol {
    func getNotes()
}

class HomeModel: HomeModelProtocol {
   
    private let controller: HomeControllerProtocol?
    
    private let coreDataService = CoreDataService.shared
    
    init(controller: HomeControllerProtocol) {
        self.controller = controller
    }
    
    private var notes: [Note] = []
    
    func getNotes() {
        notes = coreDataService.fetchNotes()
        controller?.onSuccessNotes(notes: notes)
    }
    
    
}

