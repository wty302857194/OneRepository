//
//  myTableViewController.h
//  MyViewController
//
//  Created by 杨飞 on 16/4/14.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myTableViewControllerCell;
@interface myTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *tabView;

@property (nonatomic, strong)myTableViewControllerCell *cell;
@end
