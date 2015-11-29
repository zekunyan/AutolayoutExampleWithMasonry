//
//  Case7ViewController.m
//  MasonryExample
//
//  Created by zorro on 15/11/30.
//  Copyright © 2015年 tutuge. All rights reserved.
//

#import "Case7ViewController.h"
#import "Masonry.h"

static CGFloat ParallaxHeaderHeight = 235;
static NSString *CellIdentifier = @"Cell";

@interface Case7ViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIImageView *parallaxHeaderView;
@property (strong, nonatomic) MASConstraint *parallaxHeaderHeightConstraint;
@end

@implementation Case7ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTableView];
    [self initView];
    [self createFakeTableHeader];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @(indexPath.row).stringValue;
    return cell;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        _parallaxHeaderHeightConstraint.equalTo(@(ParallaxHeaderHeight - scrollView.contentOffset.y));
    } else {
        _parallaxHeaderHeightConstraint.equalTo(@(ParallaxHeaderHeight));
    }
}

#pragma mark - Private methods

- (void)configTableView {
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
}

- (void)initView {
    _parallaxHeaderView = [UIImageView new];
    [self.view insertSubview:_parallaxHeaderView belowSubview:_tableView];
    _parallaxHeaderView.contentMode = UIViewContentModeScaleAspectFill;
    _parallaxHeaderView.image = [UIImage imageNamed:@"parallax_header_back"];

    [_parallaxHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        _parallaxHeaderHeightConstraint = make.height.equalTo(@(ParallaxHeaderHeight));
    }];
}

- (void)createFakeTableHeader {
    UIView *fakeTableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_tableView.frame), ParallaxHeaderHeight)];
    fakeTableHeader.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    fakeTableHeader.backgroundColor = [UIColor clearColor];
    _tableView.tableHeaderView = fakeTableHeader;
}

@end
