//
//  JLMovie.m
//  Movie Search-C
//
//  Created by Jordan Lamb on 10/11/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

#import "JLMovie.h"

@implementation JLMovie


- (JLMovie *)initWithTitle:(NSString *)title rating:(NSString *)rating movieDescription:(NSString *)movieDesription image:(NSString *)image
{
    self = [super init];
    if (self)
    {
        _title = title;
        _rating = rating;
        _movieDescription = movieDesription;
        _image = image;
    }
    return self;
}


@end
