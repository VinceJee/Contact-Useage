//
//  ViewController.m
//  Contact Demo
//
//  Created by VinceJee on 2017/8/17.
//  Copyright © 2017年 VinceJee. All rights reserved.
//

#import "ViewController.h"

#import "ContactManager.h"

@interface ViewController ()<CNContactViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [ContactManager showContactViewControllerWithContact:[ContactManager createContactPerson] viewController:self];
}

- (void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(CNContact *)contact {
 }

- (BOOL)contactViewController:(CNContactViewController *)viewController shouldPerformDefaultActionForContactProperty:(CNContactProperty *)property {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
