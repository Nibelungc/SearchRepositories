//
//  NKRepository.m
//  SearchRepositories
//
//  Created by Nikolay Kagala on 11/07/16.
//  Copyright © 2016 Nikolay Kagala. All rights reserved.
//

#import "NKRepository.h"

@interface NKRepository ()

@end

@implementation NKRepository

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"identifier": @"id",
             @"name": @"name",
             @"fullName": @"full_name",
             @"HTMLURL": @"html_url",
             @"descr": @"description",
             @"createdAt": @"created_at",
             @"updatedAt": @"updated_at",
             @"homepage": @"homepage",
             @"stargazersCount": @"stargazers_count",
             @"language": @"language",
             @"forksCount": @"forks_count"};
}

+ (NSValueTransformer *)createdAtJSONTransformer {
    return [self dateValueTransformer];
}

+ (NSValueTransformer *)updatedAtJSONTransformer {
    return [self dateValueTransformer];
}

+ (NSValueTransformer *)dateValueTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [[self dateFormatter] dateFromString:dateString];
    } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
        return [[self dateFormatter] stringFromDate:date];
    }];
}

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    }
    return dateFormatter;
}

@end
