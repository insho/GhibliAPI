//
//  FilmsController.h
//  GhibliAPI
//
//  Created by System Administrator on 6/6/17.
//  Copyright © 2017 System Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utils.h"

//  Loads a list of Studio Ghibli films from a sqlite DB, and displays them
//  in a tableview. Click on a film will make API call to Ghibli API and, if successful,
//  will segue user to FilmDetailController, to display film details (and make a seperate api
//  call to display Character details if they exist for the film)
@interface FilmsController : UITableViewController <UITableViewDelegate, UITableViewDataSource> {}
@end