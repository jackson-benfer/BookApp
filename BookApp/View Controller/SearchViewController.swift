//
//  ViewController.swift
//  BookApp
//
//  Created by MAC Consultant on 3/9/19.
//  Copyright © 2019 William Benfer. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var noResultsLabel: UILabel!
    var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    var books: [Book] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        //navigationItem.titleView = searchBar
        searchBar.delegate = self
        
        
        let nib = UINib(nibName: "BookViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell1")

        //self.navigationController?.navigationBar.topItem?.titleView = searchBar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.topItem?.titleView = searchBar
        super.viewWillAppear(animated)
    }

}

extension SearchViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let w = self.view.bounds.width / 2
        
        return CGSize(width: w, height: w + CGFloat(BookCell.bottomPadding))
        
    }

}

extension SearchViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        
        let tab = self.tabBarController as! BookTabViewContoller
        tab.showDetail(books[indexPath.row])
        
      
        
    }

}

extension SearchViewController: UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! BookViewCell
        
        
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
        
        cell.titleLabel.text = books[indexPath.row].title
        cell.authorLabel.text = books[indexPath.row].authors
        cell.index = indexPath.row
        cell.delegate = self
        
        return cell
        
    }
    
    
}


extension SearchViewController: UISearchBarDelegate{
    
    /*
    optional public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) // called when text starts editing
    
 
    
    optional public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) // called when text ends editing
 
    
    optional public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) // called when text changes (including clear)
    
    @available(iOS 3.0, *)
    optional public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool // called before text changes
    */
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        
        searchBar.endEditing(true)
        BookService.shared.searchFor(searchBar.text ?? "") { books in
        
      
        self.books = books
            
        DispatchQueue.main.async {
            if books.count == 0{
                self.noResultsLabel.text = "No Results"
                self.noResultsLabel.isEnabled = true
            }else{
                self.noResultsLabel.text = ""
                self.noResultsLabel.isEnabled = false
            }
                self.collectionView.reloadData()
                
            }
        }
      
    }
    
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar){
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        //Cancel Search? Might be unecesary
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        // called when search results button pressed
        
    }
    
}


extension SearchViewController: BookViewCellDelegate{
    func toggle(index: Int){
        
        if index >= books.count{
            return
        }
        
        if books[index].isFavorite{
            BookService.shared.removeFavorite(books[index])
        }else{
            BookService.shared.addFavorite(books[index])
        }
        
        books[index].isFavorite.toggle()
        collectionView.reloadData()
        
        
    }
}
