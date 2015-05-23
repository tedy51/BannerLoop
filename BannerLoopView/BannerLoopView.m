//
//  BannerLoopView.m
//  bannerLoop
//
//  Created by hisa on 15/5/7.
//  Copyright (c) 2015年 hisa. All rights reserved.
//

#import "BannerLoopView.h"

#define JumpTime     2
@interface BannerLoopView()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    int _totalPages;
    int _curPage;
    
    NSMutableArray *loopArray;
    
    NSArray  *itemArray;
    
    NSTimer  *loopTimer;
    
}

@end

@implementation BannerLoopView

- (id)initWithFrame:(CGRect)frame items:(NSArray*)items
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _scrollView.pagingEnabled = YES;
        [self addSubview:_scrollView];
        
        _scrollView.backgroundColor = [UIColor purpleColor];
        
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 30;
        rect.size.height = 30;
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.userInteractionEnabled = NO;
        
        [self addSubview:_pageControl];
        
        _curPage = 0;
        
        itemArray = items;
        
        [self reloadData];
        
    }
    return self;
}
- (void)reloadData
{
    _totalPages = (int)[itemArray count];
    if (_totalPages == 0) {
        return;
    }
    _pageControl.numberOfPages = _totalPages;
    [self loadData];
    
    [self autoStart];
}
- (void)loadData
{
    
    _pageControl.currentPage = _curPage;
    
    
    NSArray *subViews = [_scrollView subviews];
    if([subViews count] != 0) {
        [subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    [self getDisplayImagesWithCurpage:_curPage];
    
    for (int i = 0; i < 3; i++) {
        
        UIImage *img =  [loopArray objectAtIndex:i];
        
        UIImageView *v = [[UIImageView alloc]init];
        
        v.image  = img;
        
        v.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        
       
        
        v.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(handleTap:)];
        [v addGestureRecognizer:singleTap];
       
        v.frame = CGRectOffset(v.frame, v.frame.size.width * i, 0);
        [_scrollView addSubview:v];
        
        
    }
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    
    if(_totalPages<2)
    {
        _scrollView.scrollEnabled = NO;
        [_pageControl removeFromSuperview];
    }
}
- (void)getDisplayImagesWithCurpage:(int)page {
    
    int pre = [self validPageValue:_curPage-1];
    int last = [self validPageValue:_curPage+1];
    
    if (!loopArray) {
        loopArray = [[NSMutableArray alloc] init];
    }
    
    [loopArray removeAllObjects];
    
    [loopArray addObject:[itemArray objectAtIndex:pre]];
    [loopArray addObject:[itemArray objectAtIndex:page]];
    [loopArray addObject:[itemArray objectAtIndex:last]];
}

- (int)validPageValue:(int)value {
    
    if(value == -1) value = _totalPages - 1;
    if(value == _totalPages) value = 0;
    
    return value;
    
}
- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([_delegate respondsToSelector:@selector(didClickPageAtIndex:)]) {
        [_delegate didClickPageAtIndex:_curPage];
    }
    
}
-(void)autoStart
{
    
    
    [self performSelector:@selector(setUpFirstView) withObject:nil afterDelay:JumpTime];
    
    
}

-(void)setUpFirstView
{
    if(_totalPages>=2)
    {
        [_scrollView setContentOffset:CGPointMake(2*self.frame.size.width, 0) animated:YES];
        
        
        loopTimer = [NSTimer scheduledTimerWithTimeInterval:JumpTime target:self selector:@selector(switchFocusImageItems) userInfo:nil repeats:YES];
        
    }
    
    
}


- (void)switchFocusImageItems
{
   
    float x =_scrollView.contentOffset.x;
    
    
    
    if(x >= (2*self.frame.size.width)) {
        _curPage = [self validPageValue:_curPage+1];
        [self loadData];
    }
    
    
    if(x <= 0) {
        _curPage = [self validPageValue:_curPage-1];
        [self loadData];
    }
    
    
    [_scrollView setContentOffset:CGPointMake(self.frame.size.width+_scrollView.contentOffset.x, 0) animated:YES];
    
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    
    int x = aScrollView.contentOffset.x;
    
    
   
    if(x >= (2*self.frame.size.width)) {
        _curPage = [self validPageValue:_curPage+1];
        [self loadData];
    }
    
   
    if(x <= 0) {
        _curPage = [self validPageValue:_curPage-1];
        [self loadData];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView {
    
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0) animated:YES];
    
}

-(void)dealloc
{
    [_scrollView setDelegate:nil];
    
    [loopTimer  invalidate];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
