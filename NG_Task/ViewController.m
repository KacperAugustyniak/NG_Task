//  Created by Kacper Augustyniak on 06/07/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - view controller methods

- (void)viewDidLoad {
  [super viewDidLoad];
  NSString * url = @"http://gameofthrones.wikia.com/api/v1/Articles/Top?expand=1&category=Characters&limit=75";
  
  if (0) { //for demonstrating purposes. 1 allows JsonParserObjC to also download data. 0 JsonParserObjC parses data provided by ViewController
    self.jsonParser = [[JsonParserObjC alloc] initWithUrl:url];
  } else {
    self.jsonDownloaderObjC = [[JsonDownloaderObjC alloc] init];
    self.jsonDownloaderObjC.delegate = self;
    self.jsonParser = [[JsonParserObjC alloc] init];
    [self.jsonDownloaderObjC downloadJsonForUrl:url];
  }
  
  self.jsonParser.delegate = self;
}

-(void) dataDidParse:(NSMutableArray *)charactersData{
  NSLog(@"parsed");
  self.charactersData = charactersData;
//  for (int i = 0; i <  self.charactersData.count; i++) {
//    NSLog(@"downloaded %@", self.charactersData[i].abstract);
//  }
  [self.tableView reloadData];
}


-(void) jsonDataDidDownload:(NSDictionary *)jsonData{
  NSLog(@"downloaded");
  [self.jsonParser parseJsonData:jsonData];
}

#pragma mark - table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.charactersData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *simpleTableIdentifier = @"TableViewCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
  }
  
  cell.textLabel.text = self.charactersData[indexPath.row].title ;
  cell.detailTextLabel.text = self.charactersData[indexPath.row].abstract;
  cell.detailTextLabel.numberOfLines = 1;
  
  return cell;
}

@end
