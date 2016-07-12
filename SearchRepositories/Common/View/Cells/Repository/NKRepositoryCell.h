//
//  NKRepositoryCell.h
//  SearchRepositories
//
//  Created by Nikolay Kagala on 12/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKTableViewCell.h"

@interface NKRepositoryCell : NKTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *homePageLabel;

@property (weak, nonatomic) IBOutlet UILabel *updatedAtLabel;

@property (weak, nonatomic) IBOutlet UILabel *languageLabel;

@property (weak, nonatomic) IBOutlet UILabel *stargazersCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *forkCountLabel;

@property (weak, nonatomic) IBOutlet UIImageView *starImageView;

@property (weak, nonatomic) IBOutlet UIImageView *forkImageView;

@end
