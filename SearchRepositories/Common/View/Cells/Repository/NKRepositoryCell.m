//
//  NKRepositoryCell.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 12/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKRepositoryCell.h"
#import "NKRepository.h"
#import "UIImage+NKApplicationImage.h"

@interface NKRepositoryCell ()

@end

@implementation NKRepositoryCell

- (void)prepareForReuse {

}

- (void)configureWithItem:(id)item {
    NSAssert([item isKindOfClass:[NKRepository class]], @"Wrong item passed to Repository cell");
    NKRepository *repository = (NKRepository *)item;
    
    self.fullNameLabel.text = repository.fullName;
    self.descriptionLabel.text = repository.descr;
    self.homePageLabel.text = repository.homepage;
    self.updatedAtLabel.text = repository.updatedAt.description;
    self.languageLabel.text = repository.language;
    self.stargazersCountLabel.text = [NSString stringWithFormat:@"%@", repository.stargazersCount];
    self.forkCountLabel.text = [NSString stringWithFormat:@"%@", repository.forksCount];
    UIImage *starImage = repository.isFavorite ? [UIImage nk_star]: [UIImage nk_emptyStar];
    self.starImageView.image = starImage;
}

@end
