//
//  ComicCollectionViewCell.swift
//  Kolo
//
//  Created by Hardeep on 14/04/22.
//

import UIKit

class ComicCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.borderWidth = 1.1
        bgView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func fillDetails(vm: CharactersViewModel, index: Int) {
        imageView.setImageFrom(vm.getImage(index: index), completion: nil)
        headingLabel.text = vm.getName(index: index)
        descriptionLabel.text = vm.getDescription(index: index)
    }
    
    func fillDetails(vm: ComicsViewModel, index: Int) {
        imageView.setImageFrom(vm.getImage(index: index), completion: nil)
        headingLabel.text = vm.getTitle(index: index)
        descriptionLabel.text = vm.getDescription(index: index)
    }

}
