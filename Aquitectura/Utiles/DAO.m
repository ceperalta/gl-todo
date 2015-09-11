//
//  DAO.m
//  Aquitectura
//
//  Created by Carlos Peralta on 2/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "DAO.h"
#import "CuentaDTO.h"
#import "App.h"
#import "TareaDTO.h"
#import "CategoriaDTO.h"

@interface DAO() <NSURLConnectionDataDelegate>

@property (retain,nonatomic) NSString *dominioNSString;

@property (retain,nonatomic) NSString *servicioCuentasURINSString;
@property (retain,nonatomic) NSString *servicioTareasTodasURINSString;
@property (retain,nonatomic) NSString *servicioTareasConCategoriaURINSString;
@property (retain,nonatomic) NSString *servicioCategoriasTodasURINSString;
@property (retain,nonatomic) NSString *servicioAgregarTareaURINSString;
@property (retain,nonatomic) NSString *servicioCategoriaURINSString;

@property (retain,nonatomic) NSURLConnection *con;
@property (assign,nonatomic) int codeHttpInt;
@property (retain,nonatomic) NSMutableData *datosRecibidosNSMutableData;
@property (retain,nonatomic) NSDictionary *datosNSDictionary;
@property (assign,nonatomic) NSString *postNotificationNameNSString;




@end

@implementation DAO

- (id) init{
    NSLog(@"%s", __FUNCTION__);
    
    _dominioNSString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"dominio"];
    _servicioCuentasURINSString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"rest_cuentas"];
    _servicioTareasTodasURINSString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"rest_tareas_todas"];
    _servicioCategoriasTodasURINSString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"rest_categorias_todas"];
    _servicioTareasConCategoriaURINSString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"rest_tareas_para_cat"];
    _servicioAgregarTareaURINSString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"rest_tareas"];
    _servicioCategoriaURINSString = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"rest_categorias"];
    
    return self;
}

- (void) eliminarTarea_postNotificationNameNSString:(NSString*)postNotificationNameNSString tareaTareaDTO:(TareaDTO*)tareaTareaDTO{
    NSLog(@"%s", __FUNCTION__);
    
    _postNotificationNameNSString = postNotificationNameNSString;
    
    [self requestGenerico_uriServicio:[NSString stringWithFormat:@"%@/%d",_servicioAgregarTareaURINSString,tareaTareaDTO.idTareaInt] verbo:@"DELETE" jsonNSString:nil];
}


- (void) agregarCategoria_postNotificationNameNSString:(NSString*)postNotificationNameNSString categoriaCategoriaDTO:(CategoriaDTO*)categoriaCategoriaDTO{
    NSLog(@"%s", __FUNCTION__);
    
    _postNotificationNameNSString = postNotificationNameNSString;
    
    NSDictionary *dictionaryParaJsonEncodeNSDictionary = [NSDictionary dictionaryWithObjectsAndKeys:categoriaCategoriaDTO.categoriaNombreNSString,@"categoria", nil];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionaryParaJsonEncodeNSDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [self requestGenerico_uriServicio:_servicioCategoriaURINSString verbo:@"POST" jsonNSString:strJson];
}


- (void) agregarTarea_postNotificationNameNSString:(NSString*)postNotificationNameNSString tareaTareaDTO:(TareaDTO*)tareaTareaDTO{
    NSLog(@"%s", __FUNCTION__);
   

    
    _postNotificationNameNSString = postNotificationNameNSString;
    
    NSDictionary *dictionaryParaJsonEncodeNSDictionary = [NSDictionary dictionaryWithObjectsAndKeys:tareaTareaDTO.tareaNSString,@"tarea",[NSString stringWithFormat:@"%d", tareaTareaDTO.idCategoriaParaEstaTareaInt],@"idCategoria", nil];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionaryParaJsonEncodeNSDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    [self requestGenerico_uriServicio:_servicioAgregarTareaURINSString verbo:@"POST" jsonNSString:strJson];
}

- (void) tomarTodasLasTareasParaCategoria_postNotificationNameNSString:(NSString*)postNotificationNameNSString intIDCategoria:(int)intIDCategoria{
    NSLog(@"%s", __FUNCTION__);
    
    _postNotificationNameNSString = postNotificationNameNSString;
    
    NSString *URIConIDCat = [NSString stringWithFormat:@"%@/%d",_servicioTareasConCategoriaURINSString,intIDCategoria];
    
    [self requestGenerico_uriServicio:URIConIDCat verbo:@"GET" jsonNSString:@""];
}

- (void) tomarTodasLasCategorias_postNotificationNameNSString:(NSString*)postNotificationNameNSString{
    NSLog(@"%s", __FUNCTION__);
    
    _postNotificationNameNSString = postNotificationNameNSString;
    [self requestGenerico_uriServicio:_servicioCategoriasTodasURINSString verbo:@"GET" jsonNSString:@""];
}

- (void) tomarTodasLasTareas_postNotificationNameNSString:(NSString*)postNotificationNameNSString{
    NSLog(@"%s", __FUNCTION__);
    
    _postNotificationNameNSString = postNotificationNameNSString;
    [self requestGenerico_uriServicio:_servicioTareasTodasURINSString verbo:@"GET" jsonNSString:@""];
}

- (void) controlarLogin_CuentaDTO: (CuentaDTO*)cuentaDTO postNotificationNameNSString:(NSString*)postNotificationNameNSString{
   NSLog(@"%s", __FUNCTION__);
   
    
   _postNotificationNameNSString = postNotificationNameNSString;
   NSDictionary *dictionaryParaJsonEncodeNSDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"controlarLogin",@"accion",cuentaDTO.nombreNSString,@"usuario",cuentaDTO.claveNSString,@"clave", nil];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionaryParaJsonEncodeNSDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [self requestGenerico_uriServicio:_servicioCuentasURINSString verbo:@"POST" jsonNSString:strJson];
}


