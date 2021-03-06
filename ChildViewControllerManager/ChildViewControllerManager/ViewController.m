//
//  ViewController.m
//  ChildVCDemo
//
//  Created by 廖登科 on 17/7/21.
//  Copyright © 2017年 dengkel. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "LastViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIViewController *currentVC;
@property(nonatomic,strong)FirstViewController *firstVC;
@property(nonatomic,strong)SecondViewController *secondVC;
@property(nonatomic,strong)LastViewController *lastVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"First";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(buttonAction:)];
    
    FirstViewController *firstVC = [[FirstViewController alloc] init];
    [self.view addSubview:firstVC.view];
    [self addChildViewController:firstVC];
    
    self.currentVC = firstVC;
}

- (FirstViewController *)firstVC {
    if (!_firstVC) {
        _firstVC = [[FirstViewController alloc] init];
    }
    return _firstVC;
}

- (SecondViewController *)secondVC {
    if (!_secondVC) {
        _secondVC = [[SecondViewController alloc] init];
    }
    return _secondVC;
}

- (LastViewController*)lastVC {
    if (!_lastVC) {
        _lastVC = [[LastViewController alloc] init];
    }
    return _lastVC;
}

- (void)buttonAction:(UIBarButtonItem *)bbi {
    bbi.enabled = NO;
    UIViewController *vc = nil;
    do {
        NSInteger index = arc4random()%3;
        if (index == 0)
            vc = self.firstVC;
        else if (index == 1)
            vc = self.secondVC;
        else
            vc = self.lastVC;
    } while (vc == self.currentVC);
    [self replaceController:self.currentVC newController:vc];
}

- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController {
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.4 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            self.title = newController.title;
        } else {
            self.currentVC = oldController;
            self.title = oldController.title;
        }
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
