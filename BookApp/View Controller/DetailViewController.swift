//
//  DetailViewController.swift
//  BookApp
//
//  Created by MAC Consultant on 3/9/19.
//  Copyright © 2019 William Benfer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var book: Book!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        
        titleLabel.text = book.title
        authorLabel.text = book.authors
        descriptionLabel.text = book.summary
        if book.image != nil{
            imageView.image = UIImage(data: book.image!)
        }else{
            book.downloadImage { (data) in
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
        
        super.viewWillAppear(animated)
        
    }
    

}
