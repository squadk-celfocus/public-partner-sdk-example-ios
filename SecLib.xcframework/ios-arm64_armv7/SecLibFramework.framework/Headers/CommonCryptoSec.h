//
//  Comm.h
//  SecLib
//
//  Created by Mani on 15/02/18.
//  Copyright © 2018 Vodafone Group Services GmbH. All rights reserved.
//

@interface NSData (CommonCryptoInterfacer)
- (nullable NSData *)getSHA256Data;
- (nullable NSData *)getEncryptedDataWith:(NSString*_Nullable)key;
- (nullable NSData *)getDecryptedDataWith:(NSString*_Nullable)key;
@end
