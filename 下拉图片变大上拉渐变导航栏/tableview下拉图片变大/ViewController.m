//
//  ViewController.m
//  tableview下拉图片变大
//
//  Created by chinajes on 2017/5/16.
//  Copyright © 2017年 chinajes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic, weak)UIImageView *imageView;
// 导航条背景imageview
@property(nonatomic, weak)UIImageView *barImageView;

@property(nonatomic, weak)UITableView *tableView;
// 流星图片
@property(nonatomic, weak)UIImageView *liuXingView;

@property(nonatomic, weak)UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    
    [self.view addSubview:tableView];
    
    tableView.backgroundColor = [UIColor greenColor];
  
    tableView.dataSource = self;
    
    tableView.delegate = self;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"hahaha" style:UIBarButtonItemStylePlain target:self action:nil];
    
    self.navigationItem.leftBarButtonItem = item;
    
    // 设置视图不自动下移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 设置导航栏为颜色
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];


    // 设置导航栏透明
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
    // 设置去掉导航栏下面的黑线
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    // 获取负责导航栏颜色显示的UIImageView
    UIImageView *barImageView = self.navigationController.navigationBar.subviews.firstObject;
    
    self.barImageView = barImageView;
    
    self.barImageView.alpha = 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250)];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:view.bounds];
    
    self.imageView = imageView;
    
    [view addSubview:imageView];
    
    imageView.image = [UIImage imageNamed:@"02"];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 200, 50, 20)];
    
    label.text = @"JS";
    
    self.label = label;
    
    [view addSubview:label];
    
    CGFloat lWidth = [UIScreen mainScreen].bounds.size.width;
    UIImageView *liuXingView = [[UIImageView alloc]initWithFrame:CGRectMake(lWidth - 120, 40, 100, 20)];
    
    liuXingView.image = [UIImage imageNamed:@"00"];
    
    self.liuXingView = liuXingView;
    
    [view addSubview:liuXingView];
    return view;
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    // 偏移量上移0~200之间根据偏移量计算透明度
    if (scrollView.contentOffset.y > 0 && scrollView.contentOffset.y <= 200) {

        self.barImageView.alpha = scrollView.contentOffset.y / 200;
        
         NSLog(@"%f",scrollView.contentOffset.y);
        
         NSLog(@"-----^^^^%f",self.barImageView.alpha);
        
        self.label.frame = CGRectMake(scrollView.contentOffset.y + 20, 200, 50, 20);
        
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.label];
        
        // 超过200设置为不透明,防止快速滑动导致透明度不正确问题
    }else if(scrollView.contentOffset.y > 200){
        
        self.barImageView.alpha = 1;
        
    // 下拉超过范围固定偏移量
    }else if(scrollView.contentOffset.y < -100){
        

        scrollView.contentOffset = CGPointMake(0, -100);
        
    }else{
        
        CGFloat contentOffsetY = ABS(scrollView.contentOffset.y);
        
        // 下拉根据偏移设置图片放大,并设置透明
        self.imageView.frame = CGRectMake(-contentOffsetY, -contentOffsetY, [UIScreen mainScreen].bounds.size.width + 2 * contentOffsetY, contentOffsetY + 250);
        
        self.barImageView.alpha = 0;
        
        NSLog(@"%f",scrollView.contentOffset.y);
        
        CGFloat lWidth = [UIScreen mainScreen].bounds.size.width;
        
        self.liuXingView.frame = CGRectMake(lWidth - 120 - ABS(scrollView.contentOffset.y) * 1.2, 40 + ABS(scrollView.contentOffset.y)*1.2, 100, 20);

    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 200;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = @"国服第一JS";
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
