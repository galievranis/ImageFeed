//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Ranis Galiev on 04.02.2026.
//

import UIKit

final class ProfileViewController: UIViewController {
    // MARK: - Properties
    private let profileImage = UIImageView()
    private let nameLabel = UILabel()
    private let nicknameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let button = UIButton(type: .system)
    private let labelStackView = UIStackView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureUI()
        
        let model = ProfileModel(
            name: "Екатерина Новикова",
            nickname: "@ekaterina_nov",
            description: "Hello, world!",
            image: UIImage(resource: .profilePicture)
        )
        
        configure(with: model)
        setupConstraints()
    }
    
    // MARK: - Actions
    @objc
    private func didTapButton() {
        
    }
    
    // MARK: - Setup
    private func setupViews() {
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(nicknameLabel)
        labelStackView.addArrangedSubview(descriptionLabel)
        
        [profileImage, labelStackView, button].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
    }
    
    private func configure(with model: ProfileModel) {
        nameLabel.text = model.name
        nicknameLabel.text = model.nickname
        descriptionLabel.text = model.description
        profileImage.image = model.image
    }
    
    private func configureUI() {
        configureProfileImageStyles()
        configureLabelsStyle()
        configureButton()
        configureStackView()
    }
    
    private func configureProfileImageStyles() {
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = 35
        profileImage.clipsToBounds = true
        profileImage.accessibilityLabel = "Profile image"
    }
    
    private func configureLabelsStyle() {
        nameLabel.textColor = .ypWhite
        nameLabel.font = .systemFont(ofSize: 23, weight: .bold)
        
        nicknameLabel.textColor = .ypGray
        nicknameLabel.font = .systemFont(ofSize: 13)
        
        descriptionLabel.textColor = .ypWhite
        descriptionLabel.font = .systemFont(ofSize: 13)
    }
    
    private func configureButton() {
        button.setImage(UIImage(resource: .logout), for: .normal)
        button.tintColor = .ypRed
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.accessibilityLabel = "Logout"
    }
    
    private func configureStackView() {
        labelStackView.axis = .vertical
        labelStackView.spacing = 8
        labelStackView.alignment = .leading
    }
    
    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: guide.topAnchor, constant: 32),
            profileImage.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),
            profileImage.widthAnchor.constraint(equalToConstant: 70),
            profileImage.heightAnchor.constraint(equalToConstant: 70),
            
            labelStackView.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            labelStackView.leadingAnchor.constraint(equalTo: profileImage.leadingAnchor),
            
            button.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
            button.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor)
        ])
    }
}
