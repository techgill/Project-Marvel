//
//  LoaderCollectionReusableView.swift
//  Kolo
//
//  Created by Intugine on 21/06/22.
//

import UIKit

class LoaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fillDetails(isLoaded: Bool) {
        if isLoaded {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
        else {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        }
    }
    
}
