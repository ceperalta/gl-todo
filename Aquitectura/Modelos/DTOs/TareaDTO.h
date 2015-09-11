//
//  TareaDTO.h
//  Aquitectura
//
//  Created by Carlos Peralta on 4/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TareaDTO : NSObject

@property (assign,nonatomic) int idTareaInt;
@property (retain,nonatomic) NSString *tareaNSString;

@property (assign,nonatomic) int idCategoriaParaEstaTareaInt;

@property (retain,nonatomic) NSString *categoriaNSString;

@end
