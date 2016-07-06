//
//  ViewController.h
//  NG_Task
//
//  Created by Kacper Augustyniak on 06/07/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NG_Task-Swift.h"

@interface ViewController : UIViewController <JsonParserDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property JsonParser * jsonParser;
@property NSMutableArray <CharacterData *> * charactersData;


@end

