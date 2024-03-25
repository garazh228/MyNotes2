//
//  LanguageSelectView.swift
//  MyNotes2
//
//  Created by adyl CEO on 19/03/2024.
//

import UIKit
import SnapKit

protocol LanguageSelectViewDelegate: AnyObject {
    func didLanguageSelect(LanguageType: LanguageType)
}

class LanguageSelectView: UIViewController {
    
    weak var delegate: LanguageSelectViewDelegate?

    private var languages: [Language] = [Language(image: "kgz", title: "Кыргызсча"),
                                        Language(image: "rus", title: "Русский"),
                                        Language(image: "eng", title: "English  ")]

    private lazy var languagesTableView: UITableView = {
       let view = UITableView()
        view.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseId)
        view.delegate = self
        view.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(languagesTableView)
        languagesTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension LanguageSelectView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count  
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.reuseId, for: indexPath) as! LanguageCell
        cell.setup(language: languages[indexPath.row])
        return cell
    }
}

extension LanguageSelectView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            AppLanguageManager.shared.setAppLanguage(language: .kg)
            delegate?.didLanguageSelect(LanguageType: .kg)
        case 1:
            AppLanguageManager.shared.setAppLanguage(language: .ru)
            delegate?.didLanguageSelect(LanguageType: .ru)
        case 2:
            AppLanguageManager.shared.setAppLanguage(language: .en)
            delegate?.didLanguageSelect(LanguageType: .en)
        default:
            ()
        }
        dismiss(animated: true)
    }
}


