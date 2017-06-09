//
//  FilmArrayBuilder.m
//  GhibliAPI
//
//  Created by System Administrator on 6/6/17.
//  Copyright © 2017 System Administrator. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectArrayBuilder.h"
#import "Film.h"
#import "Character.h"

@implementation ObjectArrayBuilder
+ (NSArray *)filmsFromJSON:(NSData *)returnedData error:(NSError **)error
{
    /* Initialize the array of films that will be returned. If
    there is an error, just pass empty array to VC and it will show error alert to user */
    NSMutableArray *films = [[NSMutableArray alloc] init];
    
    

    if(NSClassFromString(@"NSJSONSerialization")) {
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData:returnedData
                     options:0
                     error:&error];
        
        if(error) {
            NSLog(@"Error - JSON is malformed");
        }
        
        /* When pulling information for one film, return object will be a NSDictionary for that single film.
         However, if pulling info for all films from API, it will return an array of NSDictionary objects containing 
         all the films. */
        if([object isKindOfClass:[NSArray class]]) {
            
            NSArray *results = object;
            NSLog(@"Count %lu", (unsigned long)results.count);
            
            for (NSDictionary *filmDic in results) {
                Film *film = [[Film alloc] init];
                
                for (NSString *key in filmDic) {
                    if ([film respondsToSelector:NSSelectorFromString(key)]) {
                        [film setValue:[filmDic valueForKey:key] forKey:key];
                    }
                }
                
                NSLog(@"filmadded: %@", film);
                [films addObject:film];
            }
            
        } else if([object isKindOfClass:[NSDictionary class]]) {

            //Handle single objects (for single films)
            NSDictionary *filmDic = object;
            
                Film *film = [[Film alloc] init];
            
                for (NSString *key in filmDic) {
                    NSLog(@"key: %@", key);
                    
                    if ([film respondsToSelector:NSSelectorFromString(key)]) {
                        NSLog(@"KEY EXISTS!");
                        [film setValue:[filmDic valueForKey:key] forKey:key];
                    }
                }
                NSLog(@"FILM ADDED SUCCESFULLY!");
                [films addObject:film];
            
        } else {
            NSLog(@"Error - object is not a dictionary packet ");
        }
    }
    
    return films;
}



+ (NSArray *)charactersFromJSON:(NSData *)returnedData error:(NSError **)error
{
    
    /* Initialize the array of films that will be returned. If
     there is an error, just pass empty array to VC and it will show error alert to user */
    NSMutableArray *characters = [[NSMutableArray alloc] init];
    
    if(NSClassFromString(@"NSJSONSerialization")) {
        NSError *error = nil;
        id object = [NSJSONSerialization
                     JSONObjectWithData:returnedData
                     options:0
                     error:&error];
        
        if(error) {
            NSLog(@"Error - JSON is malformed");
        }
        
        /* When pulling information for one film, return object will be a NSDictionary for that single film.
         However, if pulling info for all films from API, it will return an array of NSDictionary objects containing
         all the films. */
        if([object isKindOfClass:[NSArray class]]) {
            
            NSArray *results = object;
            NSLog(@"Count %lu", (unsigned long)results.count);
            
            for (NSDictionary *characterDic in results) {
                Character *character = [[Character alloc] init];
                
                for (NSString *key in characterDic) {
                    NSLog(@"key: %@", key);
                    if ([character respondsToSelector:NSSelectorFromString(key)]) {
                        NSLog(@"KEY EXISTS!");
                        [character setValue:[characterDic valueForKey:key] forKey:key];
                    }
                }
                
                NSLog(@"character added: %@", character);
                [characters addObject:character];
            }
            
            //Handle single objects (for single films)
        } else if([object isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary *characterDic = object;
            
            Character *character = [[Character alloc] init];
            
            for (NSString *key in characterDic) {
                
                if ([character respondsToSelector:NSSelectorFromString(key)]) {
                    [character setValue:[characterDic valueForKey:key] forKey:key];
                }
            }
            [characters addObject:character];
            
        } else {
            NSLog(@"Error - object is not a dictionary packet ");
        }
    }
    
    
    
    return characters;
}
@end