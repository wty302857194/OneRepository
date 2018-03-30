//
//  ShareMessageView.m
//  MyViewController
//
//  Created by 杨飞 on 16/8/2.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "ShareMessageView.h"

@implementation ShareMessageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)sureShareBtn:(UIButton *)sender {
    _sureShareBlock();
}

- (IBAction)cancelBtn:(UIButton *)sender {
    _cancelBlock();
}
@end
