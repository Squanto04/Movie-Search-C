//
//  JLMovie.m
//  Movie Search-C
//
//  Created by Jordan Lamb on 10/11/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

#import "JLMovie.h"

@implementation JLMovie


- (JLMovie *)initWithTitle:(NSString *)title rating:(NSNumber *)rating movieDescription:(NSString *)movieDesription imagePath:(NSString *)imagePath
{
    self = [super init];
    if (self)
    {
        _title = title;
        _rating = rating;
        _movieDescription = movieDesription;
        _imagePath = imagePath;
    }
    return self;
}


@end