- (void) agregarCuenta_CuentaDTO: (CuentaDTO*)cuentaDTO postNotificationNameNSString:(NSString*)postNotificationNameNSString{
    NSLog(@"%s", __FUNCTION__);
    
    _postNotificationNameNSString = postNotificationNameNSString;
    NSDictionary *dictionaryParaJsonEncodeNSDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"crearCuenta",@"accion",cuentaDTO.nombreNSString,@"usuario",cuentaDTO.claveNSString,@"clave", nil];
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionaryParaJsonEncodeNSDictionary options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString *strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", strJson);
    
    [self requestGenerico_uriServicio:_servicioCuentasURINSString verbo:@"POST" jsonNSString:strJson];
}

- (void) requestGenerico_uriServicio:(NSString*)uriServicio verbo:(NSString*)verbo jsonNSString:(NSString*)jsonNSString{
    NSLog(@"%s", __FUNCTION__);
    
     _datosRecibidosNSMutableData = [[NSMutableData alloc] init];

    NSString *strURLFInal = [NSString stringWithFormat:@"http://%@%@", _dominioNSString, uriServicio];
    
    NSLog(@"URL: %@",strURLFInal);
    
    NSURL *url = [NSURL URLWithString:strURLFInal];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    if (![verbo isEqualToString:@"GET"] && ![verbo isEqualToString:@"DELETE"]) {
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        NSString *postString = [NSString stringWithFormat:@"json=%@",jsonNSString];
        [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [request setHTTPMethod:verbo];
    request.timeoutInterval = 20;
    
    
    _con = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:true];
}

-(void)dealloc{
    NSLog(@"%s", __FUNCTION__);
}


- (void) manejarErrores{
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"código status http: %d", _codeHttpInt);
    
    App *app = (App*)[[UIApplication sharedApplication] delegate];
    [app.controladorPrincipalNSObject ocultarActivityIndicator];
    
   
    if (_codeHttpInt == 500) {
        NSString *mensajeErrorNegocioNSString = (NSString*)[_datosNSDictionary objectForKey:@"errorNegocioMsg"];
        [app.controladorPrincipalNSObject mostrarAlerta_msg: mensajeErrorNegocioNSString];
    }else{
        // Cualquier otro código, incluso el interno 666 por timeout, etc
        NSString *mensajeErrorNegocioNSString = (NSString*)[_datosNSDictionary objectForKey:@"mensajeError"];
        [app.controladorPrincipalNSObject mostrarAlerta_msg: mensajeErrorNegocioNSString];
    }
    
    
}

- (void) liberarConexionYOtrosParaARCANil{
    NSLog(@"%s", __FUNCTION__);
    
    _con = nil;
    _datosRecibidosNSMutableData = nil;
    _datosNSDictionary = nil;
}



#pragma mark -
#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"%s", __FUNCTION__);
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    _codeHttpInt = [httpResponse statusCode];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"%s", __FUNCTION__);
    
    NSString *respuestaNSString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"datos recibidos en proceso: %@", respuestaNSString);
  
    [_datosRecibidosNSMutableData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    NSLog(@"%s", __FUNCTION__);
   
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"%s", __FUNCTION__);

    
    if(_datosRecibidosNSMutableData.length > 0){
        NSString *respuestaNSString = [[NSString alloc] initWithData:_datosRecibidosNSMutableData encoding:NSASCIIStringEncoding];
        NSLog(@"datos recibidos: %@", respuestaNSString);
        
        NSError *jsonError = nil;
        _datosNSDictionary = [NSJSONSerialization JSONObjectWithData:_datosRecibidosNSMutableData
                                                                 options:0
                                                               error:&jsonError];
        
        if(jsonError != nil){
            _codeHttpInt = 665;
            NSLog(@"JSON Error: %@", jsonError);
            _datosNSDictionary = [NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(@"DAO_errorGeneralConexion", nil), @"mensajeError", nil];
            
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",_codeHttpInt],@"codigo",_datosNSDictionary,@"datos", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:_postNotificationNameNSString object:nil userInfo:userInfo];
             NSLog(@"NOTIFICACION LANZADA: terminaRequestRed");
        }
    }
    
    
    if (_codeHttpInt != 200) {
        [self manejarErrores];
    }
    
    
  
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",_codeHttpInt],@"codigo",_datosNSDictionary,@"datos", nil];
    
    // ATENCIÓN ! SIEMPRE LANZAR LA NOTIFICACIÓN para que el flujo saque luego el registro de la notificación
    [[NSNotificationCenter defaultCenter] postNotificationName:_postNotificationNameNSString object:nil userInfo:userInfo];
    NSLog(@"NOTIFICACION LANZADA: terminaRequestRed");
    
    [self liberarConexionYOtrosParaARCANil];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"%s", __FUNCTION__);
    NSLog(@"didFailWithError Error description: %@", error.description);
    
    // código error interno
    _codeHttpInt = 666;
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",_codeHttpInt],@"codigo",[NSDictionary dictionaryWithObjectsAndKeys:NSLocalizedString(@"DAO_errorGeneralConexion", nil), @"mensajeError", nil],@"datos", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:_postNotificationNameNSString object:nil userInfo:userInfo];
    NSLog(@"NOTIFICACION LANZADA: terminaRequestRed");
    
    [self manejarErrores];
    
    [self liberarConexionYOtrosParaARCANil];
}




@end
