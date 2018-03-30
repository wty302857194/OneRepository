//
//  myTableViewControllerCell.h
//  MyViewController
//
//  Created by 杨飞 on 16/6/26.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myTableViewControllerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *myBtn;
@property (weak, nonatomic) IBOutlet UILabel *myLab;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (weak, nonatomic) IBOutlet UITextView *text_view;
@end
