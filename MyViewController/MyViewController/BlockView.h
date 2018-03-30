//
//  BlockView.h
//  MyViewController
//
//  Created by 杨飞 on 16/7/4.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SureBlock) ();
typedef void (^CancleBlock) ();

@interface BlockView : UIView

@property (nonatomic, strong) SureBlock sureBlock;
@property (nonatomic, strong) CancleBlock cancleBlock;

-(void)showBlockView:(SureBlock)sureBlock CancleBlock:(CancleBlock)cancleBlock;

@end
