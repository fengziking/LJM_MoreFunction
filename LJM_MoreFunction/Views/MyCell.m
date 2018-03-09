//
//  MyCell.m
//  UICollectionView_Base
//
//  Created by 夏婷 on 15/12/2.
//  Copyright (c) 2015年 夏婷. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell
{
    UILabel *_titleLabel;//用于显示标题
    UIImageView *_imageView;//显示图片
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //添加子视图
        [self createSubViews];
        
    }
    return self;
}

-(void)createSubViews
{
    _titleLabel = [[UILabel alloc]init];
    //设置frame, 放在网格顶端
    _titleLabel.frame= CGRectMake(0, 0, self.frame.size.width, 30);
    //居中对齐
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor blackColor];
    //设置字体
    _titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_titleLabel];
    //contentView苹果提供的一个与网格同等大小的空白View，建议把自己添加的子视图放在上面
    
    _imageView = [[UIImageView alloc]init];
    //设置位置和大小
    _imageView.frame = CGRectMake(0, _titleLabel.frame.size.height, self.frame.size.width, self.frame.size.height - _titleLabel.frame.size.height);
    [self.contentView addSubview:_imageView];
    
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor redColor];
    //设置选中时的背景视图，所有继承于UIView的类的对象都可以作为选中时的背景视图
    self.selectedBackgroundView = view;
}
//通过set方法刷新显示文字
-(void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = _title;
}
//通过set刷新显示的图片
-(void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    NSArray *array = [imageName componentsSeparatedByString:@"."];
    //获取图片的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:array[0] ofType:array[1]];
    //读取图片数据并创建图片对象，并将其显示到图片视图上
    _imageView.image = [[UIImage alloc]initWithContentsOfFile:path];
}



@end
