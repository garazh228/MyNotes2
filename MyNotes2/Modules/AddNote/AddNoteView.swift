//
//  AddNoteView.swift
//  MyNotes2
//
//  Created by adyl CEO on 15/03/2024.
//

import UIKit

class AddNoteView: UIViewController {
    
    private let coreDataService = CoreDataService.shared
    
     var note: Note?
    
    private lazy var noteTextView: UITextView = {
        let view = UITextView()
        view.font = UIFont.systemFont(ofSize: 16)
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(cgColor: CGColor(srgbRed: 238/255, green: 238/255, blue: 239/255, alpha: 1))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()

    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Save".localized(), for: .normal)
        view.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .gray
        view.layer.cornerRadius = 20
        view.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.isEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupConstraints()
        
        guard let note = note else {return}
        noteTextView.text = note.title
    }
    
    private func setupConstraints() {
        view.addSubview(noteTextView)
        NSLayoutConstraint.activate([
            noteTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            noteTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        view.addSubview(saveButton)
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 40),
            saveButton.topAnchor.constraint(equalTo: noteTextView.bottomAnchor, constant: 20),
            saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
    }
    
    @objc func saveButtonTapped() {
        let id = UUID().uuidString
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
        
        
        coreDataService.addNote(id: id, title: noteTextView.text ?? "", description: "", date: dateString)
        
        navigationController?.popViewController(animated: true)
    }
}

extension AddNoteView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        saveButton.isEnabled = !textView.text.isEmpty
        saveButton.backgroundColor = textView.text.isEmpty ? .gray : .systemPink
    }
}
