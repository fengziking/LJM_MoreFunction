//
//  MyCell.h
//  UICollectionView_Base
//
//  Created by 夏婷 on 15/12/2.
//  Copyright (c) 2015年 夏婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UICollectionViewCell
//设置显示文字
@property(nonatomic, copy) NSString *title;
//设置显示图片的名字
@property (nonatomic, copy) NSString *imageName;

@end
