//
//  ViewController.m
//  LM_MoreFunction
//
//  Created by 余浩 on 2018/3/4.
//  Copyright © 2018年 余浩. All rights reserved.
//

#import "ViewController.h"
#import "HomeCell.h"
#import "LCSelectMenuView.h"
#import "TabHeadView.h"

#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property (nonatomic,strong) LCSelectMenuView *selectMenu;

@property (nonatomic,assign) BOOL scrollFlag; //手动滚动标志，防止点击菜单滚动触发didScroll代理方法造成菜单定位死循环
@property (nonatomic,assign) NSIndexPath *indexpath;
@property (nonatomic,copy) NSMutableArray *sectionLocationArray;///cell坐标数组
@property (nonatomic,strong) TabHeadView *tabHeadView;
@property (nonatomic,copy) NSArray *aArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aArray = @[@"300",@"400",@"400",@"400",@"400"];
    [self.view addSubview:self.tableview];
    
    [self markSectionHeaderLocation];
    
    
}
- (void)markSectionHeaderLocation{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        self.sectionLocationArray = nil;
        //计算对应每个分组头的位置
        for (int i = 0; i < self.selectMenu.titleArray.count; i++) {
            __weak typeof(self) _ws = self;
            _ws.indexpath = [NSIndexPath indexPathForRow:i inSection:0];
            CGRect frame = [self.tableview rectForRowAtIndexPath:_ws.indexpath];
            CGFloat offsetY = (frame.origin.y-64-70);
            
            NSLog(@"offsetY is %f",offsetY);
            
            [self.sectionLocationArray addObject:[NSNumber numberWithFloat:offsetY]];
        }
    });
    
}


-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:(UITableViewStylePlain)];
        _tableview.sectionFooterHeight = 0.01;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        //创建tableView的头视图
        self.tabHeadView = [[TabHeadView alloc]initWithFrame:CGRectMake(0, 0, _tableview.frame.size.width, 300)];
        //设置tableView的头视图
        _tableview.tableHeaderView = self.tabHeadView;
        _tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tableview.frame.size.width, 300)];
        
    }
    return _tableview;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.selectMenu.titleArray.count;
}
//返回任意组头视图的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.aArray[indexPath.row] integerValue];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //设置头视图的复用ID
    static NSString *headerID = @"header";
    //tableView到复用池中查找是否有空闲的头视图可用，有直接用，没有创建新的头视图
    UIView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    if (view == nil) {//没有
        //创建新的头视图设置大小
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
        view.backgroundColor = [UIColor greenColor];
        [view addSubview:self.selectMenu];
    }
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[HomeCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section==0) {
        
        cell.CollectionHigh = [self.aArray[indexPath.row] integerValue];
    }
    
    return cell;
}
- (LCSelectMenuView *)selectMenu{
    
    if (!_selectMenu) {
        _selectMenu = [LCSelectMenuView new];
        _selectMenu.frame = CGRectMake(0, 0, ScreenW, 50);
        _selectMenu.titleArray = @[@"商品介绍",@"商品型号",@"商品参数",@"相关评论",@"相关推荐"];
        __weak typeof(self) _ws = self;
        [_selectMenu setPageSelectBlock:^(NSInteger index) {
            _ws.indexpath = [NSIndexPath indexPathForRow:index inSection:0];
            CGRect rect = [ _ws.tableview rectForRowAtIndexPath: _ws.indexpath];
            CGFloat offsetY = rect.origin.y-64-70;
            [ _ws.tableview setContentOffset:CGPointMake(0, offsetY) animated:YES];
            _ws.scrollFlag = YES; //打开菜单点击标志，防止滚动代理didScrollView触发
            
        }];
    }
    
    return _selectMenu;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    self.scrollFlag = NO;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    //菜单联动
    [self updateMenuTitle:offsetY];
    
}
/**
 联动过程步骤title
 */
- (void)updateMenuTitle:(CGFloat)contentOffsetY{
    
    if(!self.scrollFlag){
        //遍历
        for (int i = 0; i<self.sectionLocationArray.count; i++) {
            //最后一个按钮
            if (i == self.sectionLocationArray.count - 1) {
                
                if (contentOffsetY >= [self.sectionLocationArray[i] floatValue]) {
                    [self.selectMenu setCurrentPage:i];
                }
                
            }else{
                
                if (contentOffsetY >= [self.sectionLocationArray[i] floatValue] && contentOffsetY < [self.sectionLocationArray[i+1] floatValue]) {
                    
                    [self.selectMenu setCurrentPage:i];
                }
                
            }
        }
    }
}
#pragma -mark- lazy load
- (NSMutableArray *)sectionLocationArray{
    
    if (!_sectionLocationArray) {
        _sectionLocationArray = [NSMutableArray new];
    }
    
    return _sectionLocationArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

