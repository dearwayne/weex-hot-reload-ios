//
//  HRViewController.m
//  WeexHotReload
//
//  Created by 韦其政 on 07/25/2019.
//  Copyright (c) 2019 韦其政. All rights reserved.
//

#import "HRViewController.h"
#import <WeexSDK/WeexSDK.h>

@interface HRViewController ()

@end

@implementation HRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [WXSDKEngine initSDKEnvironment];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *index = @"http://192.168.0.84:8081/dist/index.js";
    WXBaseViewController *vc = [[WXBaseViewController alloc] initWithSourceURL:[NSURL URLWithString:index]];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
