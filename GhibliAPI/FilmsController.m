//
//  FilmsController.m
//  GhibliAPI
//
//  Created by System Administrator on 6/6/17.
//  Copyright © 2017 System Administrator. All rights reserved.
//

#import "FilmsController.h"
#import <sqlite3.h>
#import "Film.h"
#import "ObjectArrayBuilder.h"
#import "Constants.h"
#import "FilmDetailController.h"
#import "Utils.h"

@interface FilmsController () {}

//  Array of films ("Film" objects) returned from sqlite DB, one of which
//  will be passed on to FilmDetailController in preparation for segue
@property (strong, nonatomic) NSMutableArray *filmData;
@end

@implementation FilmsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getSQLiteData:[self getDatabasePath]];
}



#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [self.filmData count];
}

//  Displays film's release data and title for each film in DB
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Film *film = [self.filmData objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", film.release_date, film.title];
    
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Film *film = [self.filmData objectAtIndex:indexPath.row];
    NSString *apiUrl = [NSString stringWithFormat:@"%@%@", API_BASE_URL_FILMS, film.id];
    NSLog(@"URL: %@", apiUrl);
    [self getDataFromAPI:apiUrl];
}


/**
 * Retrieves path to internal sqlite db with film info
 * @return path to internal sqlite db with film info
 */
-(NSString *)getDatabasePath
{
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"GhibliDB.db"];
}


/**
 * Retrieves Film information (Note: film ID is a text string that corresponds to film id in Ghibli API) from
 * sqlite DB and loads it into sqliteFilmData array, which feeds the tableView
 * @param dbPath Path to sqlite DB (see func "getDatabasePath")
 */
-(void)getSQLiteData:(NSString *)dbPath
{
    _filmData = [[NSMutableArray alloc] init];
    
    sqlite3 *database;
    if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
        
        const char *sql = "select _id, Title, ReleaseDate from Films order by ReleaseDate asc";
        sqlite3_stmt *selectStatement;
        if(sqlite3_prepare_v2(database, sql, -1, &selectStatement, NULL) == SQLITE_OK) {
            
            while(sqlite3_step(selectStatement) == SQLITE_ROW) {
                
                
                Film *film = [[Film alloc] init];
                film.id = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
                film.title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
                film.release_date = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
                [_filmData addObject:film];
                
                NSLog(@"%@", film.title);
            }
        }
    }
    
    sqlite3_close(database);
}


/**
 * Retrieves data for a Ghibli film from the Ghibli API and, if successful, segues to FilmDetailController where
 * the retrieved information for the film is displayed. Func is called on tableView click. An activity indicator is displayed
 * and tableView clicking is disabled during API call.
 * @param url URL of API request
 */
- (void) getDataFromAPI:(NSString *)url {
    
    //  Show activity indicator and disable tableView click while API call is being made
    
    self.tableView.allowsSelection = NO;
    [Utils showOverlayView:self.view];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        // API call in background thread
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setHTTPMethod:@"GET"];
        [request setURL:[NSURL URLWithString:url]];
        
        
        NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfig.timeoutIntervalForRequest = 10.0;
        sessionConfig.timeoutIntervalForResource = 15.0;
        
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            
            // UIKit calls need to be made on the main thread, so re-dispatch there
            dispatch_async(dispatch_get_main_queue(), ^{
                [Utils removeOverlayView:self.view];
                self.tableView.allowsSelection = YES;
            });
            
            NSInteger responseCode =  [(NSHTTPURLResponse*)response statusCode];
            
            // Segue if API response was successful and ObjectArrayBuilder successfully returned a Film object. Otherwise display error alert
            if(responseCode == 200){
                NSArray*filmArray = [ObjectArrayBuilder filmsFromJSON:(NSData *)data error:&error];
                if(filmArray != nil && filmArray.count>0) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self performSegueWithIdentifier:@"segueToFilmDetail" sender:[filmArray objectAtIndex:0]];
                    });
                } else {
                    UIAlertController *alert = [Utils errorAlert:@"Connection Error" message:@"Unable to Connect to API"];
                    [self presentViewController:alert animated:YES completion:nil];
                }
                
            } else {
                NSLog(@"Error getting %@, HTTP status code %li", url, (long)responseCode);
                UIAlertController *alert = [Utils errorAlert:@"Connection Error" message:@"Unable to Connect to API"];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            
            
        }] resume];

    });
    
    
    
}


// Transfers "Film" object retrieved from API call to the FilmDetailController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueToFilmDetail"])
    {
        // Get reference to the destination view controller
        FilmDetailController *detailVC = [segue destinationViewController];
        detailVC.film = sender; //[_sqliteFilmData objectAtIndex:selectedPath.row];
    }
}


@end