//
//  ListTableView.h
//  MyViewController
//
//  Created by 杨飞 on 16/5/25.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tab_view;

@end
