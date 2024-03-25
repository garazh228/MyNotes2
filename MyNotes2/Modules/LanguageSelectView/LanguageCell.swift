//
//  LanguageCell.swift
//  MyNotes2
//
//  Created by adyl CEO on 19/03/2024.
//

import UIKit
import SnapKit

struct Language {
    var image: String
    var title: String
}

class LanguageCell: UITableViewCell {
    
    static var reuseId = "language_cell"

    private lazy var iconImageView: UIImageView = {
       let view = UIImageView()
        view.layer.cornerRadius = 32 / 2
        view.clipsToBounds = true
        return view
    }()

    private lazy var titleLabel: UILabel = {
         let view = UILabel()
         view.textAlignment = .center
         return view
     }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(language: Language) {
        iconImageView.image = UIImage(named: language.image)
        titleLabel.text = language.title
    }

    private func setupConstraints() {
        addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.height.equalTo(32)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}


