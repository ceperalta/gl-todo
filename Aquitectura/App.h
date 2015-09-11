//
//  App.h
//  Aquitectura
//
//  Created by Eduardo Pujol on 19/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControladorPrincipalNSObject.h"
#import "DAO.h"



@class ControladorPrincipalNSObject, DAO;

@interface App : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ControladorPrincipalNSObject *controladorPrincipalNSObject;

@property (strong, nonatomic) DAO *dao;

@property (assign, atomic) BOOL requerimientoDeRedEnProcesoBOOL;

@end
