//
//  CFDeleteTableViewCell.m
//  CFDeleteDemo
//
//  Created by TheMoon on 16/5/11.
//  Copyright © 2016年 CFJ. All rights reserved.
//

#import "CFDeleteTableViewCell.h"
#import "Masonry.h"

@interface CFDeleteTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *moveView;
@property (weak, nonatomic) IBOutlet UIButton *cancel_btn;
@property (weak, nonatomic) IBOutlet UIButton *nothing_btn;


@end


@implementation CFDeleteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.moveView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44);
    
    __weak typeof (self)weakSelf = self;
    [_cancel_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(0);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_top).offset(0);
        make.right.mas_equalTo(weakSelf.contentView.mas_top).offset(0);
        make.width.mas_equalTo(65);
    }];
    [_nothing_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentView.mas_top).offset(0);
        make.bottom.mas_equalTo(weakSelf.contentView.mas_top).offset(0);
        make.width.mas_equalTo(65);
        make.right.mas_equalTo(_cancel_btn.mas_left).offset(0);
    }];
    //添加左滑手势
    UISwipeGestureRecognizer *swipLeft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    swipLeft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.moveView addGestureRecognizer:swipLeft];
    //添加右滑手势
    UISwipeGestureRecognizer *swipRight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swip:)];
    swipRight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.moveView addGestureRecognizer:swipRight];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)swip:(UISwipeGestureRecognizer *)swipe{
   
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        // 打开
        [self openMenu];
        
        // 将其他已打开的关闭
        if( self.mySwipeBlock ){
            self.mySwipeBlock();
        }
    }else if (swipe.direction == UISwipeGestureRecognizerDirectionRight){
        // 关闭
        [self closeMenu];
    }
}

- (IBAction)deleteAction:(UIButton *)sender {
    if(sender.tag == 666){
        // 取消
        [self closeMenu];
        
    }else if (sender.tag == 777){
        // 删除
        if(self.myDeleteBlock){
            self.myDeleteBlock();
        }

    }
}

- (void)openMenu{
    if (self.isOpen) {
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.moveView.center = CGPointMake(self.moveView.center.x - 130, self.moveView.center.y);
    }completion:^(BOOL finished) {
        if(finished){
            self.isOpen = YES;
        }
    }];
}

/**关闭左滑菜单*/
-(void)closeMenu
{
    if(!_isOpen)
        return;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.moveView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, self.moveView.center.y);
    }completion:^(BOOL finished) {
        if (finished) {
            self.isOpen = NO;
        }
    }];
   
}


//- (void)pan:(UIPanGestureRecognizer *)sender
//{
//    typedef NS_ENUM(NSUInteger, UIPanGestureRecognizerDirection) {
//        UIPanGestureRecognizerDirectionUndefined,
//        UIPanGestureRecognizerDirectionUp,
//        UIPanGestureRecognizerDirectionDown,
//        UIPanGestureRecognizerDirectionLeft,
//        UIPanGestureRecognizerDirectionRight
//    };
//    static  UIPanGestureRecognizerDirection direction = UIPanGestureRecognizerDirectionUndefined;
//    switch (sender.state) {
//        case  UIGestureRecognizerStateBegan: {
//            if  (direction == UIPanGestureRecognizerDirectionUndefined) {
//                CGPoint velocity = [sender velocityInView:recognizer.view];
//                BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
//                if (isVerticalGesture) {
//                    if (velocity.y > 0) {
//                        direction = UIPanGestureRecognizerDirectionDown;
//                    }
//                    else  {
//                        direction = UIPanGestureRecognizerDirectionUp;
//                    }
//                }
//                else
//                {
//                    if (velocity.x > 0) {
//                        direction = UIPanGestureRecognizerDirectionRight;
//                    }
//                    else
//                    {
//                        direction = UIPanGestureRecognizerDirectionLeft;
//                    }
//                }
//            }
//            break ;
//        }
//        case UIGestureRecognizerStateChanged: {
//            switch (direction) {
//                case UIPanGestureRecognizerDirectionUp: {
//                    [self handleUpwardsGesture:sender];
//                    break ;
//                }
//                case UIPanGestureRecognizerDirectionDown: {
//                    [self handleDownwardsGesture:sender];
//                    break;
//                }
//                case  UIPanGestureRecognizerDirectionLeft: {
//                    [self handleLeftGesture:sender];
//                    break;
//                }
//                case UIPanGestureRecognizerDirectionRight: {
//                    [self handleRightGesture:sender];
//                    break ;
//                }
//                default : {
//                    break;
//                }
//            }
//            break;
//        }
//        case  UIGestureRecognizerStateEnded: {
//            direction = UIPanGestureRecognizerDirectionUndefined;
//            break;
//        }
//        default:
//            break;
//    }
//}
@end
