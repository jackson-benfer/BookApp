//
//  BookViewCell.swift
//  BookApp
//
//  Created by MAC Consultant on 3/10/19.
//  Copyright © 2019 William Benfer. All rights reserved.
//

import UIKit

class BookViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    var index = -1
    weak var delegate: BookViewCellDelegate?
    
    @IBOutlet var button: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()

        button.layer.cornerRadius = button.frame.width / 2 
    }

    @IBAction func onButtonPush(_ sender: Any) {
        delegate?.toggle(index: index)
    }
}
