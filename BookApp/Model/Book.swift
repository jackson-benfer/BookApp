//
//  Book.swift
//  BookApp
//
//  Created by MAC Consultant on 3/9/19.
//  Copyright © 2019 William Benfer. All rights reserved.
//

import Foundation
import CoreData

struct Books: Decodable{
    
    let items: [Book]

    
    
}



class Book: Decodable{
    
    let volumeInfo: VolumeInfo?
    let id: String?
    
    struct VolumeInfo: Decodable{
        let title: String
        let authors: [String]
        let publisher: String?
        let publishedDate: String?
        let description: String?
        let imageLinks: ImageLinks
        
        struct ImageLinks: Decodable{
            let smallThumbnail: String
            let thumbnail: String
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case volumeInfo = "volumeInfo"
        case id = "id"
    }
    
    
    var title: String
    var authors: String
    var image: Data?
    var summary: String
    var publishDate: String
    var isFavorite = false
    
  
    func downloadImage(completion: @escaping (Data)->() ){
        //Choose a string to use
        
        let str = volumeInfo?.imageLinks.smallThumbnail ?? volumeInfo?.imageLinks.thumbnail ?? ""
        
        if str == ""{
            return
        }
        
        BookService.shared.downloadImage(urlStr: str){ data in
            
            self.image = data
            completion(data)
        }
        
        
    }
    /*
    @objc
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    */
    public required init(from decoder: Decoder) throws {
        
        //Init from JSON: No reason to save to CoreData yet
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        /*
         guard let context = decoder.userInfo[CodingUserInfoKey.context] as? NSManagedObjectContext else {
         throw NSError(domain: "Context not found!", code: 0, userInfo: nil)
         }
         
         guard let entity = NSEntityDescription.entity(forEntityName: "Pokemon", in: context) else {
         throw NSError(domain: "Could not make Entity", code: 0, userInfo: nil)
         }
         */
        
        //super.init(entity: entity, insertInto: context)
        volumeInfo = try! container.decodeIfPresent(VolumeInfo.self, forKey: .volumeInfo)
        id = try! container.decodeIfPresent(String.self, forKey: .id)
        
        
        title = volumeInfo?.title ?? "No title"
        authors = volumeInfo?.authors.joined(separator: ", ") ?? "No author?"
        summary = volumeInfo?.description ?? "No Summary Found"
        publishDate = volumeInfo?.publishedDate ?? "No Publish Date Found"
        isFavorite = false
        
    }
}
