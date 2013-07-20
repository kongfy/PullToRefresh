//
//  PTRTableViewController.h
//  zhiboba
//
//  Created by kongfy on 13-7-10.
//  Copyright (c) 2013年 com.subo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@interface PTRTableViewController : UITableViewController

@property (nonatomic) BOOL isLoading, hasHeaderRefresh, hasFooterRefresh;

- (void)finishLoadingData;
- (void)pullDownRefresh;
- (void)pullUpRefresh;

@end
