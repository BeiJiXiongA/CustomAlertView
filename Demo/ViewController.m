//
//  ViewController.m
//  Demo
//
//  Created by kongjianjia on 15/8/24.
//  Copyright (c) 2015年 kongjianjia. All rights reserved.
//

#import "ViewController.h"
#import "SHAlterView.h"

#import "AttributedLabel.h"

@interface ViewController ()<SHAlertViewDelegate>
@property (weak, nonatomic) IBOutlet AttributedLabel *demoLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegment;
@property (weak, nonatomic) IBOutlet UISwitch *showCancelSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *array = @[@"123",@"456"];
    NSLog(@"%@",[array componentsJoinedByString:@","]);
    
    [self.demoLabel setAttributedWithString:@"247元/平米/天" keyWord:@"247元" keyWordFont:[UIFont systemFontOfSize:25] keyWordColor:[UIColor redColor]textAlignment:NSTextAlignmentRight];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showAlertView:(UIButton *)sender {
    
//    UIAlertView *al = [[UIAlertView alloc] initWithTitle:@"title" message:@"阿娇分离技术都分了就爱上了房间啊；数量的风景啊撒旦法" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [al show];
    
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:@"title" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"上述开始了缴费" otherButtonTitles:@"SD卡发生罚款",@"阿斯顿发科技啊还是",@"阿三积分等级", nil];
    [ac showInView:self.view];
    
    SHAlterView *alterView = [[SHAlterView alloc] init];
    [alterView showAlterView:self.titleTextField.text message:self.messageTextField.text haveCancel:self.showCancelSwitch.isOn alertViewType:self.typeSegment.selectedSegmentIndex andDelegate:self cancelTitle:@"123" doneTitle:@"797"];
}

-(void)doneButtonClick
{
    NSLog(@"click alert done!");
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
