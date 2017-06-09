//
//  FilmDetailController.h
//  GhibliAPI
//
//  Created by System Administrator on 6/7/17.
//  Copyright © 2017 System Administrator. All rights reserved.
//

#ifndef FilmDetailController_h
#define FilmDetailController_h

#import <UIKit/UIKit.h>
#import "Film.h"

//  Displays information for a given Ghibli film. This includes information
//  returned from API call in FilmsController, as well as an array of Character data
//  returned from a seperate API call made within the viewDidLoad of the FilmDetailController
@interface FilmDetailController : UIViewController <UITableViewDelegate, UITableViewDataSource>

//  Film object with data for the film whose detail is being displayed
@property (strong, nonatomic) Film *film;
@end

#endif /* FilmDetailController_h */
