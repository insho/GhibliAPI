//
//  Utils.h
//  GhibliAPI
//
//  Created by System Administrator on 6/7/17.
//  Copyright © 2017 System Administrator. All rights reserved.
//

#ifndef Utils_h
#define Utils_h
#import <UIKit/UIKit.h>


// Utility class, catchall for different useful public functions.
@interface Utils : NSObject

/**
 Shows error message (when API call fails, for instance)
 * @param title Title of alert
 * @param message Message to show in alert
 * @return UIAlertView
 */     
+(UIAlertController *) errorAlert:(NSString *)title message:(NSString *)message;

/**
 Adds a grey overlay view with a spinning activity indicator to a view. Used when 
 making API call in FilmsController.
 * @param aSuperview View to cover with overlay
 */
+ (void)showOverlayView:(UIView *)aSuperview;


/**
 Removes overlay view/spinner from a view. Used when making API call in FilmsController.
 * @param aSuperview View containing overlay that will be removed
 */
+ (void)removeOverlayView:(UIView *)aSuperview;

@end

#endif /* Utils_h */
