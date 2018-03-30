//
//  TMQRcodeView.m
//  HLPrivateCustom
//
//  Created by TheMoon on 16/4/8.
//  Copyright © 2016年 zangyunzhu. All rights reserved.
//

#import "TMQRcodeView.h"
#import "UIImage+CFQRcode.h"
/**
 *  屏幕物理高度
 */
#define kScreenHeight  CGRectGetHeight([UIScreen mainScreen].bounds)
/**
 *  屏幕物理宽度
 */
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
/**
 *  设置颜色RGB值
 */
#define RGBCOLOR(r,g,b,_alpha) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:_alpha]

/**
 *  二维码尺寸占self尺寸的比例
 */
static const CGFloat qrScale = 190.0/280;
/**
 *  self与屏幕左右间隔
 */
static const CGFloat myMargin = 20.0;

static CGFloat  myHeight;
static CGFloat  myWidth;

@interface TMQRcodeView ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, strong) UIImageView *qrImageView;
@property (nonatomic, strong) UILabel *msgLabel;
@property (nonatomic, strong) UIView *maskView;

@end

@implementation TMQRcodeView

+ (instancetype)qrCodeViewWithContent:(NSString *)content picture:(UIImage *)picture{
    
    TMQRcodeView *qrCodeView = [[NSBundle mainBundle] loadNibNamed:@"TMQRcodeView" owner:self options:nil].lastObject;
    
    [qrCodeView doWithCreateUIWithContent:content picture:picture];
    
    return qrCodeView;
}

#pragma mark - 显示
- (void)showQRCode{
    // 遮罩
    self.maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.maskView.backgroundColor = [UIColor blackColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShadeViewAction)];
    [self.maskView addGestureRecognizer:tap];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.maskView];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    self.maskView.alpha = 0;
    self.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.maskView.alpha = 0.3;
        self.alpha = 1;
    }];
}

#pragma mark - 隐藏
- (void)dismissQRCode{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
        self.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.maskView removeFromSuperview];
    }];
}


#pragma mark - tap 遮罩
- (void)tapShadeViewAction{
    [self dismissQRCode];
}



#pragma mark - UI布局
- (void)doWithCreateUIWithContent:(NSString *)content picture:(UIImage *)picture{
    
    // 计算尺寸
    myWidth = kScreenWidth - 2 * myMargin;
    
    NSString *msg = @"扫一扫上面的二维码，查看活动";
//    CGFloat hight = [msg boundingRectWithSize:CGSizeMake(myWidth * qrScale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
    CGFloat msgH = [msg boundingRectWithSize:CGSizeMake(myWidth * qrScale, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.height;
    // 二维码距离上部比左、右、下多5
    myHeight = myWidth + 10 + msgH + 5;
    
    // 二维码边界距离，同时也是中间图片的size
    CGFloat margin = (myWidth - (myWidth * qrScale))/2;
    
    // 为iPhone4s时，top改变
    static CGFloat  top = 64 + 135/2.0;
    if (kScreenWidth == 320) {
        top = (kScreenHeight - myHeight)/2.0;
    }
    
    self.frame = CGRectMake(myMargin, top, myWidth, myHeight);
    self.bgView.layer.cornerRadius = 10.0;
    
    // 二维码
    self.qrImageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin+5, myWidth * qrScale, myWidth * qrScale)];
    __weak typeof (self) weakSelf = self;
    UIImage * icon = picture ? : [UIImage imageNamed:@""];
    // 生成带图片的二维码
    [UIImage qrImageWithString:content size:myWidth * qrScale iconImage:icon scale: margin/(myWidth * qrScale) completion:^(UIImage *image) {
        weakSelf.qrImageView.image = image;
    }];
    
   [self.bgView addSubview:self.qrImageView];
    
    // 提示信息
    self.msgLabel = [[UILabel alloc] init];
    self.msgLabel.text = msg;
    self.msgLabel.frame = CGRectMake(CGRectGetMinX(self.qrImageView.frame), CGRectGetMaxY(self.qrImageView.frame) + 10, CGRectGetWidth(self.qrImageView.frame), msgH);
    self.msgLabel.numberOfLines = 0;
    self.msgLabel.textAlignment = NSTextAlignmentCenter;
    self.msgLabel.font = [UIFont systemFontOfSize:16];
    [self.bgView addSubview:self.msgLabel];
}





@end
