//
//  JLMovieController.m
//  Movie Search-C
//
//  Created by Jordan Lamb on 10/11/19.
//  Copyright © 2019 Squanto Inc. All rights reserved.
//

#import "JLMovieController.h"

static NSString * const kBaseURLString = @"https://api.themoviedb.org/3";
static NSString * const kSearchKey = @"search";
static NSString * const kMovieKey = @"movie";
static NSString * const kApiKeyKey = @"api_key";
static NSString * const kApiKeyValue = @"4caf00100d52dff3f9bdf164ef53f88a";
static NSString * const kQueryKey = @"query";
static NSString * const kImageBaseURLString = @"http://image.tmdb.org/t/p";
static NSString * const kSizeKey = @"w200";

@implementation JLMovieController

+ (instancetype)sharedInstance
{
    static JLMovieController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [JLMovieController new];
    });
    return sharedInstance;
}

- (void)fetchMoviesWith:(NSString *)searchTerm completion:(void (^)(NSArray<JLMovie *> * _Nullable))completion
{
    // Goal URL: https://api.themoviedb.org/3/search/movie?api_key={api_key}&query=Jack+Reacher
    NSURL *baseURL = [NSURL URLWithString:kBaseURLString];
    NSURL *baseSearchURL = [baseURL URLByAppendingPathComponent:kSearchKey];
    NSURL *baseMovieURL = [baseSearchURL URLByAppendingPathComponent:kMovieKey];
    NSURLComponents *components = [NSURLComponents componentsWithURL:baseMovieURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *apiQuery = [NSURLQueryItem queryItemWithName:kApiKeyKey value:kApiKeyValue];
    NSURLQueryItem *searchQuery = [NSURLQueryItem queryItemWithName:kQueryKey value:searchTerm];
    components.queryItems = @[apiQuery, searchQuery];
    NSURL *finalURL = components.URL;
    NSLog(@"%@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if (!data)
        {
            NSLog(@"Error fetching Movie DATA from search term: %@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *movieTLD = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        
        if (!movieTLD)
        {
            NSLog(@"Error fetching JSON Data: %@", error);
            completion(nil);
            return;
        }
        
        NSArray *results = movieTLD[@"results"];
        NSMutableArray *arrayOfResults = [NSMutableArray new];
        for (NSDictionary *resultsDictionary in results)
        {
            NSString *imagePath = resultsDictionary[@"poster_path"];
            NSString *title = resultsDictionary[@"title"];
            NSString *movieDescription = resultsDictionary[@"overview"];
            NSNumber *rating = resultsDictionary[@"vote_average"];
            
            JLMovie *movie = [[JLMovie alloc] initWithTitle:title rating:rating movieDescription:movieDescription imagePath:imagePath];
            
            [arrayOfResults addObject:movie];
        }
        completion(arrayOfResults);
        
    }] resume];
}

- (void)fetchImage:(JLMovie *)movie completion:(void (^)(UIImage * _Nullable))completion
{
    // Goal URL: http://image.tmdb.org/t/p/w200/btTdmkgIvOi0FFip1sPuZI2oQG6.jpg
    NSLog(@"%@", movie.title);
    NSLog(@"%@", movie.imagePath);
    if (movie.imagePath == (NSString *) [NSNull null])
    {
        completion(nil);
        return;
    }
    NSString *imagePath = movie.imagePath;
    NSURL *imageBaseURL = [NSURL URLWithString:kImageBaseURLString];
    NSURL *sizeURL = [imageBaseURL URLByAppendingPathComponent:kSizeKey];
    NSURL *finalURL = [sizeURL URLByAppendingPathComponent:imagePath];
    NSLog(@"%@", finalURL);
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        if (response)
        {
            NSLog(@"%@", response);
        }
        if(data)
        {
            UIImage *image = [UIImage imageWithData:data];
            completion(image);
        }
        
    }] resume ];
}

@end
