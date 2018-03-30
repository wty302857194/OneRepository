//
//  RedPacketView.h
//  cjh
//
//  Created by 杨飞 on 16/5/24.
//  Copyright © 2016年 njcjh. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RedPacketViewDelegate <NSObject>

- (void)redPacketViewDetal:(NSInteger)btnTag;

@end
@interface RedPacketView : UIView

@property (weak, nonatomic) IBOutlet UILabel *money_liquan;
@property (weak, nonatomic) IBOutlet UIImageView *back_img;
@property (weak, nonatomic) id<RedPacketViewDelegate> delegate;
- (IBAction)cancelBtn:(UIButton *)sender;

- (IBAction)starFaLiQuan:(UIButton *)sender;

@end
