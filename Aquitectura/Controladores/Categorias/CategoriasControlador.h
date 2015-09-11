//
//  CategoriasControlador.h
//  Aquitectura
//
//  Created by Carlos Peralta on 7/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MenuGeneralUIViewController.h"


@class MenuGeneralUIViewController;

@interface CategoriasControlador : NSObject

- (id) init_MenuGeneralUIViewController:(MenuGeneralUIViewController*)menuGeneralUIViewController;
- (void) tomarCategorias;
- (void) lleganCategorias:(NSArray*)categoriasNSArray;

@end
