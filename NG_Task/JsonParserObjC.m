//
//  JsonParserObjC.m
//  NG_Task
//
//  Created by Kacper Augustyniak on 06/07/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

#import "JsonParserObjC.h"

@implementation JsonParserObjC

-(instancetype)init{
    self.charsData = [[NSMutableArray alloc] init];
  return self;
}

-(instancetype)initWithUrl:(NSString *) url{
  self = [self init];
  
  self.url = url;
  //jsonDwnld = JsonDownloaderUsingNSURLSession()
  self.jsonDwnld = [[JsonDownloaderObjC alloc] init];
  self.jsonDwnld.delegate = self;
  [self.jsonDwnld downloadJsonForUrl:self.url];
  
  return self;
}

-(void) parseJsonData:(NSDictionary *)jsonData{
  NSMutableArray * allChars = [[NSMutableArray alloc] initWithArray:[jsonData objectForKey:@"items"]];
  
  for (NSDictionary* character in allChars ) {
    NSString * title = [character objectForKey:@"title"];
    NSString * abstract = [character objectForKey:@"abstract"];
    NSString * url = [character objectForKey:@"thumbnail"];
    
    CharacterDataObjC * singleCharacter = [[CharacterDataObjC alloc]initWithTitle:title andAbstract:abstract withImageUrl:url];
    [self.charsData addObject:singleCharacter];
  }
  [self.delegate dataDidParse:self.charsData];
}

-(void) jsonDataDidDownload:(NSDictionary *)jsonData{
  [self parseJsonData:jsonData];
}

@end
