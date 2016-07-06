//
//  JsonDownloaderObjC.m
//  NG_Task
//
//  Created by Kacper Augustyniak on 06/07/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

#import "JsonDownloaderObjC.h"

@implementation JsonDownloaderObjC

-(void)downloadJsonForUrl:(NSString*)stringUrl{
  NSURL*url = [NSURL URLWithString:stringUrl];
  NSURLRequest* request = [NSURLRequest requestWithURL:url];
  NSURLSession* session = [NSURLSession sharedSession];
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
      if (error) {
        NSLog(@"Error downloading file");
      } else {
        self.jsonData = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
      }
      dispatch_async(dispatch_get_main_queue(), ^{ [self.delegate jsonDataDidDownload:self.jsonData];});
    }];
  
  [task resume];
  
}

@end
