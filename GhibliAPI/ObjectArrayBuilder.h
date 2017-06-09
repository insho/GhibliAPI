//
//  FilmArrayBuilder.h
//  GhibliAPI
//
//  Created by System Administrator on 6/6/17.
//  Copyright © 2017 System Administrator. All rights reserved.
//

#ifndef FilmArrayBuilder_h
#define FilmArrayBuilder_h

#import  <Foundation/Foundation.h>
#import "Film.h"

//  Contains methods for creating arrays of Film/Character objects from the JSON
//  returned from the Ghibli API
@interface ObjectArrayBuilder : NSObject

/**
 Converts JSON into an array of Film objects
 * @param returnedData JSON data returned from API call
 * @param error error returned from API call
 * @return array of Film objects
 */
+ (NSArray *)filmsFromJSON:(NSData *)returnedData error:(NSError **)error;


/**
 Converts JSON into an array of Character objects
 * @param returnedData JSON data returned from API call
 * @param error error returned from API call
 * @return array of Character objects
 */
+ (NSArray *)charactersFromJSON:(NSData *)returnedData error:(NSError **)error;

@end

#endif /* FilmArrayBuilder_h */
