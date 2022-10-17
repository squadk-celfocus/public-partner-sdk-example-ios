//
//  ObjcExceptionHelper.h
//  VPartnerLib
//
//  Created by Ricardo Rabeto on 11/11/2020.
//  Copyright © 2020 Celfocus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjcExceptionHelper: NSObject

+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error;

@end
