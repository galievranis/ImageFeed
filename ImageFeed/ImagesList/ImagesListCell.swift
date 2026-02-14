//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Ranis Galiev on 01.02.2026.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private var photoImageView: UIImageView!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var likeButton: UIButton!
    
    // MARK: - Constants
    static let reuseIdentifier = "ImagesListCell"
    private let gradientHeight: CGFloat = 30
    
    // MARK: Properties
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews( )
        
        gradientLayer.frame = CGRect(
            x: 0,
            y: photoImageView.frame.height - gradientHeight,
            width: photoImageView.bounds.width,
            height: gradientHeight
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        dateLabel.text = nil
        likeButton.setImage(nil, for: .normal)
    }
    
    // MARK: - Configuration
    func configure(
        image: UIImage,
        dateText: String,
        isLiked: Bool
    ) {
        photoImageView.image = image
        dateLabel.text = dateText
        
        let imageName = isLiked ? "like-active" : "like-not-active"
        likeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    // MARK: - Private Functions
    private func setUpGradient() {
        gradientLayer.colors = [
            UIColor.ypBlack.withAlphaComponent(0.0).cgColor,
            UIColor.ypBlack.cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.opacity = 0.2
        
        if gradientLayer.superlayer == nil {
            photoImageView.layer.addSublayer(gradientLayer)
        }
    }
}
