//
//  TuoDongViewController.m
//  MyViewController
//
//  Created by 杨飞 on 16/7/7.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "TuoDongViewController.h"
#import "TMQRcodeView.h"
#import "UIImage+CFQRcode.h"
#import "RMDownloadIndicator.h"
#import "ZMProgressView.h"
#import "FSTextView.h"
#import "ZYKeyboardUtil.h"
@interface TuoDongViewController ()<UITextViewDelegate>
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;
@property (weak, nonatomic) RMDownloadIndicator *closedIndicator;

@property (nonatomic,strong)ZMProgressView *myProgressView;
@property (nonatomic, strong)FSTextView *text_view;
@end

@implementation TuoDongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof (self) weakSelf = self;
    [UIImage qrImageWithString:@"吴棒棒，吴棒棒~" size:CGRectGetWidth(self.img_view.frame) iconImage:[UIImage imageNamed:@"CF_ICON.png"] completion:^(UIImage *image) {
        weakSelf.img_view.image = image;
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBegin)];
    tap.numberOfTapsRequired = 1;
    _img_view.userInteractionEnabled = YES;
    [_img_view addGestureRecognizer:tap];
    
    // 限制输入最大字符数.
    self.text_view.maxLength = 10;
    // 弱化引用, 以免造成内存泄露.
//    __weak __typeof(&*noticeLabel)weakNoticeLabel = noticeLabel;
    // 添加输入改变Block回调.
    [self.text_view addTextDidChangeHandler:^(FSTextView *textView) {
//        (textView.text.length < textView.maxLength) ? weakNoticeLabel.text = @"":NULL;
    }];
    // 添加到达最大限制Block回调.
    [self.text_view addTextLengthDidMaxHandler:^(FSTextView *textView) {
//        weakNoticeLabel.text = [NSString stringWithFormat:@"最多限制输入%zi个字符", textView.maxLength];
    }];
    
    
    
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.text_view, nil];
    }];
    
    [self progressView];
    
    [self ZMProgressView];
}
- (UITextView *)text_view {
    if (!_text_view) {
        _text_view = [[FSTextView alloc] initWithFrame:CGRectMake(20,SCREENH_HEIGHT-200,  SCREEN_WIDTH-40, 150)];
        _text_view.placeholder = @"这是一个继承于UITextView的带Placeholder的自定义TextView, 可以设定限制字符长度, 以Block形式回调, 简单直观 !";
        _text_view.borderWidth = 1.f;
        _text_view.borderColor = UIColor.lightGrayColor;
        _text_view.cornerRadius = 5.f;
        [self.view addSubview:_text_view];
        
        
    }
    return _text_view;
}
- (void)ZMProgressView {
    ZMProgressView* progressView = [[ZMProgressView alloc] initWithLineColor:[UIColor orangeColor] loopColor:[UIColor lightGrayColor]];
    
    
    //引用
    self.myProgressView = progressView;
    //设置frame
    progressView.frame = CGRectMake(50, 50, 200, 200);
    
    
    //开启动画（可选,建议在百分比前面设置，否则一开始没有动画）
    progressView.animatable = YES;
    //百分比，超过100，按照100算
    self.myProgressView.percent = 50;
    
    progressView.centerImg = [UIImage imageNamed:@"CF_ICON"];
    //属性可选的，可以不设置，设置透明就是圆环
    progressView.backgroundColor = [UIColor clearColor];
    //设置标题
    self.myProgressView.title = @"本次得分";
    //设置单位
    self.myProgressView.percentUnit = @"分";
    
    [self.view addSubview:self.myProgressView];
    
    
    
    
    UIImageView *img_view = [[UIImageView alloc] initWithFrame:CGRectMake(222, 222, 17, 17)];
    img_view.image = [UIImage imageNamed:@"jia03"];
    [self.view addSubview:img_view];
}

- (void)progressView {
    RMDownloadIndicator *closedIndicator = [[RMDownloadIndicator alloc]initWithFrame:self.progress_view.bounds type:kRMClosedIndicator];
    [closedIndicator setBackgroundColor:[UIColor whiteColor]];
    
    [closedIndicator setFillColor:[UIColor yellowColor]];
    [closedIndicator setStrokeColor:[UIColor purpleColor]];
    closedIndicator.clipsToBounds = YES;
    closedIndicator.radiusPercent = 0.5;
    closedIndicator.coverWidth = 10;
    [self.progress_view addSubview:closedIndicator];
    [closedIndicator loadIndicator];
    _closedIndicator = closedIndicator;
    
    UIImageView * img_view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(closedIndicator.frame)-20, CGRectGetHeight(closedIndicator.frame)-20)];
    img_view.center = closedIndicator.center;
    img_view.image = [UIImage imageNamed:@"CF_ICON"];
    LRViewBorderRadius(img_view, (CGRectGetWidth(closedIndicator.frame)-20)/2, 0, [UIColor clearColor]);
    [closedIndicator addSubview:img_view];
    
    [self updateViewOneTime];
}
- (void)updateViewOneTime
{
    [_closedIndicator setIndicatorAnimationDuration:1.0];
    
    [_closedIndicator updateWithTotalBytes:100 downloadedBytes:50];
}
- (void)touchBegin {
    TMQRcodeView *qrCodeView = [TMQRcodeView qrCodeViewWithContent:@"这是二维码。。。。。" picture:[UIImage imageNamed:@"weixin.jpg"]];
    
    [qrCodeView showQRCode];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
