//
//  UserTableViewCell.h
//  MyViewController
//
//  Created by 杨飞 on 16/6/28.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *my_lab;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab_layout;

@end
