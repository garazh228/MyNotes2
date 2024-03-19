//
//  LanguageSelectView.swift
//  MyNotes2
//
//  Created by adyl CEO on 19/03/2024.
//

import UIKit

//class LanguageSelectView: UIViewController {
//
//    var languages: [String] = ["Русский", "English", "Кыргызча"]
//    var languageSelectionHandler: ((String) -> Void)?
//
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 5
//
//
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = .white
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        return collectionView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .clear
//        setupCollectionView()
//    }
//
//    private func setupCollectionView() {
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(LanguageCell.self, forCellWithReuseIdentifier: "LanguageCell")
//
//        view.addSubview(collectionView)
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
//    }
//}
//
//extension LanguageSelectView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return languages.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
//        cell.textLabel.text = languages[indexPath.item]
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.bounds.width - 20, height: 50)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        let selectedLanguage = languages[indexPath.item]
//        languageSelectionHandler?(selectedLanguage)
//        dismiss(animated: true, completion: nil) // Для закрытия листа после выбора языка
//    }
//}

class LanguageSelectView: UIViewController {
    
    let languages = [("Русский", "rus"), ("Английский", "eng"), ("Кыргызский", "kgz")]
    
    private lazy var languageStackView: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .fill
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        let languageTableView = UITableView(frame: view.bounds, style: .plain)
        languageTableView.dataSource = self
        languageTableView.delegate = self
        
        languageTableView.register(LanguageCell.self, forCellReuseIdentifier: "LanguageCell")
        
        let stackView = UIStackView(arrangedSubviews: [languageTableView])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension LanguageSelectView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell", for: indexPath) as! LanguageCell
        
        switch indexPath.row {
        case 0:
            cell.flagImageView.image = UIImage(named: "rus")
            cell.languageLabel.text = "Русский"
        case 1:
            cell.flagImageView.image = UIImage(named: "eng")
            cell.languageLabel.text = "Английский"
        case 2:
            cell.flagImageView.image = UIImage(named: "kgz")
            cell.languageLabel.text = "Кыргызский"
        default:
            break
        }
        return cell
    }
}
