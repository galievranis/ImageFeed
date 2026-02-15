//
//  SingleImageViewController.swift
//  ImageFeed
//
//  Created by Ranis Galiev on 06.02.2026.
//

import UIKit

final class SingleImageViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var shareButton: UIButton!
    
    // MARK: - Constants
    private let minZoomScale: CGFloat = 0.1
    private let maxZoomScale: CGFloat = 1.25
    
    // MARK: - Properties
    var image: UIImage? {
        didSet {
            guard isViewLoaded, let image else { return }
            configureImage(image)
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.minimumZoomScale = minZoomScale
        scrollView.maximumZoomScale = maxZoomScale
        
        guard let image else { return }
        configureImage(image)
    }
    
    // MARK: - Actions
    @IBAction private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapShareButton() {
        guard let image else { return }

        let activityViewController = UIActivityViewController(
            activityItems: [image],
            applicationActivities: nil
        )

        present(activityViewController, animated: true)
    }
    
    // MARK: - Functions
    private func rescaleImageInScrollView(image: UIImage) {
        let minZoomScale = scrollView.minimumZoomScale
        let maxZoomScale = scrollView.maximumZoomScale
        
        view.layoutIfNeeded()
        
        let visibleRectSize = scrollView.bounds.size
        let imageSize = image.size
        let hScale = visibleRectSize.width / imageSize.width
        let vScale = visibleRectSize.height / imageSize.height
        let scale = min(maxZoomScale, max(minZoomScale, min(hScale, vScale)))
        
        scrollView.setZoomScale(scale, animated: false)
        scrollView.layoutIfNeeded()
        
        centerImageInScrollView()
    }
    
    private func centerImageInScrollView() {
        let boundsSize = scrollView.bounds.size
        let contentSize = scrollView.contentSize
        
        let insetX = max((boundsSize.width - contentSize.width) / 2, 0)
        let insetY = max((boundsSize.height - contentSize.height) / 2, 0)
        
        scrollView.contentInset = UIEdgeInsets(
            top: insetY,
            left: insetX,
            bottom: insetY,
            right: insetX
        )
    }
    
    private func configureImage(_ image: UIImage) {
        imageView.image = image
        imageView.frame.size = image.size
        rescaleImageInScrollView(image: image)
    }
}

// MARK: - UIScrollViewDelegate
extension SingleImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImageInScrollView()
    }
}
