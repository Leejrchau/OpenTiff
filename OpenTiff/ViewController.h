//
//  ViewController.h
//  OpenTiff
//
//  Created by lizhichao on 14-7-18.
//  Copyright (c) 2014年 LiZhiChao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSTiffiSplitter.h"


@interface ViewController : UIViewController
{
    NSTiffiSplitter *splitter;
    NSUInteger currentImage;

    UIImageView *tiffPageView;
    UILabel *pageIndicatorLabel;
    UIBarButtonItem *nextPageButton;
    UIBarButtonItem *previousPageButton;

}

@property (nonatomic, retain)  UIImageView *tiffPageView;
@property (nonatomic, retain)  UILabel *pageIndicatorLabel;
@property (nonatomic, retain)  UIBarButtonItem *nextPageButton;
@property (nonatomic, retain)  UIBarButtonItem *previousPageButton;

- (void)showPreviousPage:(id)sender;
- (void)showNextPage:(id)sender;

@end
