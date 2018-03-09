//
//  BaseCollectionView.m
//  LM_MoreFunction
//
//  Created by 刘建明 on 2018/3/6.
//  Copyright © 2018年 余浩. All rights reserved.
//

#import "BaseCollectionView.h"
#import "MyCell.h"
#import "HeaderView.h"

@implementation BaseCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
          [self creatViews];
    }
    return self;
}
-(void)creatViews{
    
    self.dataSource = self;
    self.delegate = self;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor whiteColor];
    self.scrollEnabled = NO;
    [self registerClass:[MyCell class] forCellWithReuseIdentifier:@"myCell"];
    //注册的头视图
    [self registerClass:[HeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];

}
#pragma mark UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.array.count;
}
#pragma mark - 组的头视图和尾视图相关的协议方法
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {//头视图
        HeaderView *scrollView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        scrollView.backgroundColor = [UIColor greenColor];
        scrollView.titleLabel.text = [NSString stringWithFormat:@"第%@个item",self.array[0]];
        return scrollView;
    }
    return nil;
    
}
//刷新或创建网格（item、cell）的方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * itemID = @"myCell";
    //collectionView到相应的复用池中查找是否有空闲的网格视图，如果有就直接使用，没有会直接创建新的返回
    MyCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:itemID forIndexPath:indexPath];
    item.backgroundColor = [UIColor grayColor];
    //设置文字
    item.title = [NSString stringWithFormat:@"第%ld个item",indexPath.item];
    return item;
}
//返回留出的边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //上、左、下、右
    return UIEdgeInsetsMake(0, 10, 0, 10);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //点击事件
    NSLog(@"点击item");
    
}
@end
