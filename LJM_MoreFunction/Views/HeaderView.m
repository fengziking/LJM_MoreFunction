//
//  HeaderScrollView.m
//  UICollectionView_Base
//
//  Created by 夏婷 on 15/12/2.
//  Copyright (c) 2015年 夏婷. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc]init];
        //设置frame, 放在网格顶端
        _titleLabel.frame= CGRectMake(0, 0, self.frame.size.width, 30);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_titleLabel];
    }
    return self;
}


@end
