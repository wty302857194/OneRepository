//
//  RedPacketView.m
//  cjh
//
//  Created by 杨飞 on 16/5/24.
//  Copyright © 2016年 njcjh. All rights reserved.
//

#import "RedPacketView.h"

@implementation RedPacketView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)cancelBtn:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(redPacketViewDetal:)]) {
        [self.delegate redPacketViewDetal:sender.tag];
    }
}
- (IBAction)starFaLiQuan:(UIButton *)sender {
//    if (_delegate&&[self.delegate respondsToSelector:@selector(redPacketViewDetal:)]) {
        [self.delegate redPacketViewDetal:sender.tag];
//    }
}
@end
