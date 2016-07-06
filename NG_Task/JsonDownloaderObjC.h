//
//  JsonDownloaderObjC.h
//  NG_Task
//
//  Created by Kacper Augustyniak on 06/07/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JsonDownloaderObjCDelegate <NSObject>

-(void)jsonDataDidDownload:(NSDictionary *)jsonData;

@end


@interface JsonDownloaderObjC : NSObject

@property NSMutableData* data;
@property NSDictionary* jsonData;
@property (weak)id <JsonDownloaderObjCDelegate> delegate;

-(void)downloadJsonForUrl:(NSString*)stringUrl;
@end
