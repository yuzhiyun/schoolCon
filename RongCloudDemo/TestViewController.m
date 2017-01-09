//
//  TestViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/21.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "TestViewController.h"
#import "TestTableViewCell.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=pubString;
    self.title=@"心理测试";
    
    
    //    默认显示第一个题目
    indexOfExercise=0;
    //默认没有答案被选中
    indexOfAnswer=-1;
    //    填充题目
    mAllData=[[NSMutableArray alloc]init];
    
//    for(int i=0;i<5;i++){
        NSMutableArray *mEntity=[[NSMutableArray alloc]init];
        
//        [mEntity addObject:[NSString stringWithFormat:@"标题%d",i+1]];
//        
//        [mEntity addObject:[NSString stringWithFormat:@"第%d题item1",i+1]];
//        [mEntity addObject:[NSString stringWithFormat:@"第%d题item2",i+1]];
//        [mEntity addObject:[NSString stringWithFormat:@"第%d题item3",i+1]];
//        [mEntity addObject:[NSString stringWithFormat:@"第%d题item4",i+1]];
        
        [mEntity addObject:@"1、你是一个没有安全感的人吗？"];
        [mEntity addObject:@"是的"];
        [mEntity addObject:@"不是"];
        [mEntity addObject:@"一直都有安全感"];
        [mEntity addObject:@"偶尔"];
        
//        [mEntity addObject:[NSString stringWithFormat:@"第%d题item1",i+1]];
//        [mEntity addObject:[NSString stringWithFormat:@"第%d题item2",i+1]];
//        [mEntity addObject:[NSString stringWithFormat:@"第%d题item3",i+1]];
//        [mEntity addObject:[NSString stringWithFormat:@"第%d题item4",i+1]];
        [mAllData addObject:mEntity];
    
    NSMutableArray *mEntity2=[[NSMutableArray alloc]init];
    
    [mEntity2 addObject:@"2、第二题标题？"];
    [mEntity2 addObject:@"第二题标题选项1"];
    [mEntity2 addObject:@"第二题标题选项2"];
    [mEntity2 addObject:@"第二题标题选项3"];
    [mEntity2 addObject:@"第二题标题选项4"];
        [mEntity2 addObject:@"第二题标题选项5"];
        [mEntity2 addObject:@"第二题标题选项6"];

    [mAllData addObject:mEntity2];
    
    
    
        
//    }
    
    [self setTitle];
    
}

-(void) setTitle{
    UILabelTitle.text=[[mAllData objectAtIndex:indexOfExercise] objectAtIndex:0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //    此处存储一下这个tableView，以便在切换到下一个题目的时候，reload数据
    mTableView=tableView;
#warning Incomplete implementation, return the number of rows
    return [[mAllData  objectAtIndex:indexOfExercise] count]-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(cell==nil){
        
        cell=[[TestTableViewCell init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    NSMutableArray *mEntity=[mAllData objectAtIndex:indexOfExercise];
    
    
    //    NSString *t1=[mTitle objectAtIndex:indexPath.row];
    //    [mItem1 objectAtIndex:indexOfExercise]
    
    cell.UILabelExerciseItem.text=[mEntity objectAtIndex:indexPath.row+1];
    
    
    if(indexOfAnswer==indexPath.row)
        cell.UIImageViewCheckbox.image=[UIImage imageNamed:@"selected2.png"];
    else
          cell.UIImageViewCheckbox.image=[UIImage imageNamed:@"un_selected.png"];
        
    
    return cell;
}
//切换到下一个题目
- (IBAction)nextExercise:(id)sender {
    
    indexOfExercise++;
    if(indexOfExercise<[mAllData count]){
        [self setTitle];
        //所有item置于不被选中状态
        indexOfAnswer=-1;
        [mTableView reloadData];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"已经是最后一题了，请提交答案"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

//把checkbox的图标改成被选中的
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TestTableViewCell *cell=(TestTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    //    self tableView:<#(nonnull UITableView *)#> cellForRowAtIndexPath:<#(nonnull NSIndexPath *)#>
    
    //如果和上一次点击同一个item，就取消掉那个item被选中状态
    if(indexPath.row==indexOfAnswer)
        indexOfAnswer=-1;
    else{
        //选中被点击item
        indexOfAnswer=indexPath.row;
    }
    [mTableView reloadData];
}

@end
