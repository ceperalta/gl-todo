//
//  ContenedorHomeUIViewController.h
//  Aquitectura
//
//  Created by Carlos Peralta on 31/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControladorPrincipalNSObject.h"
#import "HomeUIViewController.h"


@class HomeUIViewController, MenuGeneralUIViewController;

@interface ContenedorHomeUIViewController : UIViewController <HomeUIViewControllerProtocol>



- (id)inciaConSuNibYControlador_ControladorPrincipalNSObject:(ControladorPrincipalNSObject*)controladorPrincipalNSObject;

@property (nonatomic, retain) HomeUIViewController *homeUIViewController;
@property (nonatomic, retain) MenuGeneralUIViewController *menuGeneralUIViewController;

- (void) cerrarMenuAnimado;

@end
