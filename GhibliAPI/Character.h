//
//  Character.h
//  GhibliAPI
//
//  Created by System Administrator on 6/7/17.
//  Copyright © 2017 System Administrator. All rights reserved.
//

#ifndef Character_h
#define Character_h

//  Object representing data for a character in one or more Studio Ghibli films, retrieved from Ghibli API
@interface Character : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *age;
@property (strong, nonatomic) NSString *eye_color;
@property (strong, nonatomic) NSString *hair_color;


- (id)initWithID:(NSString*)filmID;

@end
#endif /* Character_h */
