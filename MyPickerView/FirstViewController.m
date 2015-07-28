//
//  FirstViewController.m
//  MyPickerView
//  QQ:297184181
//  Created by haobao on 13-12-4.
//  Copyright (c) 2013年 haobao. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ShowPicker=NO;
    ShowIndex=[NSIndexPath indexPathForRow:100 inSection:100];
    cellNumber=2;
    sectionName=[[NSMutableArray alloc] initWithObjects:@"请选择",@"呼叫中心搜索",@"数据库购买",@"媒体广告线索",@"社区活动线索",@"个人自主拓展",@"老客户转介绍",@"机会活动线索",@"其他", nil];
    if (typePicker == nil) {
        typePicker = [[MyPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
        typePicker.delegate = self;
        typePicker.dataSource=self;
    }
    
    tableview=[[UITableView alloc] initWithFrame:CGRectMake( 0, 0,self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.backgroundView=nil;
    [self.view addSubview:tableview];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return cellNumber;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (ShowPicker&&[indexPath isEqual:ShowIndex] ) {
        
        static NSString *Cellid=@"cellid000";
        
        UITableViewCell *cell1=[tableview dequeueReusableCellWithIdentifier:Cellid];
        if (cell1==nil) {
            cell1=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Cellid] autorelease];
            cell1.selectionStyle=UITableViewCellSelectionStyleNone;
        }
        [cell1.contentView addSubview:typePicker];
        return cell1;
        
    }
    else{
        NSString *CELLID=[NSString stringWithFormat:@"cellid%d",(int)indexPath.row];
        
        UITableViewCell *cell=[tableview dequeueReusableCellWithIdentifier:CELLID];
        if (cell==nil) {
            cell=[[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID] autorelease];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            
        }
        cell.tag=indexPath.row;
        cell.textLabel.font=[UIFont systemFontOfSize:15];
        cell.textLabel.text=@"点击cell显示UIPickerView";
        return cell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 60.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (ShowPicker&&[indexPath isEqual:ShowIndex]) {
        return 216.0f;
    }
    return 40.0f;
}


//pickerView显示
- (void)insertRow:(NSIndexPath *)indexPath
{
    ShowPicker=YES;
    
    [typePicker update];
    
    NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
    
    NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:(indexPath.row+1) inSection:0];
    ShowIndex=indexPathToInsert;
    
    [rowToInsert addObject:indexPathToInsert];
    
    cellNumber=3;
    [tableview beginUpdates];
    
    [tableview insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationLeft];
    [tableview endUpdates];
    
}

//pickerView消失；

- (void)deleteRow:(NSIndexPath *)RowtoDelete
{
    ShowPicker=NO;
    NSMutableArray* rowToDelete = [[NSMutableArray alloc] init];
    NSIndexPath* indexPathToDelete = ShowIndex;
    [rowToDelete addObject:indexPathToDelete];
    cellNumber=2;
    [tableview beginUpdates];
    [tableview deleteRowsAtIndexPaths:rowToDelete withRowAnimation:UITableViewRowAnimationRight];
    [tableview endUpdates];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (!ShowPicker) {
        [self insertRow:indexPath];
    }
    else if(ShowPicker&&([[NSIndexPath indexPathForRow:(ShowIndex.row-1) inSection:0] isEqual:indexPath])){
        
        [self deleteRow:indexPath];
        
    }
    else if ([ShowIndex isEqual:indexPath]&&ShowPicker){
        NSLog(@"点击picker");
    }
    else if(ShowIndex&&![[NSIndexPath indexPathForRow:(ShowIndex.row-1) inSection:0] isEqual:indexPath]){
        
        [self deleteRow:indexPath];
    }
}


#pragma mark MyPickerViewDelegate

- (void)pickerView:(MyPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    NSLog(@"title:%@",[sectionName objectAtIndex:row]);
}


- (NSInteger)numberOfComponentsInPickerView:(MyPickerView *)pickerView
{
    
    return 1;
}

- (NSInteger) pickerView:(MyPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return [sectionName count];
    
}

- (NSString *)pickerView:(MyPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return [sectionName objectAtIndex:row];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
