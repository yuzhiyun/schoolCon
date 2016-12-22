//
//  ArticleDetailViewController.m
//  RongCloudDemo
//
//  Created by 秦启飞 on 2016/12/16.
//  Copyright © 2016年 dlz. All rights reserved.
//

#import "ArticleDetailViewController.h"
#import "CommentTableViewCell.h"
@interface ArticleDetailViewController ()

@end

@implementation ArticleDetailViewController{
    
    NSMutableArray *mDataUsername;
    //    NSMutableArray *mDataDate;
    NSMutableArray *mDataCommentContent;
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=pubString;
    
    mDataUsername=[[NSMutableArray alloc]init];
    [mDataUsername addObject:@"俞志云"];
    [mDataUsername addObject:@"马小龙"];
    [mDataUsername addObject:@"孙萌"];
    [mDataUsername addObject:@"吴晓茎"];
    [mDataUsername addObject:@"秦启飞"];
    
    mDataCommentContent=[[NSMutableArray alloc]init];
    [mDataCommentContent addObject:@"这篇文章写的非常不错"];
    [mDataCommentContent addObject:@"作者很有文化底蕴"];
    [mDataCommentContent addObject:@"我知道，这是一位北大的知名学者"];
    [mDataCommentContent addObject:@"很好的解决了我的困惑"];
    [mDataCommentContent addObject:@"文章说出了我的心里话"];
    
    
    //    mDataUsername=[[NSMutableArray alloc]init];
    //    [mDataUsername addObject:@"俞志云"];
    //    [mDataUsername addObject:@"马小龙"];
    //    [mDataUsername addObject:@"孙萌"];
    //    [mDataUsername addObject:@"吴晓茎"];
    //    [mDataUsername addObject:@"秦启飞"];
    
    
    //    recipes = [NSArray arrayWithObjects:@"Egg Benedict",@"Ham and Cheese Panini","yuzhiyun",nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
//    self.title=pubString;
    // Dispose of any resources that can be recreated.
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [mDataUsername count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"commentCell";
    
    CommentTableViewCell *cell = (CommentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.UILabelUsername.text = [mDataUsername objectAtIndex:indexPath.row];
    cell.UILabelCommentContent.text = [mDataCommentContent objectAtIndex:indexPath.row];
    cell.UILabelDate.text = @"2016/12/23";
    cell.UIImgAvarta.image=[UIImage imageNamed:@"avarta.jpg"];
    
    
    return cell;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
