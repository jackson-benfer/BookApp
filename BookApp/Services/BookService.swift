//
//  BookService.swift
//  BookApp
//
//  Created by MAC Consultant on 3/9/19.
//  Copyright © 2019 William Benfer. All rights reserved.
//

import Foundation

// "https://www.googleapis.com/books/v1/volumes?q=haryy+potter&key=AIzaSyDUEhg4R-iBq2xWJ4_4JtVkVoFF8qahKnY"
class BookService{
    
    let apiKey = "AIzaSyDUEhg4R-iBq2xWJ4_4JtVkVoFF8qahKnY"
    let startUrl = "https://www.googleapis.com/books/v1/volumes?q="
    let midURL = "&key="
    
    public static let shared = BookService()
    
    private var favorites: [Book] = []
    
    private init(){
        
    }
    
    func searchFor(_ search: String, completion: @escaping ([Book])->() ){
        
        //Search for given string in Google Books API
        
        let s = search.replacingOccurrences(of: " ", with: "+")
        
        
        
        let urlStr = startUrl + s + midURL + apiKey
        
        print(urlStr)
        
        guard let url = URL(string: urlStr) else {return}
        
        URLSession.shared.dataTask(with: url){ (data, _, _) in
         
            if let dat = data {
                
                let decoder = JSONDecoder()
                do {
                  
                    let books = try decoder.decode(Books.self, from: dat)
                    completion(books.items)
                  
                }
                catch {
                    
                    print(error)
                }
            }
            
        }.resume()
    
        return
    }
    
    func downloadImage(urlStr: String, completion: @escaping (Data)->() ){
        
        print(urlStr)
        guard let url = URL(string: urlStr) else {return}
        
        
        URLSession.shared.dataTask(with: url){ (data, _, _) in
            if let d = data{
                completion(d)
            }
        }.resume()
    }
    
    func getFavorites() -> [Book]{
        
        //TODO: Load Favorites from CoreData
        /*
        var books: [Book] = []
        for i in 0..<10{
            books.append(Book(title: "Favorite Book \(i)"))
        }
 */
        return []
    }
    
    
    //TODO: Core Data
    
    
    func loadFavorites() -> [Book]{
        return favorites
    }
    
    func addFavorite(_ book: Book){
        favorites.append(book)
        
    }
    
    func removeFavorite(_ book: Book){
        favorites.removeAll(){ b in
            return b.id == book.id
        }
    }
    
}
