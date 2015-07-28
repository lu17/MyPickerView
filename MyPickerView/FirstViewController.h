//
//  FirstViewController.h
//  MyPickerView
//  QQ:297184181
//  Created by haobao on 13-12-4.
//  Copyright (c) 2013年 haobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPickerView.h"

@interface FirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MyPickerViewDataSource,MyPickerViewDelegate>
{
    
    BOOL ShowPicker;
    NSIndexPath *ShowIndex;

    UITableView *tableview;
    MyPickerView *typePicker;
    NSMutableArray *sectionName;
    NSInteger cellNumber;

}

@end
