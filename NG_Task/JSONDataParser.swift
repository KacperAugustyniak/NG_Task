//
//  JSONDataParser.swift
//
//  Created by Kacper Augustyniak on 07/06/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//
// http://openweathermap.org/img/w/10d.png

import Foundation

class CharacterData:NSObject {
  var title:String!
  var abstract:String!
  var iconUrl:String?
  
  init(title:String, abstract:String, iconUrl:String?){
    self.title = title
    self.abstract = abstract
    self.iconUrl = iconUrl
  }
}


@objc protocol JsonParserDelegate:class {
  func dataDidParse(charactersData: NSMutableArray)
}

class JsonParser:NSObject, JsonDownloaderObjCDelegate {

  var charsData:Array<CharacterData>?
  var url:String!
  var jsonDwnld:JsonDownloaderObjC!
  weak var delegate:JsonParserDelegate?
  
  
  init(url:String) {
    super.init()
    self.url = url
    
    charsData = []
    //jsonDwnld = JsonDownloaderUsingNSURLSession()
    jsonDwnld = JsonDownloaderObjC()
    jsonDwnld.delegate = self
    jsonDwnld.downloadJsonForUrl(self.url)
  }

 // -(void)jsonDataDidDownload:(NSDictionary *)jsonData;

  func jsonDataDidDownload(jsonData: [NSObject : AnyObject]) {
    
    
    let allChars = jsonData["items"] as? [AnyObject]
    
    for character in allChars! {
    
      let title = character["title"] as? String
      let abstract = character["abstract"] as? String
      let url = character["thumbnail"] as? String
      let singleCharacter = CharacterData(title: title!, abstract:abstract!, iconUrl:url)

      charsData?.append(singleCharacter)
      
      }
    delegate?.dataDidParse(NSMutableArray(array: charsData!))
  }
  
}