//
//  JsonParserObjC.h
//  NG_Task
//
//  Created by Kacper Augustyniak on 06/07/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonDownloaderObjC.h"
#import "CharacterDataObjC.h"

@protocol JsonParserObjCDelegate <NSObject>

-(void)dataDidParse:(NSMutableArray *)charactersData;

@end

@interface JsonParserObjC : NSObject <JsonDownloaderObjCDelegate>

@property NSMutableArray<CharacterDataObjC *>* charsData;
@property NSString * url;
@property JsonDownloaderObjC * jsonDwnld;
@property (weak)id<JsonParserObjCDelegate> delegate;

-(instancetype)initWithUrl:(NSString *) url;
-(void) parseJsonData:(NSDictionary *)jsonData;
@end
