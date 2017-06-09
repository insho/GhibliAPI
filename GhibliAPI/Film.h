//
//  Film.h
//  GhibliAPI
//
//  Created by System Administrator on 6/6/17.
//  Copyright © 2017 System Administrator. All rights reserved.
//
#ifndef Film_h
#define Film_h

#import <Foundation/Foundation.h>

//  Object representing data for a single Studio Ghibli film, retrieved from Ghibli API
//  or from sqlite DB
@interface Film : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *director;
@property (strong, nonatomic) NSString *producer;
@property (strong, nonatomic) NSString *release_date;
@property (strong, nonatomic) NSString *rt_score;
@property (strong, nonatomic) NSArray *people;

- (id)initWithTitle:(NSString*)filmID title:(NSString*)title;

@end
#endif /* Film_h */
