//
//  ImagesListViewController.swift
//  ImageFeed
//
//  Created by Ranis Galiev on 29.01.2026.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Properties
    private let photoNames: [String] = Array(0..<20).map{ "\($0)" }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
}

// MARK: - UITableViewDelegate
extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageName = photoNames[indexPath.row]
        let defaultRowHeight: CGFloat = 200
        let horizontalInset: CGFloat = 16
        
        guard let image = UIImage(named: imageName) else {
            return defaultRowHeight
        }
        
        let targetWidth = tableView.bounds.width - horizontalInset * 2
        
        let imageScale = targetWidth / image.size.width
        let scaledHeight = image.size.height * imageScale
        
        return scaledHeight
    }
}

// MARK: - UITableViewDataSource
extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            return UITableViewCell()
        }
        
        configureCell(for: imageListCell, with: indexPath)
        return imageListCell
    }
}

// MARK: - Cell Configuration
extension ImagesListViewController {
    private func configureCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        let imageName = photoNames[indexPath.row]
        
        guard let image = UIImage(named: imageName) else {
            return
        }
        
        let dateText = dateFormatter.string(from: Date())
        let isLiked = indexPath.row % 2 == 0
        
        cell.configure(image: image, dateText: dateText, isLiked: isLiked)
    }
}
