//
//  UITextView+MyTextView.m
//  MyViewController
//
//  Created by 杨飞 on 16/9/5.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "UITextView+MyTextView.h"

@implementation UITextView (MyTextView)

- (instancetype)initWithWBBFrame:(CGRect)frame
{
    self = [self initWithFrame:frame];
    if (self) {
    
        //监听文字改变
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged) name:UITextViewTextDidChangeNotification object:nil];
        
        //设置默认颜色
        
        self.placeholderColor = [UIColor grayColor];
        
        self.font = [UIFont systemFontOfSize:14];
        //一直可以往下拖拽
        self.alwaysBounceVertical = YES;
        
        
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)textDidChanged
{
    [self setNeedsDisplay];
}



/**
 *  绘制占位文字(每次调用draw之前 会把之前的擦掉);
 */
- (void)drawRect:(CGRect)rect {
    
    //如果有文字就直接返回 不会只占位文字
    if (self.hasText) return;
    rect.origin.x = 4;
    rect.origin.y = 7;
    rect.size.width -= 2*rect.origin.x;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    [self.placeholder drawInRect:rect withAttributes:attrs];
    
    
    
}

//setter 方法
//
-(void)setPlaceholder:(NSString *)placeholder
{
//    placeholder = self.placeholder;
    self.text = placeholder;
    [self setNeedsDisplay];
}
-(NSString *)placeholder {
    return self.text;
}
-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    self.textColor = placeholderColor;
    [self setNeedsDisplay];
}
- (UIColor *)placeholderColor {
    return self.textColor;
}
//-(void)setText:(NSString *)text
//{
//    [super setText:text];
//    
//    [self setNeedsDisplay];
//}
//-(void)setAttributedText:(NSAttributedString *)attributedText
//{
//    [super setAttributedText:attributedText];
//    
//    [self setNeedsDisplay];
//}
//-(void)setFont:(UIFont *)font
//{
//    [super setFont:font];
//    
//    [self setNeedsDisplay];
//    
//    
//}

@end
