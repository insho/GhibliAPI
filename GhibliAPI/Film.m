//
//  Film.m
//  GhibliAPI
//
//  Created by System Administrator on 6/6/17.
//  Copyright © 2017 System Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Film.h"

@implementation Film

@synthesize id = _id;
@synthesize title = _title;
@synthesize description = _description;
@synthesize director = _director;
@synthesize producer = _producer;
@synthesize release_date = _release_date;
@synthesize rt_score = _rt_score;
@synthesize people = _people;


- (id)initWithTitle:(NSString*)id title:(NSString*)title {
    if ((self = [super init])) {
        self.id = id;
        self.title = title;
    }
    return self;
}

@end