//
//  SettingsViewController.swift
//  MyNotes2
//
//  Created by adyl CEO on 14/03/2024.
//

import UIKit

class Test {
    init() {
        //создание объекта
    }
    
    deinit {
        //уничтожение объекта и освобождение памяти
    }
}

protocol SettingsViewProtocol {
    func successDelete()
    func failureDelete()
}

class SettingsViewController: UIViewController {
    
    var controller: SettingsControllerProtocol?
    
    private var settings: [Settings] = [Settings(leftImage: "globe", title: "Choose language".localized(), type: .withButton, description: "Русский".localized()),
                                        Settings(leftImage: "moon", title: "Dark theme".localized(), type: .withSwitch, description: ""),
                                        Settings(leftImage: "trash", title: "Clear data".localized(), type: .none, description: "")]
    
    private lazy var settingsTableView: UITableView = {
        let view = UITableView()
        view.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let languageSelectionViewController = LanguageSelectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = SettingsController(view: self)
        view.backgroundColor = .systemBackground
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "theme") == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Settings".localized()
    }
    
    private func setupData() {
        settings = [Settings(leftImage: "globe", title: "Choose language".localized(), type: .withButton, description: "Русский".localized()),
                    Settings(leftImage: "moon", title: "Dark theme".localized(), type: .withSwitch, description: ""),
                    Settings(leftImage: "trash", title: "Clear data".localized(), type: .none, description: "")]
        settingsTableView.reloadData()
    }
    
    private func setupConstraints() {
        view.addSubview(settingsTableView)
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            settingsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            settingsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
    }
    
    deinit {
        print("экран настроек пропал и уничтожился")
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseId, for: indexPath) as? SettingsCell
        cell?.setup(settings: settings[indexPath.row])
        cell?.delegate = self
        return cell!
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            presentLanguageSelection()
        } else if indexPath.row == 0 {
            let languageView = LanguageSelectView()
            languageView.delegate = self
            let multiplier = 0.25
            let customDetent = UISheetPresentationController.Detent.custom(resolver: { context in
                languageView.view.frame.height * multiplier
            })
            if let sheet = languageView.sheetPresentationController {
                
                sheet.detents = [customDetent, .medium()]
            }
            
            self.present(languageView, animated: true)
        }
    }
    
    
    //------------------
    private func presentLanguageSelection() {
//        present(languageSelectionViewController, animated: true, completion: nil)
        
        let languageSelectionViewController = languageSelectionViewController
        
        let sheetPresentationController = languageSelectionViewController.presentationController as? UISheetPresentationController
        
        sheetPresentationController?.detents = [.medium(), .large()]
        sheetPresentationController?.prefersGrabberVisible = true
        sheetPresentationController?.prefersScrollingExpandsWhenScrolledToEdge = true
        
        present(languageSelectionViewController, animated: true, completion: nil)
    }
}

//----------------------

extension SettingsViewController: SettingsViewProtocol {
    func successDelete() {
        navigationController?.popViewController(animated: true)
    }
    
    func failureDelete() {
        let alert = UIAlertController(title: "Ошибка", message: "Не удалось удалить заметку!", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(acceptAction)
        present(alert, animated: true)
    }
}

extension SettingsViewController: SettingsCellDelegate {
    func didSwitchOn(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: "theme")
        if isOn {
            view?.overrideUserInterfaceStyle = .dark
        } else {
            view?.overrideUserInterfaceStyle = .light
        }
    }
}

extension SettingsViewController: LanguageSelectViewDelegate {
    func didLanguageSelect(LanguageType: LanguageType) {
        setupNavigationItem()
        //setupData()
        settingsTableView.reloadData()
    }
}

