//
//  ViewController.h
//
//  Created by Kacper Augustyniak on 06/07/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "NG_Task-Swift.h"
#import "JsonParserObjC.h"
#import "JsonDownloaderObjC.h"

@interface ViewController : UIViewController <JsonParserObjCDelegate, JsonDownloaderObjCDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property JsonParserObjC * jsonParser;
@property JsonDownloaderObjC * jsonDownloaderObjC;
@property NSMutableArray <CharacterDataObjC *> * charactersData;


@end

