//
//  Case4ViewController.m
//  MasonryExample
//
//  Created by zorro on 15/7/31.
//  Copyright (c) 2015年 tutuge. All rights reserved.
//

#import "Case4ViewController.h"
#import "Case4Cell.h"
#import "Case4DataEntity.h"

@interface Case4ViewController () <UITableViewDelegate, UITableViewDataSource>
@property(weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic, strong) NSArray *data;

@end

@implementation Case4ViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 80.0f;

    // 注册Cell
    [_tableView registerClass:[Case4Cell class] forCellReuseIdentifier:NSStringFromClass([Case4Cell class])];

    [self generateData];

    [_tableView reloadData];
}

#pragma mark - Actions

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static Case4Cell *templateCell;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        templateCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Case4Cell class])];
    });

    // 获取对应的数据
    Case4DataEntity *dataEntity = _data[(NSUInteger) indexPath.row];

    // 填充数据
    [templateCell setupData:dataEntity];

    // 判断高度是否已经计算过
    if (dataEntity.cellHeight <= 0) {
        // 根据当前数据，计算Cell的高度，注意+1
        dataEntity.cellHeight = [templateCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
        NSLog(@"Calculate height: %ld", (long)indexPath.row);
    } else {
        NSLog(@"Get cache %ld", (long)indexPath.row);
    }

    return dataEntity.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Case4Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Case4Cell class]) forIndexPath:indexPath];
    [cell setupData:_data[(NSUInteger) indexPath.row]];
    return cell;
}

#pragma mark - Private methods

// 生成数据
- (void)generateData {
    NSMutableArray *tmpData = [NSMutableArray new];

    for (int i = 0; i < 20; i++) {
        Case4DataEntity *dataEntity = [Case4DataEntity new];
        dataEntity.avatar = [UIImage imageNamed:[NSString stringWithFormat:@"bluefaces_%d", (i % 4) + 1]];
        dataEntity.title = [NSString stringWithFormat:@"Title: %d", i];
        dataEntity.content = [self getText:@"content-" withRepeat:i * 2 + 1];
        [tmpData addObject:dataEntity];
    }

    _data = tmpData;
}

// 重复text字符串repeat次
- (NSString *)getText:(NSString *)text withRepeat:(int)repeat {
    NSMutableString *tmpText = [NSMutableString new];

    for (int i = 0; i < repeat; i++) {
        [tmpText appendString:text];
    }

    return tmpText;
}

@end
