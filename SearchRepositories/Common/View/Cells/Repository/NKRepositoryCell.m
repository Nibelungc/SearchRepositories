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
#import "UIColor+NKApplicationColor.h"

@interface NKRepositoryCell ()

@end

@implementation NKRepositoryCell

- (void)awakeFromNib {
    [self configureAppearance];
}

- (void)configureAppearance {
    self.fullNameLabel.textColor = [UIColor nk_blue];
    self.fullNameLabel.font = [UIFont boldSystemFontOfSize:17.0];
    
    self.descriptionLabel.textColor = [UIColor nk_darkGray];
    self.descriptionLabel.font = [UIFont systemFontOfSize:15.0];
    
    self.homePageLabel.textColor = [UIColor nk_gray];
    self.homePageLabel.font = [UIFont systemFontOfSize:15.0];
    
    self.updatedAtLabel.textColor = [UIColor nk_gray];
    self.updatedAtLabel.font = [UIFont systemFontOfSize:12.0];
    
    for (UILabel *label in @[self.languageLabel, self.stargazersCountLabel, self.forkCountLabel]) {
        label.textColor = [UIColor blackColor];
        label.font = [UIFont boldSystemFontOfSize:12.0];
    }
}

- (void)prepareForReuse {

}

- (void)configureWithItem:(id)item {
    NSAssert([item isKindOfClass:[NKRepository class]], @"Wrong item passed to Repository cell");
    NKRepository *repository = (NKRepository *)item;
    
    self.fullNameLabel.text = repository.fullName;
    self.descriptionLabel.text = repository.descr;
    self.homePageLabel.text = repository.homepage;
    self.updatedAtLabel.text = [[self class] stringFromDate:repository.updatedAt];
    self.languageLabel.text = repository.language;
    self.stargazersCountLabel.text = [NSString stringWithFormat:@"%@", repository.stargazersCount];
    self.forkCountLabel.text = [NSString stringWithFormat:@"%@", repository.forksCount];
    UIImage *starImage = repository.isFavorite ? [UIImage nk_star]: [UIImage nk_emptyStar];
    self.starImageView.image = starImage;
}

+ (NSString *)stringFromDate:(NSDate *)date {
    NSString *format = NSLocalizedString(@"updated_at_format", nil);
    NSString *stringDate = [[self dateFormatter] stringFromDate:date];
    return [NSString stringWithFormat:format, stringDate];
}

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    if (dateFormatter == nil){
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.locale = [NSLocale currentLocale];
        dateFormatter.doesRelativeDateFormatting = YES;
    }
    return dateFormatter;
}

@end
