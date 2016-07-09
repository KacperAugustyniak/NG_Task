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
  
  if ([self checkIfHostIsAvailable:stringUrl]) {
    NSLog(@"yes");
  } else {
    NSLog(@"no");
  }
  
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

- (bool)checkIfHostIsAvailable:(NSString *)hostUrl{
  bool success = NO;
  bool isAvailable = NO;
  const char *hostName = [[NSString stringWithFormat:@"%@",hostUrl]cStringUsingEncoding:NSASCIIStringEncoding];
  
  SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL,hostName);
  SCNetworkReachabilityFlags flags;
  success = SCNetworkReachabilityGetFlags(reachability, &flags);
  isAvailable = success && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired);
  return isAvailable;
}

@end
