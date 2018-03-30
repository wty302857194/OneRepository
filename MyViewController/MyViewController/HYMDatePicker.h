//
//  HYMDatePicker.h
//  HYMDatePicker
//
//  Created by 我家有福 on 16/3/10.
//  Copyright © 2016年 我家有福. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HYMDatePickerDelegate;
@interface HYMDatePicker : UIPickerView
@property (strong, nonatomic) id<HYMDatePickerDelegate> delegateDiy;
//已选择时间
@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic) NSString *hour;
@property (strong, nonatomic) NSString *minute;
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
@end

@protocol HYMDatePickerDelegate <NSObject>
@optional
- (void)currentSelectedDate:(NSString *)a;
@end