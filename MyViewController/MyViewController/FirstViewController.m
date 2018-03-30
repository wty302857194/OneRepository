//
//  FirstViewController.m
//  MyViewController
//
//  Created by 杨飞 on 16/4/19.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "FirstViewController.h"
#import "ZYKeyboardUtil.h"
@interface FirstViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *text_view;
@property (weak, nonatomic) IBOutlet UITextField *first_tf;
@property (weak, nonatomic) IBOutlet UITextField *second_tf;
@property (weak, nonatomic) IBOutlet UITextField *third_tf;
@property (weak, nonatomic) IBOutlet UITextField *fourth_tf;
@property (strong, nonatomic) ZYKeyboardUtil *keyboardUtil;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.text_view.delegate = self;
    self.first_tf.delegate = self;
    self.second_tf.delegate = self;
    self.third_tf.delegate = self;
    self.fourth_tf.delegate = self;
    [self keyBoardRespond];
    
    
      [self.navigationController setToolbarHidden:NO];
    
    
}
- (void)keyBoardRespond {
    self.keyboardUtil = [[ZYKeyboardUtil alloc] init];
    
    __weak FirstViewController *weakSelf = self;
//    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
//        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.inputViewBorderView, weakSelf.secondTextField, weakSelf.thirdTextField, nil];
//    }];
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.text_view,weakSelf.first_tf,weakSelf.second_tf,weakSelf.third_tf,weakSelf.fourth_tf, nil];
    }];
    
    //获取键盘信息
//    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
//        NSLog(@"\n\n拿到键盘信息 和 ZYKeyboardUtil对象");
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark delegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.mainTextField resignFirstResponder];
//    [self.secondTextField resignFirstResponder];
//    [self.thirdTextField resignFirstResponder];
    [self.view endEditing:YES];
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
