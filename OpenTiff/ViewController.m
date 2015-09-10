//
//  ViewController.m
//  OpenTiff
//
//  Created by lizhichao on 14-7-18.
//  Copyright (c) 2014年 LiZhiChao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize tiffPageView, pageIndicatorLabel, nextPageButton, previousPageButton;

- (void)dealloc
{
    splitter = nil;
    tiffPageView = nil;
    pageIndicatorLabel = nil;
    nextPageButton = nil;
    previousPageButton = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    NSString *pathToImage_ = [[NSBundle mainBundle] pathForResource:@"Example" ofType:@"tiff"];
    NSLog(@"path %@",pathToImage_);

    //NSString *pathToImage = @"Users/lizhichao/Library/Application Support/iPhone Simulator/7.1/Applications/C1E7995E-FBED-4CD9-BFCA-8291A421D5D9/Documents/wenjian/wenjian.TIF";
    //C1E7995E-FBED-4CD9-BFCA-8291A421D5D9
    //@"3F34E695-BB28-43DC-AEAF-D26AF35E420D";

    splitter = [[NSTiffiSplitter alloc] initWithPathToImage:pathToImage_];
    if (splitter != nil)
    {
        currentImage = 0;
        UIImage *page = [[UIImage alloc] initWithData:[splitter dataForImage:currentImage]];
        NSLog(@"pages hi %@",page);

        dispatch_async(dispatch_get_main_queue(), ^{
            tiffPageView.image = page;

        });


        pageIndicatorLabel.text = [NSString stringWithFormat:@"%d / %d", currentImage + 1, splitter.countOfImages];
        previousPageButton.enabled = NO;
        if (splitter.countOfImages < 2)
        {
            nextPageButton.enabled = NO;
        }
    }
    tiffPageView = [[UIImageView alloc]init];
    tiffPageView.frame = CGRectMake(0, 0, 320, 440);
    [self.view addSubview:tiffPageView];

   UIToolbar * _toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 440, 320, 44)];
    NSMutableArray *buttonItems = [[NSMutableArray alloc] init];   //保存UIToolBar上要放置的UIBarButtonItem的所有实例
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];   //这个是为了隔开几个按钮、增加空隙的
    //下面分别实例化4个按钮。关于initWithTitle后面所跟的内容，是本地化的时候使用的字符串，可根据实际情况自行修改为普通字符串形式即可
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Previous", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(showPreviousPage:)];

    UIBarButtonItem *recordButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Next", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(showNextPage:)];

    //接下来，就是根据既定的顺序(返回按钮-flexibleSpace-照相机按钮-录音按钮-flexibleSpace保存按钮)分别放置4个按钮和flexibleSpace
    [buttonItems addObject:flexibleSpace];
    [buttonItems addObject: backButton];
    [buttonItems addObject:flexibleSpace];
    [buttonItems addObject:recordButton];
    [buttonItems addObject:flexibleSpace];
    //最后，将buttonItems里面的内容全部加载到_toolBar上即可
    [_toolBar setItems:buttonItems animated:YES];
	// Do any additional setup after loading the view, typically from a nib.

    [self.view addSubview:_toolBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showPreviousPage:(id)sender
{
    if (currentImage > 0)
    {
        --currentImage;
        UIImage *page = [[UIImage alloc] initWithData:[splitter dataForImage:currentImage]];
        tiffPageView.image = page;

        pageIndicatorLabel.text = [NSString stringWithFormat:@"%d / %d", currentImage + 1, splitter.countOfImages];
        nextPageButton.enabled = YES;
        if (currentImage == 0)
        {
            previousPageButton.enabled = NO;
        }
    }
}

- (void)showNextPage:(id)sender
{
    if (currentImage < splitter.countOfImages - 1)
    {
        ++currentImage;
        UIImage *page = [[UIImage alloc] initWithData:[splitter dataForImage:currentImage]];
        tiffPageView.image = page;

        pageIndicatorLabel.text = [NSString stringWithFormat:@"%d / %d", currentImage + 1, splitter.countOfImages];
        previousPageButton.enabled = YES;
        if (currentImage == splitter.countOfImages - 1)
        {
            nextPageButton.enabled = NO;
        }
    }
}


@end
