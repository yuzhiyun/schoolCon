//
//  OptionViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/21.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "OptionViewController.h"

@interface OptionViewController ()

@end

@implementation OptionViewController{
    
    NSMutableArray *mClasses;
    NSMutableArray *mSubjects;
//    NSMutableArray *mChoices;
    NSInteger classSelected;
    NSInteger subjectedSelected;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    classSelected=0;
    subjectedSelected=0;
//    mChoices=[[NSMutableArray alloc]init];

    mClasses=[[NSMutableArray alloc]init];
    [mClasses addObject:@"1班"];
    [mClasses addObject:@"2班"];
    [mClasses addObject:@"3班"];
    [mClasses addObject:@"4班"];
    [mClasses addObject:@"5班"];
    
    mSubjects=[[NSMutableArray alloc]init];
    [mSubjects addObject:@"数学"];
    [mSubjects addObject:@"语文"];
    [mSubjects addObject:@"化学"];
    [mSubjects addObject:@"英语"];
    [mSubjects addObject:@"历史"];
    [mSubjects addObject:@"生物"];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//获取到被选择的item
- (IBAction)getOption:(id)sender {
    
    NSString *class=[mClasses objectAtIndex:classSelected];
    NSString *subjectedSelected=[mSubjects objectAtIndex:subjectedSelected];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:[NSString stringWithFormat:@"班级是%@，科目是%@",class,subjectedSelected]
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
    
    
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(0==component)
        return [mClasses count];
    else
        return [mSubjects count];
    
    
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component __TVOS_PROHIBITED{

    if(0==component)
        return [mClasses objectAtIndex:row];
    else
        return [mSubjects objectAtIndex:row];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component __TVOS_PROHIBITED{
    
    
    if(0==component)
        classSelected=row;
    else
        subjectedSelected=row;
    
    
    
    
    

    

}



@end




