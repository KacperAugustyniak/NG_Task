//  Created by Kacper Augustyniak on 06/07/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - view controller methods

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  NSString * url = @"http://gameofthrones.wikia.com/api/v1/Articles/Top?expand=1&category=Characters&limit=75";
  
  if (1) { //for demonstrative purposes. 1 allows JsonParserObjC to also download data. 0 JsonParserObjC parses data provided by ViewController downloaded by any other mean
    self.jsonParser = [[JsonParserObjC alloc] initWithUrl:url delegate:self];
  } else {
    self.jsonDownloaderObjC = [[JsonDownloaderObjC alloc] init];
    self.jsonDownloaderObjC.delegate = self;
    self.jsonParser = [[JsonParserObjC alloc] initWithDelegate:self];
    self.jsonParser.delegate = self;
    [self.jsonDownloaderObjC downloadJsonForUrl:url];
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];
}

-(void)showErrorPopupWithMessage:(NSString *)message {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString  stringWithFormat:@""] message:message preferredStyle:UIAlertControllerStyleAlert];

  UIAlertAction *okAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:NSLocalizedString(@"OK",nil)] style:UIAlertActionStyleDefault  handler:^(UIAlertAction *action) { }];
  
  [alertController addAction:okAction];
  
  [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - JsonParserObjCDelegate methods

-(void) dataDidParse:(NSMutableArray *)charactersData{
 // NSLog(@"parsed");
  self.charactersData = charactersData;
  [self.tableView reloadData];
}

#pragma mark - JsonDownloaderObjCDelegate methods

-(void) jsonDataDidDownload:(NSDictionary *)jsonData{
  //NSLog(@"downloaded");
  [self.jsonParser parseJsonData:jsonData];
}

-(void)jsonError:(NSString *)errorMessage{

  [self showErrorPopupWithMessage:[NSString stringWithFormat:@"An error occured while fetching data:\n%@",errorMessage]];
  
  //NSLog(@"An error occured while fetching data:\n%@",errorMessage);
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
