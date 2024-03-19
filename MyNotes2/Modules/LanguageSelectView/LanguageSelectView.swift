//
//  LanguageSelectView.swift
//  MyNotes2
//
//  Created by adyl CEO on 19/03/2024.
//

import UIKit

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
