//
//  ViewController.swift
//  BookApp
//
//  Created by MAC Consultant on 3/9/19.
//  Copyright © 2019 William Benfer. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var books: [Book] = []
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "BookViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell1")

        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        books = BookService.shared.loadFavorites()
        collectionView.reloadData()
        
        self.navigationController?.navigationBar.topItem?.titleView = nil
        super.viewWillAppear(animated)
    }
    
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let w = self.view.bounds.width / 2
        
        return CGSize(width: w, height: w + CGFloat(BookCell.bottomPadding))
        
    }
    
}

extension FavoritesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
       
        let tab = self.tabBarController as! BookTabViewContoller
        tab.showDetail(books[indexPath.row])
        
        
    }
    
}

extension FavoritesViewController: UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! BookViewCell
        
       
        cell.titleLabel.text = books[indexPath.row].title
        cell.authorLabel.text = books[indexPath.row].authors
        cell.index = indexPath.row
        cell.delegate = self
        
        
        if books[indexPath.row].isFavorite{
            cell.button.backgroundColor = UIColor.green
        }else{
            cell.button.backgroundColor = UIColor.red
        }
        
        
        if books[indexPath.row].image != nil{
            cell.imageView.image = UIImage(data: books[indexPath.row].image!)
        }else{
            books[indexPath.row].downloadImage { (data) in
                DispatchQueue.main.async {
                    cell.imageView.image = UIImage(data: data)
                }
            }
        }
        
        
        return cell
        
    }
    
    
}

extension FavoritesViewController: BookViewCellDelegate{
    func toggle(index: Int) {
        
        
        let alert = UIAlertController(title: "Remove From Favorites?", message: "This action cannot be undone.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Remove", style: .default){ _ in
        
            //Remove from favorites
            BookService.shared.removeFavorite(self.books[index])
            self.books[index].isFavorite.toggle()
            self.books.remove(at: index)
            self.collectionView.reloadData()
            
        })
    
        alert.addAction(UIAlertAction(title: "Cancel", style: .default){ _ in
            // Do nothing
        })
    
    
        self.present(alert, animated: true, completion: nil)
    
    }
}
