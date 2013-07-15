package com.sticksports.nativeExtensions.apsalar;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.apsalar.sdk.Apsalar;

public class ApsalarEndSession implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		try
		{
			Apsalar.endSession();
		}
		catch ( Exception exception )
		{
			Log.w( "Apsalar", exception );
		}
		return null;
	}
}
