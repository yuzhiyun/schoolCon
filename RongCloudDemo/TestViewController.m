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

@implementation TestViewController{
    
    //当前题目index
    int indexOfExercise;
    //当前题目被选中答案的index
    int indexOfAnswer;
    //来自服务器的所有题目数据
    NSMutableArray *mAllData;
    //用于刷新tableView
    UITableView *mTableView;
    
    //    int answerArray
    NSMutableArray *answerArray;
//    int answerArray[200];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    answerArray={1};
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
    
    [mEntity addObject:@"1、你是一个没有安全感的人吗？"];
    [mEntity addObject:@"是的"];
    [mEntity addObject:@"不是"];
    [mEntity addObject:@"一直都有安全感"];
    [mEntity addObject:@"偶尔"];
    
    [mAllData addObject:mEntity];
    
    NSMutableArray *mEntity2=[[NSMutableArray alloc]init];
    
    [mEntity2 addObject:@"2、你在面试中常常紧张的不知所措吗？"];
    [mEntity2 addObject:@"是的"];
    [mEntity2 addObject:@"不是"];
    [mEntity2 addObject:@"看具体情况"];
    [mEntity2 addObject:@"非常紧张，脑袋一片空白"];
    [mEntity2 addObject:@"偶尔"];
    [mEntity2 addObject:@"非常自信，不会紧张"];
    
    [mAllData addObject:mEntity2];
    NSMutableArray *mEntity3=[[NSMutableArray alloc]init];
    
    [mEntity3 addObject:@"3、你是一个怀旧的人吗？"];
    [mEntity3 addObject:@"是的"];
    [mEntity3 addObject:@"不是"];
    [mEntity3 addObject:@"不一定"];
    [mEntity3 addObject:@"有时候会"];
    
    [mAllData addObject:mEntity3];
     [self setTitle];
    
    
//    answerArray=[NSMutableArray arrayWithCapacity:[mAllData count]];
    answerArray=[[NSMutableArray alloc]init];
//    NSLog(@"answerArray的大小%d",[answerArray count]);
   
    
    //填充-1到答案数组里面,之所以使用这种for循环，是因为i是int，[mAllData count]转不过来
    for(NSString *s in mAllData){
        NSLog(@"插入数据");
        [answerArray addObject:@"-1"];
    }
    
    NSLog(@"answerArray的大小%i",[answerArray count]);
//    [answerArray insertObject:@"1" atIndex:2];
//    [answerArray removeObjectAtIndex:3];
////
//    for(NSString *s in answerArray)
//        NSLog(s);
    
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
    
    
    if(indexOfAnswer==indexPath.row|| [[answerArray objectAtIndex:indexOfExercise]isEqualToString:[NSString stringWithFormat: @"%i",indexPath.row]])
        cell.UIImageViewCheckbox.image=[UIImage imageNamed:@"selected2.png"];
    else
        cell.UIImageViewCheckbox.image=[UIImage imageNamed:@"un_selected.png"];
    
    
    return cell;
}

- (IBAction)lastExercise:(id)sender {
    if(-1==indexOfAnswer && [[answerArray objectAtIndex:indexOfExercise]isEqualToString:[NSString stringWithFormat: @"%i",-1]]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请先作答此题，才能切换题目"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        indexOfExercise--;
        if(indexOfExercise>=0){
            [self setTitle];
            //所有item置于不被选中状态
            indexOfAnswer=-1;
            [mTableView reloadData];
        }
        else{
            indexOfExercise++;
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"这已经是第一题了"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
    
}


//切换到下一个题目
- (IBAction)nextExercise:(id)sender {
    if(-1==indexOfAnswer && [[answerArray objectAtIndex:indexOfExercise]isEqualToString:[NSString stringWithFormat: @"%i",-1]]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请先作答此题，才能切换题目"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        indexOfExercise++;
        if(indexOfExercise<[mAllData count]){
            [self setTitle];
            //所有item置于不被选中状态
            indexOfAnswer=-1;
            [mTableView reloadData];
        }
        else{
            indexOfExercise--;
            
            
            for(NSString *answer in answerArray)
                NSLog(@"答案是%@",answerArray);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"已经是最后一题了，请提交答案"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

//把checkbox的图标改成被选中的
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    TestTableViewCell *cell=(TestTableViewCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    //    self tableView:<#(nonnull UITableView *)#> cellForRowAtIndexPath:<#(nonnull NSIndexPath *)#>
    
    //如果和上一次点击同一个item，就取消掉那个item被选中状态
    if(indexPath.row==indexOfAnswer){
        indexOfAnswer=-1;
        [answerArray insertObject:@"-1" atIndex:indexOfExercise];
        [answerArray removeObjectAtIndex:indexOfExercise+1];
    }
    
    else{
        //选中被点击item
        indexOfAnswer=indexPath.row;
        //数字int转为string
        NSString *answer=[NSString stringWithFormat: @"%i",indexOfAnswer];
        [answerArray insertObject:answer atIndex:indexOfExercise];
        [answerArray removeObjectAtIndex:indexOfExercise+1];
    }
    [mTableView reloadData];
}

@end
