//
//  MyTableViewController.m
//  PullToRefresh
//
//  Created by kongfy on 13-7-20.
//  Copyright (c) 2013年 com.kongfy. All rights reserved.
//

#import "MyTableViewController.h"

@interface MyTableViewController ()

@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation MyTableViewController

- (NSMutableArray *)data
{
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.hasHeaderRefresh = true;
    self.hasFooterRefresh = true;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Number Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d", ((NSNumber *)[self.data objectAtIndex:indexPath.row]).intValue];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - PTRTableView Override

- (void)pullUpRefresh
{
    [self.data addObject:[NSNumber numberWithInt:[self.data count]]];
    [self performSelector:@selector(doneLoadingData) withObject:nil afterDelay:3.0];
}

- (void)pullDownRefresh
{
    [self.data addObject:[NSNumber numberWithInt:[self.data count]]];
    [self performSelector:@selector(doneLoadingData) withObject:nil afterDelay:3.0];
}

- (void)doneLoadingData
{
    [self.tableView reloadData];
    [self finishLoadingData];
}

@end
