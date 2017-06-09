//
//  FilmDetailController.m
//  GhibliAPI
//
//  Created by System Administrator on 6/7/17.
//  Copyright © 2017 System Administrator. All rights reserved.
//

#import "FilmDetailController.h"
#import "Film.h"
#import "Character.h"
#import "ObjectArrayBuilder.h"
#import "Utils.h"
#import "Constants.h"
#import "CharacterTableViewCell.h"

@interface FilmDetailController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moviePosterImg;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *producerLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *noResultsLabel;
@property (weak, nonatomic) IBOutlet UILabel *charactersTitleLabel;

// Array of "Character" objects representing a character in the Film
@property (strong, nonatomic) NSArray *characterData;

// Anchoring setting height of noResultsLabel label to 22, effectively rendering
// the label visible. Used when there are no results to display in the tableView.
@property (strong, nonatomic) NSLayoutConstraint* showNoResultsAnchor;

// Anchoring setting height of noResultsLabel label to 0, effectively making
// the noResultsLabel "gone". Used when there is at least one result to display in the tableView.
@property (strong, nonatomic) NSLayoutConstraint* hideNoResultsAnchor;


@end

@implementation FilmDetailController


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    
    // Set a border around the "characters" header
    _charactersTitleLabel.layer.borderColor = [UIColor blackColor].CGColor;
    _charactersTitleLabel.layer.borderWidth = 1.0;

    //Load current film info from api call into the filmdetailcontroller labels/imageview
    _titleLabel.text = [self film].title;
    _moviePosterImg.image = [UIImage imageNamed:[self film].title];
    _releaseDateLabel.text = [NSString stringWithFormat:@"Year: %@", [self film].release_date];
    _directorLabel.text = [NSString stringWithFormat:@"Director: %@", [self film].director];
    _producerLabel.text = [NSString stringWithFormat:@"Producer: %@", [self film].producer];
    _descriptionLabel.text = [NSString stringWithFormat:@"%@", [self film].description];
    
    NSArray*characterURLS  = [self film].people;
    
    
    //Set up the anchors that controll the visibility of the _noResultsLabel
    _showNoResultsAnchor = [NSLayoutConstraint constraintWithItem:_noResultsLabel
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:nil
                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                     multiplier:1.0
                                                       constant:22];
    
    
    _hideNoResultsAnchor = [NSLayoutConstraint constraintWithItem:_noResultsLabel
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:nil
                                                      attribute:NSLayoutAttributeNotAnAttribute
                                                     multiplier:1.0
                                                       constant:0];
    
    
    /* NOTE: If no people are attached to a film, the API is not empty! Instead it (for some reason)
     includes the base people URL in the "people" category for the film. So do not pull characters from 
     API if the only url in the array is the base "people" url */
    if(characterURLS!=nil && characterURLS.count>0 && ![(NSString*)[characterURLS objectAtIndex:0] isEqualToString: API_BASE_URL_PEOPLE]) {

        NSMutableString *apiUrl = [NSMutableString stringWithFormat:@"%@", API_BASE_URL_PEOPLE];
        [apiUrl appendString: @"?url="];
        [apiUrl appendString: [characterURLS componentsJoinedByString: @"&&url="]];
        
        
        NSLog(@"CHARACTER URL: %@", apiUrl);
        
        [self getCharacterDataFromAPI:apiUrl];

    } else {
        //DISPLAY "Character data not found"
        [self showTableView:false];

    }
}


/** 
 * Make a call to Ghibli API to retrieve an array of Character objects for characters included in the film
 * @param url URL of API request
 */
- (void) getCharacterDataFromAPI:(NSString *)url {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        
        NSInteger responseCode =  [(NSHTTPURLResponse*)response statusCode];
        
        if(responseCode == 200){
            
            _characterData = [ObjectArrayBuilder charactersFromJSON:(NSData *)data error:&error];
            
            if(_characterData != nil && _characterData.count>0) {
                NSLog(@"Char _characterData %@",_characterData);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showTableView:true];
                    [self.tableView reloadData];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showTableView:false];
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showTableView:false];
            });
            
        }
    }] resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)showTableView:(Boolean )show {
    _tableView.hidden = !show;
    _showNoResultsAnchor.active = !show;
    
    _noResultsLabel.hidden = show;
    _hideNoResultsAnchor.active = show;


}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.characterData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CharacterTableViewCell *cell = (CharacterTableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:@"CharacterCell" forIndexPath:indexPath];
    
    Character *character = [self.characterData objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = [NSString stringWithFormat:@"%@", character.name];
    cell.ageLabel.text = [NSString stringWithFormat:@"Age: %@", character.age];
    cell.genderLabel.text = [NSString stringWithFormat:@"Gender: %@", character.gender];
    cell.eyesLabel.text = [NSString stringWithFormat:@"Eyes: %@", character.eye_color];
    cell.hairLabel.text = [NSString stringWithFormat:@"Hair: %@", character.hair_color];
    
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
    
}

@end