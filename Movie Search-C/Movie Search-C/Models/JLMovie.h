//
//  JLMovie.h
//  Movie Search-C
//
//  Created by Jordan Lamb on 10/11/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JLMovie : NSObject

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSNumber *rating;
@property (nonatomic, copy, readonly) NSString *movieDescription;
@property (nonatomic, copy, readonly, nullable)NSString *imagePath;

- (JLMovie *)initWithTitle:(NSString *)title
                    rating:(NSNumber *)rating
          movieDescription:(NSString *)movieDesription
                     imagePath:(NSString *)imagePath;

@end

NS_ASSUME_NONNULL_END
