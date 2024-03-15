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
    
}

class SettingsViewController: UIViewController {
    
    private var settings: [Settings] = [Settings(leftImage: "globe", title: "Язык", type: .withButton, description: "Русский"),
                                        Settings(leftImage: "moon", title: "Темная тема", type: .withSwitch, description: ""),
                                        Settings(leftImage: "trash", title: "Очистить данные", type: .none, description: "")]
    
    private lazy var settingsTableView: UITableView = {
       let view = UITableView()
        view.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var controller: SettingsControllerProtocol?
    
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
}

extension SettingsViewController: SettingsViewProtocol {
    
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
