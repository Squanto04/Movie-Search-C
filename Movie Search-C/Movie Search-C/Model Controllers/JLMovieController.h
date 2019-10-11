//
//  JLMovieController.h
//  Movie Search-C
//
//  Created by Jordan Lamb on 10/11/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLMovie.h"

NS_ASSUME_NONNULL_BEGIN

@interface JLMovieController : NSObject

+ (instancetype)sharedInstance;

- (void)fetchMoviesWith:(NSString *)searchTerm completion:(void(^)(NSArray<JLMovie *> *searchResults))completion;

-(void)fetchImage:(JLMovie *)movie completion:(void(^)(UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
