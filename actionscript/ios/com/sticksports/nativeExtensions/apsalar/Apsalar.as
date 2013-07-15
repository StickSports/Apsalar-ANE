package com.sticksports.nativeExtensions.apsalar
{
	import flash.external.ExtensionContext;
	
	public class Apsalar
	{
		private static var extensionContext : ExtensionContext = null;
		private static var sessionOpen : Boolean;
		
		private static function initExtension():void
		{
			if ( !extensionContext )
			{
				extensionContext = ExtensionContext.createExtensionContext( "com.sticksports.nativeExtensions.Apsalar", null );
			}
		}
		
		/**
		 * Is the extension supported
		 */
		public static function get isSupported() : Boolean
		{
			initExtension();
			return extensionContext ? true : false;
		}
		
		/**
		 * Indicates if we have an open session;
		 */
		public static function get isSessionOpen() : Boolean
		{
			return sessionOpen;
		}
		
		/**
		 * Start session, attempt to send saved sessions to the server.
		 */
		public static function startSession( apiKey : String, apiSecret : String, openUrl : String = "" ) : void
		{
			initExtension();
			if( openUrl )
			{
				extensionContext.call( NativeMethods.startSession, apiKey, apiSecret, openUrl );
			}
			else
			{
				extensionContext.call( NativeMethods.startSession, apiKey, apiSecret );
			}
			sessionOpen = true;
		}
		
		/**
		 * End session - android only.
		 */
		public static function endSession() : void
		{
			initExtension();
			extensionContext.call( NativeMethods.endSession );
			sessionOpen = false;
		}
		
		/**
		 * Log events.
		 */
		public static function logEvent( eventName : String, parameters : Object = null ) : void
		{
			if( parameters )
			{
				var array : Array = new Array();
				for( var key : String in parameters )
				{
					array.push( key );
					array.push( String( parameters[key] ) );
				}
				initExtension();
				extensionContext.call( NativeMethods.logEvent, eventName, array );
			}
			else
			{
				initExtension();
				extensionContext.call( NativeMethods.logEvent, eventName );
			}
		}
		
		/**
		 * Set the facebook app id (Android only).
		 */
		public static function setFacebookAppId( appId : String ) : void
		{
			
		}
		
		/**
		 * Clean up the extension - only if you no longer need it or want to free memory.
		 */
		public static function dispose() : void
		{
			if( extensionContext )
			{
				extensionContext.dispose();
				extensionContext = null;
			}
		}
	}
}
