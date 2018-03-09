//
//  HomeCookbookCollectionViewLayout.h
//  TableViewAndCollectionView
//
//  Created by Devin on 2017/4/7.
//  Copyright © 2017年 Devin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ALiLayoutDelegate <NSObject>

//去改变数据源
- (void)moveDataItem:(NSIndexPath*)fromIndexPath toIndexPath:(NSIndexPath*)toIndexPath;

@end

@interface HomeCookbookCollectionViewLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) id<ALiLayoutDelegate> delegate;

- (void)stop:(UICollectionViewCell *)aView;

@property(nonatomic, assign) BOOL isMove;


@end
