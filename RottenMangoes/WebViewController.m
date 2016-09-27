//
//  WebViewController.m
//  RottenMangoes
//
//  Created by Cay Cornelius on 26/09/16.
//  Copyright © 2016 Cornelius.Media. All rights reserved.
//

#import "WebViewController.h"
#import "Movie.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do anyview additional setup after loading the view.
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:theConfiguration];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:self.movieItem.url];
    [webView loadRequest:nsrequest];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
