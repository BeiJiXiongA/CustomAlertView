//
//  FirstViewController.m
//  Demo
//
//  Created by ZhangWei-SpaceHome on 15/8/27.
//  Copyright (c) 2015年 kongjianjia. All rights reserved.
//

#import "FirstViewController.h"
#import "LongPressView.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "CustomTableViewCell.h"
#import "UIImage+ImageFromColor.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface FirstViewController ()
{
    UILabel *tipLabel;
    __weak IBOutlet LongPressView *longPressView;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tipLabel = [[UILabel alloc] init];
    tipLabel.backgroundColor = [UIColor yellowColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.frame = CGRectMake(100, 100, 200, 100);
    tipLabel.numberOfLines = 9999;
    tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
    tipLabel.text = @"视图提示！视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示视图提示";
    CGSize size = [tipLabel sizeThatFits:CGSizeMake(SCREEN_WIDTH-200, 100000)];
    tipLabel.frame = CGRectMake(CGRectGetMinX(tipLabel.frame), CGRectGetMinY(tipLabel.frame), size.width, size.height);
//    [self.view addSubview:tipLabel];
    
    longPressView.iconImageName = @"food";
    longPressView.titleString = @"餐饮12家";
    longPressView.tipString = @"餐饮";
    [longPressView layoutViews];
    [self.view addSubview:longPressView];
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        [self.demoImageView sd_setImageWithURL:[NSURL URLWithString:@"http://www1.chnindustry.cn/Public/Uploads/mobiletuijian/wjsoho.jpg"] placeholderImage:[UIImage imageNamed:@"doubt"]];
    }];
    
    
//    for (int i = 0; i<3; i++) {
//        CustomTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:nil options:nil] objectAtIndex:0];
//        cell.frame = CGRectMake(0, CGRectGetMaxY(longPressView.frame)+95*i, SCREEN_WIDTH, 90);
//        [self.view addSubview:cell];
//    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
//    设置navigationbar的背景图,图片弄一张完成透明的图就行。
    
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[[UIColor redColor] colorWithAlphaComponent:0.5f]] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5f]]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
