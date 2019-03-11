//
//  BookTabViewContoller.swift
//  BookApp
//
//  Created by MAC Consultant on 3/9/19.
//  Copyright © 2019 William Benfer. All rights reserved.
//

import UIKit

class BookTabViewContoller: UITabBarController {

    var book: Book!
    
    func showDetail(_ book: Book){
        self.book = book
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let dest = segue.destination as? DetailViewController else {return}
        dest.book = book
    }
}
