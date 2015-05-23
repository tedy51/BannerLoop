//
//  BannerLoopView.h
//  bannerLoop
//
//  Created by hisa on 15/5/7.
//  Copyright (c) 2015年 hisa. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BannerLoopDelegate <NSObject>

@optional
- (void)didClickPageAtIndex:(NSInteger)index;

@end
@interface BannerLoopView : UIView
- (id)initWithFrame:(CGRect)frame items:(NSArray*)items;
@property(strong,nonatomic) id<BannerLoopDelegate> delegate;

@end
