//
//  HomeView.swift
//  MyNotes2
//
//  Created by adyl CEO on 14/03/2024.
//

import UIKit

protocol HomeViewProtocol {
    func successNotes(notes: [Note])
}

class HomeView: UIViewController {
    
    private var controller: HomeControllerProtocol?
    
    var notes: [Note] = []
    
    private var filteredNotes: [Note] = []
    
    private lazy var noteSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search".localized()
        //view.delegate = self
        view.searchTextField.addTarget(self, action: #selector(noteSearchBarEditingChanged), for: .editingChanged)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Notes".localized()
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }()
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(NoteCell.self, forCellWithReuseIdentifier: NoteCell.reuseId)
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("+", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .red
        view.layer.cornerRadius = 42 / 2
        view.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private var button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        setupConstraints()
        
        controller = HomeController(view: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        setupNavigationItem()
        if UserDefaults.standard.bool(forKey: "theme") == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
        controller?.onGetNotes()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Home".localized()
        let gearIcon = UIImage(systemName: "gear")
        let rightBarButtonItem = UIBarButtonItem(image: gearIcon?.withTintColor(.black), style: .plain, target: self, action: #selector(settingsButtonTapped))
        if UserDefaults.standard.bool(forKey: "theme") == true {
            navigationController?.navigationBar.tintColor = .white
        } else {
            navigationController?.navigationBar.tintColor = .black
        }
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func settingsButtonTapped() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addButtonTapped() {
        navigationController?.pushViewController(AddNoteView(), animated: true)
    }
    
    @objc func noteSearchBarEditingChanged() {
        if let text = noteSearchBar.text {
            
            if text.isEmpty {
                addButton.backgroundColor = .lightGray
                addButton.isEnabled = false
            } else {
                addButton.backgroundColor = .systemPink
                addButton.isEnabled = true
            }
        }
    }
    private func setupConstraints() {
        view.addSubview(noteSearchBar)
        noteSearchBar.translatesAutoresizingMaskIntoConstraints = false
        noteSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        noteSearchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        noteSearchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        noteSearchBar.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: noteSearchBar.bottomAnchor, constant: 22).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 39).isActive = true
        
        view.addSubview(notesCollectionView)
        notesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        notesCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30).isActive = true
        notesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        notesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        notesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -133).isActive = true
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 42).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
    }
    
    
}

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCell.reuseId, for: indexPath) as! NoteCell
        cell.setup(title: filteredNotes[indexPath.row].title ?? "")
        cell.index = indexPath.row
        cell.delegate = self
        print(indexPath)
        return cell
    }
}

extension HomeView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 12) / 2, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let noteView = AddNoteView()
        noteView.note = filteredNotes[indexPath.row]
        navigationController?.pushViewController(noteView, animated: true)
    }
}

extension HomeView: HomeViewProtocol {
    func successNotes(notes: [Note]) {
        self.notes = notes
        self.filteredNotes = notes
        notesCollectionView.reloadData()
    }
}

extension HomeView: NoteCellDelegate {
        func didRemoveButton(index: Int) {
            if index >= 0 && index < notes.count {
                notes.remove(at: index)
                filteredNotes = notes
                notesCollectionView.reloadData()
            }
        }
}

extension HomeView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        print(searchBar.text!)
        return true
    }
}
