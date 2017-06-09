//
//  CharacterTableViewCell.h
//  GhibliAPI
//
//  Created by System Administrator on 6/8/17.
//  Copyright © 2017 System Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#ifndef CharacterTableViewCell_h
#define CharacterTableViewCell_h

@interface CharacterTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *ageLabel;
@property (nonatomic, weak) IBOutlet UILabel *genderLabel;
@property (nonatomic, weak) IBOutlet UILabel *eyesLabel;
@property (nonatomic, weak) IBOutlet UILabel *hairLabel;
//@property (nonatomic, weak) IBOutlet UIImageView *thumbnailImageView;

@end
#endif /* CharacterTableViewCell_h */
