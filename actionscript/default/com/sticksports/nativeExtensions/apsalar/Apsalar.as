package com.sticksports.nativeExtensions.apsalar
{
	public class Apsalar
	{
		/**
		 * Is the extension supported
		 */
		public static function get isSupported() : Boolean
		{
			return false;
		}
		
		/**
		 * Indicates if we have an open session;
		 */
		public static function get isSessionOpen() : Boolean
		{
			return false;
		}

		/**
		 * Start session.
		 */
		public static function startSession( apiKey : String, apiSecret : String, openUrl : String = "" ) : void
		{
		}

		/**
		 * End session.
		 */
		public static function endSession() : void
		{
		}

		/**
		 * Log event.
		 */
		public static function logEvent( eventName : String, parameters : Object = null ) : void
		{
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
		}
	}
}
