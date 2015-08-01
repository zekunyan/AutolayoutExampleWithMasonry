//
//  Case4ViewController.m
//  MasonryExample
//
//  Created by zorro on 15/7/31.
//  Copyright (c) 2015年 tutuge. All rights reserved.
//

#import "Case4ViewController.h"
#import "Masonry.h"

@interface Case4ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Case4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - Actions

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
