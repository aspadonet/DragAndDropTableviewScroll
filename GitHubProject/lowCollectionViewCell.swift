//
//  lowCollectionViewCell.swift
//  GitHubProject
//
//  Created by Alexander Avdacev on 19.04.22.
//

import UIKit

class lowCollectionViewCell: UICollectionViewCell{


    var number: Int? {
        didSet{
            labelText.text = "\(String(describing: number!))"
        }
    }
    var labelText: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .link
 
        addSubview(labelText)
        labelText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelText.topAnchor.constraint(equalTo: topAnchor),
            labelText.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelText.centerYAnchor.constraint(equalTo: centerYAnchor),
//            labelText.widthAnchor.constraint(equalToConstant: 150),
//            labelText.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
