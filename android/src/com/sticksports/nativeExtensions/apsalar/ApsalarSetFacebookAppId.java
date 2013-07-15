package com.sticksports.nativeExtensions.apsalar;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.apsalar.sdk.Apsalar;

public class ApsalarSetFacebookAppId implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		try
		{
			String version = args[0].getAsString();
			Apsalar.setFBAppId( version );
		}
		catch ( Exception exception )
		{
			Log.w( "Apsalar", exception );
		}
		return null;
	}
}
