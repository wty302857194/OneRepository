//
//  UITextView+MyTextView.h
//  MyViewController
//
//  Created by 杨飞 on 16/9/5.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (MyTextView)
/** 占位文字 */
@property (nonatomic, copy)NSString *placeholder;
/** 占位文字颜色 */
@property (nonatomic, strong)UIColor *placeholderColor;
- (instancetype)initWithWBBFrame:(CGRect)frame;

@end
