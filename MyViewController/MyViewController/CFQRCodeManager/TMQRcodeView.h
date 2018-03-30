//
//  TMQRcodeView.h
//  HLPrivateCustom
//
//  Created by TheMoon on 16/4/8.
//  Copyright © 2016年 zangyunzhu. All rights reserved.
//
//  使用说明：
//  将TMQRcodeView、UIImage+CFQRcode拖入工程
//  导入头文件#import "TMQRcodeView.h"
//  直接调用类方法初始化对象，
//  然后调用对象方法showQRCode进行展示，
//  如果有必要可以调用对象方法dismissQRCode隐藏二维码视图（一般不使用）

#import <UIKit/UIKit.h>

@interface TMQRcodeView : UIView
/**
 *  生成带图片的二维码，有背景遮罩，
 *  二维码的生成方法在自定义的UIImage的分类 (CFQRcode)中
 *
 *  @param content 将被封装的字符串信息
 *  @param picture 二维码中间的小图片
 *
 *  @return 二维码
 */
+ (instancetype)qrCodeViewWithContent:(NSString*)content picture:(UIImage *)picture;
/**
 *  展示二维码
 */
- (void)showQRCode;
/**
 *  隐藏二维码
 */
- (void)dismissQRCode;

@end
