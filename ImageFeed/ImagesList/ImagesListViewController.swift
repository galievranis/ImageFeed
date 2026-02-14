//
//  ImagesListViewController.swift
//  ImageFeed
//
//  Created by Ranis Galiev on 29.01.2026.
//

import UIKit

final class ImagesListViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Constants
    private let showSingleImageSegueIdentifier = "ShowSingleImage"
    private let defaultRowHeight: CGFloat = 200
    private let horizontalInset: CGFloat = 16
    
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
    
    // MARK: - Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showSingleImageSegueIdentifier {
            guard
                let viewController = segue.destination as? SingleImageViewController,
                let indexPath = sender as? IndexPath
            else {
                assertionFailure("Invalid segue destination")
                return
            }
            
            let image = UIImage(named: photoNames[indexPath.row])
            viewController.image = image
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

// MARK: - UITableViewDelegate
extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let imageName = photoNames[indexPath.row]
        
        guard let image = UIImage(named: imageName) else {
            return defaultRowHeight
        }
        
        let targetWidth = tableView.bounds.width - horizontalInset * 2
        
        guard image.size.width > 0 else {
            return defaultRowHeight
        }
        
        let imageScale = targetWidth / image.size.width
        let scaledHeight = image.size.height * imageScale
        
        return scaledHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showSingleImageSegueIdentifier, sender: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photoNames.count
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
    private func configureCell(for cell: ImagesListCell,with indexPath: IndexPath) {
        let imageName = photoNames[indexPath.row]
        
        guard let image = UIImage(named: imageName) else {
            return
        }
        
        let dateText = dateFormatter.string(from: Date())
        let isLiked = indexPath.row % 2 == 0
        
        cell.configure(image: image, dateText: dateText, isLiked: isLiked)
    }
}


