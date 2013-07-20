//
//  PTRTableViewController.m
//  zhiboba
//
//  Created by kongfy on 13-7-10.
//  Copyright (c) 2013年 com.subo. All rights reserved.
//

#import "PTRTableViewController.h"

@interface PTRTableViewController () <EGORefreshTableDelegate>

@property (weak, nonatomic) EGORefreshTableHeaderView *refreshHeaderView;
@property (weak, nonatomic) EGORefreshTableFooterView *refreshFooterView;

@end

@implementation PTRTableViewController

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
    [super viewDidLoad];
    if (self.hasHeaderRefresh && !self.refreshHeaderView) {
        [self setUpViewForHeaderRefresh];
    }
    if (self.hasFooterRefresh && !self.refreshFooterView) {
        [self setUpViewForFooterRefresh];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self finishLoadingData];
    [super viewWillDisappear:animated];
}

#pragma mark - EGOPullRefresh

- (void)setUpViewForHeaderRefresh
{
    self.refreshHeaderView = [EGORefreshTableHeaderView setView:self.refreshHeaderView forScrollView:self.tableView delegate:self];
}

- (void)setUpViewForFooterRefresh
{
    self.refreshFooterView = [EGORefreshTableFooterView setView:self.refreshFooterView forScrollView:self.tableView delegate:self];
}

- (void)pullDownRefresh
{
}

- (void)pullUpRefresh
{
}

- (void)finishLoadingData
{
    self.isLoading = NO;
    [self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    [self.refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
    if (self.hasFooterRefresh) {
        [self setUpViewForFooterRefresh];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [self.refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [self.refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)egoRefreshTableDidTriggerRefresh:(EGORefreshPos)aRefreshPos
{
    self.isLoading = YES;
    if (aRefreshPos == EGORefreshHeader) {
        [self pullDownRefresh];
    } else if (aRefreshPos == EGORefreshFooter) {
        [self pullUpRefresh];
    }
}

- (BOOL)egoRefreshTableDataSourceIsLoading:(UIView*)view
{
	return self.isLoading;
}

- (NSDate*)egoRefreshTableDataSourceLastUpdated:(UIView*)view
{
    return [NSDate date];
}

@end
