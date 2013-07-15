package com.sticksports.nativeExtensions.apsalar;

import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.apsalar.sdk.Apsalar;

public class ApsalarStartSession implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		try
		{
			String apiKey = args[0].getAsString();
			String apiSecret = args[1].getAsString();
			Apsalar.startSession( context.getActivity(), apiKey, apiSecret );
		}
		catch ( Exception exception )
		{
			Log.w( "Apsalar", exception );
		}
		return null;
	}
}
