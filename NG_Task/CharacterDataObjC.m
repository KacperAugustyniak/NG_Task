//
//  CharacterDataObjC.m
//  NG_Task
//
//  Created by Kacper Augustyniak on 06/07/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

#import "CharacterDataObjC.h"

@implementation CharacterDataObjC

- (instancetype)initWithTitle:(NSString*)title andAbstract:(NSString*)abstract {
  self = [super init];
  
  self.abstract = abstract;
  self.title = title;
  self.iconUrl  = nil;
  
  NSLog(@"no url");
  return self;
}

- (instancetype)initWithTitle:(NSString*)title andAbstract:(NSString*)abstract withImageUrl:(NSString*)url{
  self = [super init];
  if (!url) {
    return [self initWithTitle:title andAbstract:abstract];
  }
  self.abstract = abstract;
  self.title = title;
  self.iconUrl  = url;
  
  return self;
}

@end
