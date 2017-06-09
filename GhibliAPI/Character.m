//
//  Character.m
//  GhibliAPI
//
//  Created by System Administrator on 6/7/17.
//  Copyright © 2017 System Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Character.h"

@implementation Character

@synthesize id = _id;
@synthesize name = name;
@synthesize gender = _gender;
@synthesize age = _age;
@synthesize eye_color = _eye_color;
@synthesize hair_color = _hair_color;

- (id)initWithID:(NSString*)id {
    if ((self = [super init])) {
        self.id = id;
    }
    return self;
}

@end