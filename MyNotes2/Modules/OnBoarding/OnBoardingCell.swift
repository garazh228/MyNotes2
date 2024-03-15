//
//  OnBoardingCell.swift
//  MyNotes2
//
//  Created by adyl CEO on 14/03/2024.
//

import UIKit

class OnBoardingCell: UICollectionViewCell {
    
    static var reuseId = "on_board_cell"
    //    var colors: [UIColor] = [.cyan, .blue, .green]
//    var images: [String] = ["onboard1", "onboard2", "onboard3"]
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -100),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            imageView.widthAnchor.constraint(equalToConstant: 310),
//            imageView.heightAnchor.constraint(equalToConstant: 319)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
