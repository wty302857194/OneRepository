//
//  BlockView.m
//  MyViewController
//
//  Created by 杨飞 on 16/7/4.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "BlockView.h"

@implementation BlockView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//+(BlockView *)shareBlockView {
//    static BlockView *block_view = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        block_view = [[BlockView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//        
//    });
//    return block_view;
//}
//+ (void)showBlockView:(SureBlock)sureBlock CancleBlock:(CancleBlock)cancleBlock {
//    [[BlockView new] showBlockView:sureBlock CancleBlock:cancleBlock];
//    
//}
- (void)showBlockView:(SureBlock)sureBlock CancleBlock:(CancleBlock)cancleBlock {
    self.sureBlock = sureBlock;
    self.cancleBlock = cancleBlock;
    [self removeFromSuperview];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
- (IBAction)sureBtn:(UIButton *)sender {
    if (self.sureBlock != nil) {
        self.sureBlock();
    }
}
- (IBAction)cancleBtn:(UIButton *)sender {
    if (self.cancleBlock != nil) {
        self.cancleBlock();
    }
}

@end
