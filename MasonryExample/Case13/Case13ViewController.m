//
//  Case13ViewController.m
//  MasonryExample
//
//  Created by tutuge on 2016/11/6.
//  Copyright © 2016年 tutuge. All rights reserved.
//

#import "Case13ViewController.h"
#import "Case13TableViewCell.h"

@interface Case13ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <NSArray <NSString *> *> *data;
@end

@implementation Case13ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // tableView
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 80;
    [_tableView registerClass:[Case13TableViewCell class] forCellReuseIdentifier:kCase13TableViewCellIdentifier];
    
    // 生成数据
    NSString *string = @"Masonry is a light-weight layout framework which wraps AutoLayout with a nicer syntax.";
    _data = [NSMutableArray new];
    
    for (NSInteger i = 0; i < 20; i++) {
        NSMutableArray *cellTexts = [NSMutableArray new];
        for (NSInteger j = 0; j < 3; j++) {
            [cellTexts addObject:[string substringToIndex:arc4random_uniform((uint32_t)string.length)]];
        }
        [_data addObject:cellTexts];
    }
    
    // 刷新
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Case13TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCase13TableViewCellIdentifier forIndexPath:indexPath];
    [cell configWithTexts:_data[indexPath.row]];
    return cell;
}

@end
