//
//  CFDeleteTableViewCell.h
//  CFDeleteDemo
//
//  Created by TheMoon on 16/5/11.
//  Copyright © 2016年 CFJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CFDeleteTableViewCell;

typedef void(^swipeBlock) ();
typedef void(^deleteBlock) ();
typedef void(^cancleBlock) ();
@interface CFDeleteTableViewCell : UITableViewCell
@property (nonatomic, assign) BOOL isOpen;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy)swipeBlock mySwipeBlock;
@property (nonatomic, copy)deleteBlock myDeleteBlock;
-(void)closeMenu;
@end
