//
//  SettingsCell.swift
//  MyNotes2
//
//  Created by adyl CEO on 14/03/2024.
//

import UIKit

enum SettingsCellType {
    case none
    case withSwitch
    case withButton
}

struct Settings {
    var leftImage: String
    var title: String
    var type: SettingsCellType
    var description: String
}

protocol SettingsCellDelegate: AnyObject {
    func didSwitchOn(isOn: Bool)
}

class SettingsCell: UITableViewCell {
    
    static var reuseId = "settings_cell"
    
    weak var delegate: SettingsCellDelegate?
    
    private lazy var leftImageView: UIImageView = {
       let view  = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
       let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var rightButton: UIButton = {
        let view = UIButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var switchView: UISwitch = {
        let view = UISwitch()
        view.isOn = UserDefaults.standard.bool(forKey: "theme")
        view.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func switchValueChanged() {
        delegate?.didSwitchOn(isOn: switchView.isOn)
    }
    
    func setup(settings: Settings) {
        leftImageView.image = UIImage(systemName: settings.leftImage)
        titleLabel.text = settings.title
        switch settings.type {
        case .none:
            rightButton.isHidden = true
            switchView.isHidden = true
        case .withSwitch:
            rightButton.isHidden = true
        case .withButton:
            switchView.isHidden = true
            rightButton.setTitle(settings.description, for: .normal)
        }
    }
    
    private func setupConstraints() {
        addSubview(leftImageView)
        NSLayoutConstraint.activate([
            leftImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            leftImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            leftImageView.widthAnchor.constraint(equalToConstant: 24),
            leftImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftImageView.rightAnchor, constant: 13),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        addSubview(rightButton)
        NSLayoutConstraint.activate([
            rightButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            rightButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        contentView.addSubview(switchView)
        NSLayoutConstraint.activate([
            switchView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            switchView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            switchView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
    }
    
}
