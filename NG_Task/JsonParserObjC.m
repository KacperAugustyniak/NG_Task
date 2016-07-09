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

-(instancetype)initWithUrl:(NSString *) url delegate:(id<JsonParserObjCDelegate>)delegate{
  self = [self init];
  self.delegate = delegate;
  self.url = url;
  //jsonDwnld = JsonDownloaderUsingNSURLSession()
  self.jsonDwnld = [[JsonDownloaderObjC alloc] init];
  self.jsonDwnld.delegate = self;
  [self.jsonDwnld downloadJsonForUrl:self.url];
  
  return self;
}

-(instancetype)initWithDelegate:(id<JsonParserObjCDelegate>)delegate{
  self = [self init];
  self.delegate = delegate;
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

-(void)jsonError:(NSString *)errorMessage{
  
  NSLog(@"An error occured while fetching data:\n%@",self.delegate);
  [self.delegate jsonError:[NSString stringWithFormat:@"An error occured while fetching data:\n%@",errorMessage]];
}
@end
