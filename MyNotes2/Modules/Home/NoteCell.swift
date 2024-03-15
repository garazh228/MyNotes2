//
//  NoteCell.swift
//  MyNotes2
//
//  Created by adyl CEO on 14/03/2024.
//

import UIKit

protocol NoteCellDelegate: AnyObject {
    func didRemoveButton(index: Int)
}

class NoteCell: UICollectionViewCell {
    
    static var reuseId = "note_cell"
    
    var view = HomeView()
    
    var index: Int?
    
    let colors: [UIColor] = [.systemPink, .cyan, .systemOrange, .systemGreen]
    
    weak var delegate: NoteCellDelegate?
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var deleteButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "trash"), for: .normal)
        view.tintColor = .black
        view.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        backgroundColor = colors.randomElement()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String) {
        titleLabel.text = title
    }
    
    @objc func deleteButtonTapped() {
        guard let index = index else {
            return
        }
        delegate?.didRemoveButton(index: index)
    }
    
    private func setupConstraints() {
        addSubview(titleLabel)
        
        contentView.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            deleteButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 40),
            deleteButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
