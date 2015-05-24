# BannerLoop
####  1 ， it's easy to use :

  UIImage *im1=[UIImage imageNamed:@"1.jpg"];
  
  UIImage *im2=[UIImage imageNamed:@"2.jpg"];
  
  UIImage *im3=[UIImage imageNamed:@"3.jpg"];
    
  BannerLoopView *loopView = [[BannerLoopView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150) items: @[im1,im2,im3]];
  
   loopView.delegate = self;
  
   [self.view addSubview:loopView];
   
####  2,  the way install with CocoaPods 

    pod 'BannerLoopView', '~> 1.0.0'
   

####  3 ， works like as below :

![Alt Text](https://github.com/tedy51/BannerLoop/raw/master/bannerLoop/loopView.gif)
