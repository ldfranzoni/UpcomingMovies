//
//  Config.h
//  UpcomingMovies
//
//  Created by Luis Ojeda on 10/9/16.
//  Copyright © 2016 Luis Ojeda. All rights reserved.
//

#ifndef Config_h
#define Config_h


#define kTMDBAPIKEY @"1f54bd990f1cdfb230adb312546d765d"

#define kTMDBBASEURL @"https://api.themoviedb.org/3"

#define kTMDBBASEURLIMAGES @"https://image.tmdb.org/t/p/w300"
#define kTMDBBASEURLBACKIMAGES @"https://image.tmdb.org/t/p/w500"

#define kTMDBURLGENRES kTMDBBASEURL @"/genre/movie/list?api_key=" kTMDBAPIKEY

#define kTMDBURLMOVIES kTMDBBASEURL @"/movie/upcoming?page=%d&api_key=" kTMDBAPIKEY

#endif /* Config_h */
