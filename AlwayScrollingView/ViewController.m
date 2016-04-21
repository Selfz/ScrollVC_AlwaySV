//
//  ViewController.m
//  AlwayScrollingView
//
//  Created by lushouxiang on 15/12/24.
//  Copyright © 2015年 zxw. All rights reserved.
//

#import "ViewController.h"

#import "TEST1Controller.h"

#import "ScrollerVC.h"
#import "TEST2Controller.h"
#import "TEST3Controller.h"
#import "TEST4Controller.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>




@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
        
    [self loadTableView];
    
    
    
}

- (void)loadTableView{
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    [self.view addSubview:tableView];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * identifier = @"cellId";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"无限滚动视图，自动轮播";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"滑动控制器";
    }
    
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIViewController * VC;
    if (indexPath.row == 0) {
        VC = [[TEST1Controller alloc] init];
    }else if (indexPath.row == 1) {
        
///////////////////////////////////////////////////////////////////////////
/////
/////   以下为滚动视图控制器的使用方法
/////
///////////////////////////////////////////////////////////////////////////

        ScrollerVC * SVC = [[ScrollerVC alloc] init];
        SVC.minheadTitleWidth = 200;
        SVC.headTitleHeight = 50;
        
        SVC.count = 4;
        SVC.headTitleArr = @[@"无限滚动",@"标题1",@"标题2",@"标题13"];
        TEST1Controller * t1 = [[TEST1Controller alloc] init];
        TEST2Controller * t2 = [[TEST2Controller alloc] init];
        TEST3Controller * t3 = [[TEST3Controller alloc] init];
        TEST4Controller * t4 = [[TEST4Controller alloc] init];
        SVC.BodyVCArr = @[t1,t2,t3,t4];
        
        VC = SVC;
    }
    [self.navigationController pushViewController:VC animated:YES];
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
