//
//  ApsalarIosExtension.m
//  ApsalarIosExtension
//
//  Created by Richard Lord on 24/06/2013.
//  Copyright (c) 2013 Stick Sports. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import "Apsalar.h"
#import "Apsalar_TypeConversion.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

Apsalar_TypeConversion* apsalarConverter;

DEFINE_ANE_FUNCTION( apsalar_startSession )
{
    if( argc == 3 )
    {
        NSString* apiKey;
        NSString* apiSecret;
        NSString* openUrl;
        
        if( [apsalarConverter FREGetObject:argv[0] asString:&apiKey ] == FRE_OK
           && [apsalarConverter FREGetObject:argv[1] asString:&apiSecret ] == FRE_OK
           && [apsalarConverter FREGetObject:argv[2] asString:&openUrl ] == FRE_OK)
        {
            [Apsalar startSession:apiKey withKey:apiSecret andURL:[ NSURL URLWithString:openUrl ] ];
        }
    }
    else if( argc == 2 )
    {
        NSString* apiKey;
        NSString* apiSecret;
        
        if( [apsalarConverter FREGetObject:argv[0] asString:&apiKey ] == FRE_OK
           && [apsalarConverter FREGetObject:argv[1] asString:&apiSecret ] == FRE_OK)
        {
            [Apsalar startSession:apiKey withKey:apiSecret];
        }
    }
    
    return NULL;
}

DEFINE_ANE_FUNCTION( apsalar_endSession )
{
    [Apsalar endSession];
    return NULL;
}

DEFINE_ANE_FUNCTION( apsalar_logEvent )
{
    NSString* event;
    if( [apsalarConverter FREGetObject:argv[0] asString:&event ] != FRE_OK ) return NULL;
    
    if( argc == 2 )
    {
        FREObject array = argv[1];
        uint32_t length = 0;
        if( FREGetArrayLength( array, &length ) != FRE_OK ) return NULL;
        uint32_t count = length >> 1;
        if( count > 0 )
        {
            NSMutableDictionary * parameters = [NSMutableDictionary dictionaryWithCapacity:count];
            uint32_t i;
            NSString* key;
            NSString* value;
            FREObject fo;
            
            for( i = 0; i < count; ++i )
            {
                if( FREGetArrayElementAt( array, i * 2, &fo ) != FRE_OK ) continue;
                if( [apsalarConverter FREGetObject:fo asString:&key ] != FRE_OK ) continue;
                
                if( FREGetArrayElementAt( array, i * 2 + 1, &fo ) != FRE_OK ) continue;
                if( [apsalarConverter FREGetObject:fo asString:&value ] != FRE_OK ) continue;
                
                [parameters setValue:value forKey:key];
            }
            
            [Apsalar event:event withArgs:parameters];
        }
        else
        {
            [Apsalar event:event];
        }
    }
    else
    {
        [Apsalar event:event];
    }
    return NULL;
}


void ApsalarContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet )
{
    static FRENamedFunction functionMap[] =
    {
        MAP_FUNCTION( apsalar_startSession, NULL ),
        MAP_FUNCTION( apsalar_endSession, NULL ),
        MAP_FUNCTION( apsalar_logEvent, NULL )
    };
    
    *numFunctionsToSet = sizeof( functionMap ) / sizeof( FRENamedFunction );
    *functionsToSet = functionMap;
}

void ApsalarContextFinalizer( FREContext ctx )
{
}

void ApsalarExtensionInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet )
{
    extDataToSet = NULL;
    *ctxInitializerToSet = &ApsalarContextInitializer;
    *ctxFinalizerToSet = &ApsalarContextFinalizer;
    
    apsalarConverter = [[Apsalar_TypeConversion alloc] init];
}

void ApsalarExtensionFinalizer()
{
    [apsalarConverter release];
    return;
}

