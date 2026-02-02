//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Ranis Galiev on 01.02.2026.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    @IBOutlet private var photoImageView: UIImageView!
    
    static let reuseIdentifier = "ImagesListCell"
    private let gradientLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews( )
        
        let gradientHeight: CGFloat = 30
        
        gradientLayer.frame = CGRect(
            x: 0,
            y: photoImageView.frame.height - gradientHeight,
            width: photoImageView.bounds.width,
            height: gradientHeight
        )
    }
    
    private func setUpGradient() {
        gradientLayer.colors = [
            UIColor.ypBlack.withAlphaComponent(0.0).cgColor,
            UIColor.ypBlack.withAlphaComponent(0.2).cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        photoImageView.layer.addSublayer(gradientLayer)
    }
}
