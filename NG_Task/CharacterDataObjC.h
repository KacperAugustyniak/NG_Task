//
//  CharacterDataObjC.h
//  NG_Task
//
//  Created by Kacper Augustyniak on 06/07/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterDataObjC : NSObject

@property NSString * _Nonnull title;
@property NSString * _Nonnull abstract;
@property NSString * _Nullable iconUrl;

- (instancetype _Nonnull)initWithTitle:(NSString*_Nonnull)title andAbstract:(NSString*_Nonnull)abstract;

- (instancetype _Nonnull)initWithTitle:(NSString*_Nonnull)title andAbstract:(NSString*_Nonnull)abstract withImageUrl:(NSString*_Nullable)url;

@end
