//
//  ShareMessageView.h
//  MyViewController
//
//  Created by 杨飞 on 16/8/2.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^sureShareBlockCZ)();
typedef void(^cancelBlockCZ)();
@interface ShareMessageView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *cotentLab;
@property (nonatomic,strong) sureShareBlockCZ sureShareBlock;
@property (nonatomic,strong) cancelBlockCZ cancelBlock;
- (IBAction)sureShareBtn:(UIButton *)sender;
- (IBAction)cancelBtn:(UIButton *)sender;

@end
