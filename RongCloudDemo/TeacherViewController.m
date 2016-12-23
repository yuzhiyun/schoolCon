//
//  TeacherViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/21.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "TeacherViewController.h"

@interface TeacherViewController ()

@end

@implementation TeacherViewController
{
    
    NSMutableArray *recipes;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    recipes=[[NSMutableArray alloc]init];
    [recipes addObject:@"由于下大雪，今晚不用上课"];
    [recipes addObject:@"由于下大雪，今晚不用上课"];
    [recipes addObject:@"由于下大雪，今晚不用上课"];
    [recipes addObject:@"由于下大雪，今晚不用上课"];
    [recipes addObject:@"由于下大雪，今晚不用上课"];
    [recipes addObject:@"由于下大雪，今晚不用上课"];
    [recipes addObject:@"由于下大雪，今晚不用上课"];
    [recipes addObject:@"由于下大雪，今晚不用上课"];
    [recipes addObject:@"由于下大雪，今晚不用上课"];
    //    recipes = [NSArray arrayWithObjects:@"Egg Benedict",@"Ham and Cheese Panini","yuzhiyun",nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [recipes count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
//    if(nil==cell)
//        cell=[[UICollectionViewCell alloc]init];
    
    if (cell.layer.cornerRadius!=8){
        cell.layer.cornerRadius=8;
        cell.layer.masksToBounds=YES;
        
    }
    
    
    //通过tag获取单元格内部的控件，当前事先要给每一个控件设定一个tag,这就和TableViewCell不一样了，不需要自定义一个类
    UILabel *mUILabelGrade=(UILabel *)[cell viewWithTag:1];
    mUILabelGrade.text=@"100分";
    return cell;
}

@end
