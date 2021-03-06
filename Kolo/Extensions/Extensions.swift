//
//  Extensions.swift
//  Kolo
//
//  Created by Hardeep on 15/04/22.
//

import UIKit
import Haneke

extension UIImageView {

    // Returns activity indicator view centrally aligned inside the UIImageView
    private var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        self.addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        let centerX = NSLayoutConstraint(item: self,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerX,
                                         multiplier: 1,
                                         constant: 0)
        let centerY = NSLayoutConstraint(item: self,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: activityIndicator,
                                         attribute: .centerY,
                                         multiplier: 1,
                                         constant: 0)
        self.addConstraints([centerX, centerY])
        return activityIndicator
    }

    // Asynchronous downloading and setting the image from the provided urlString
    func setImageFrom(_ urlString: String, completion: (() -> Void)? = nil) {
        guard let url = URL(string: urlString) else { return }

        let session = URLSession(configuration: .default)
        let activityIndicator = self.activityIndicator

        DispatchQueue.main.async {
            activityIndicator.startAnimating()
        }

        let downloadImageTask = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let imageData = data {
                    DispatchQueue.main.async {[weak self] in
                        var image = UIImage(data: imageData)
                        self?.image = nil
                        self?.image = image
                        image = nil
                        completion?()
                    }
                }
            }
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
            session.finishTasksAndInvalidate()
        }
        downloadImageTask.resume()
    }
    
    
    
    //MARK: - new image loader
    static let loadingViewTag = 1938123987
    func setImageFromURLWithLoader(urlString:String){
         self.showLoading()
        if let url = URL(string:urlString) {
            self.hnk_setImage(from: url, placeholder: nil, success: {
                image in
                self.image = image
                self.stopLoading()
            }, failure: nil)
        } else {
            self.stopLoading()
        }
        
    }
    func showLoading(style: UIActivityIndicatorView.Style = .medium) {
        self.image = nil
        var loading = viewWithTag(UIImageView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: style)
        }

        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading!.startAnimating()
        loading!.hidesWhenStopped = true
        loading?.tag = UIImageView.loadingViewTag
        addSubview(loading!)
      loading?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func stopLoading() {
        let loading = viewWithTag(UIImageView.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
}
