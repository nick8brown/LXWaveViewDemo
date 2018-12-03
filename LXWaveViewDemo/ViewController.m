//
//  ViewController.m
//  LXWaveViewDemo
//
//  Created by LX Zeng on 2018/12/3.
//  Copyright © 2018   https://github.com/nick8brown   All rights reserved.
//

#import "ViewController.h"

#import "Masonry.h"

#import "WavesView.h"

#define CellIdentifier @"Cell"

@interface ViewController ()

{
    WavesView *_waveView;
    UIView *_iconView;
    UIImageView *_iconImgView;
    UILabel *_nicknameLabel;
    UILabel *_cellphoneLabel;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation ViewController

#pragma mark - lazy load
- (NSArray *)iconArray {
    if (!_iconArray) {
        _iconArray = @[@"项目", @"介绍", @"认证", @"设置"];
    }
    return _iconArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"我发布的招工", @"介绍", @"实名认证", @"设置"];
    }
    return _titleArray;
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"波浪效果";
    
    // 初始化导航栏
    [self setupNavBar];
    
    // 初始化view
    [self setupView];
}

#pragma mark - 初始化导航栏
- (void)setupNavBar {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:AppFont(18), NSForegroundColorAttributeName:SYS_White_Color}];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage getImageWithColor:AppHTMLColor(@"4bccbc")] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

#pragma mark - 初始化view
- (void)setupView {
    // 初始化tableView
    [self setupTableView];
}

// 初始化tableView
- (void)setupTableView {
    // 初始化tableHeaderView
    [self setupTableHeaderView];
}

// 初始化tableHeaderView
- (void)setupTableHeaderView {
    //
    CGFloat tableHeaderViewX = 0;
    CGFloat tableHeaderViewY = 0;
    CGFloat tableHeaderViewW = kScreen_WIDTH;
    CGFloat tableHeaderViewH = 200;
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(tableHeaderViewX, tableHeaderViewY, tableHeaderViewW, tableHeaderViewH)];
    self.tableView.tableHeaderView = tableHeaderView;
    
    //
    _waveView = [[WavesView alloc] initWithFrame:CGRectMake(tableHeaderViewX, tableHeaderViewY, tableHeaderViewW, tableHeaderViewH)];
    _waveView.backgroundColor = AppHTMLColor(@"4bccbc");
    [self.tableView.tableHeaderView addSubview:_waveView];
    
    //
    _iconView = [[UIView alloc] init];
    
    _iconImgView = [[UIImageView alloc] init];
    [_iconView addSubview:_iconImgView];
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconView.mas_top).with.offset(0);
        make.centerX.equalTo(_iconView);
        make.size.mas_equalTo(CGSizeMake(59, 59));
    }];
    _iconImgView.layer.borderWidth = 1;
    _iconImgView.layer.borderColor = AppHTMLColor(@"ffffff").CGColor;
    _iconImgView.layer.cornerRadius = 59 * 0.5;
    _iconImgView.layer.masksToBounds = YES;
    _iconImgView.image = ImageNamed(@"头像");
    
    _nicknameLabel = [[UILabel alloc] init];
    [_iconView addSubview:_nicknameLabel];
    [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImgView.mas_bottom).with.offset(8);
        make.centerX.equalTo(_iconView);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
    _nicknameLabel.font = AppFont(20);
    _nicknameLabel.textColor = AppHTMLColor(@"ffffff");
    _nicknameLabel.textAlignment = NSTextAlignmentCenter;
    _nicknameLabel.text = @"昵称：包工头";
    
    _cellphoneLabel = [[UILabel alloc] init];
    [_iconView addSubview:_cellphoneLabel];
    [_cellphoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_iconView.mas_bottom).with.offset(0);
        make.centerX.equalTo(_iconView);
        make.size.mas_equalTo(CGSizeMake(200, 25));
    }];
    _cellphoneLabel.font = AppFont(17);
    _cellphoneLabel.textColor = AppHTMLColor(@"ffffff");
    _cellphoneLabel.textAlignment = NSTextAlignmentCenter;
    _cellphoneLabel.text = @"手机号：18888888888";
    
    [self.tableView.tableHeaderView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.tableHeaderView.mas_top).with.offset(8);
        make.centerX.equalTo(self.tableView.tableHeaderView);
        make.size.mas_equalTo(CGSizeMake(150, 130));
    }];
    [_iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapToMyInfo:)]];
    _iconView.userInteractionEnabled = YES;
    
    //
    _waveView.imageFrame = _iconView.frame;
    
    [_waveView startWaveAnimation];
}

#pragma mark - UITableViewDataSource
// 段数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

// cell样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.imageView.image = ImageNamed(self.iconArray[indexPath.section]);
    cell.textLabel.text = self.titleArray[indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate
// 段头高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

// 段尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return minimumSpacing;
}

// 段头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

// 段尾视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

// 选中某行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) { // 我发布的招工
        NSLog(@"-----【我的】-----【菜单点击】-----【我发布的招工】-----");
    } else if (indexPath.section == 1) { // 介绍
        NSLog(@"-----【我的】-----【菜单点击】-----【介绍】-----");
    } else if (indexPath.section == 2) { // 实名认证
        NSLog(@"-----【我的】-----【菜单点击】-----【实名认证】-----");
    } else if (indexPath.section == 3) { // 设置
        NSLog(@"-----【我的】-----【菜单点击】-----【设置】-----");
    }
}

#pragma mark - 监听手势响应事件
// 个人资料
- (void)onTapToMyInfo:(UITapGestureRecognizer *)recognizer {
    NSLog(@"-----【我的】-----【菜单点击】-----【个人资料】-----");
}

@end
