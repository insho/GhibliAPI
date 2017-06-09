//
//  Utils.m
//  GhibliAPI
//
//  Created by System Administrator on 6/7/17.
//  Copyright © 2017 System Administrator. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Utils.h"

@implementation Utils


+(UIAlertController *) errorAlert:(NSString *)title message:(NSString *)message {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    //Handle your yes please button action here
                                }];
    
    [alert addAction:yesButton];
    return alert;
    
}


+ (void)showOverlayView:(UIView *)aSuperview
{
    UIView*overlayView = [[UIView alloc] initWithFrame:[aSuperview bounds]];
    
    overlayView.opaque = NO;
    overlayView.alpha = .5;
    overlayView.backgroundColor = [UIColor darkGrayColor];
    overlayView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    overlayView.tag = 11;
    [aSuperview addSubview:overlayView];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    spinner.center = overlayView.center;
    spinner.tag = 12;
    [overlayView addSubview:spinner];
    [spinner startAnimating];
}


+ (void)removeOverlayView:(UIView *)aSuperview
{
    UIView*overlayView = [aSuperview viewWithTag:11];
    
    [[overlayView viewWithTag:12] stopAnimating];
    overlayView.removeFromSuperview;
}

@end