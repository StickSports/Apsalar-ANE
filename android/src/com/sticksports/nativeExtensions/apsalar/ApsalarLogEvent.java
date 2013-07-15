package com.sticksports.nativeExtensions.apsalar;

import org.json.JSONObject;

import android.util.Log;

import com.adobe.fre.FREArray;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.apsalar.sdk.Apsalar;

public class ApsalarLogEvent implements FREFunction
{

	@Override
	public FREObject call( FREContext context, FREObject[] args )
	{
		try
		{
			String event = args[0].getAsString();
			if( args.length == 2 )
			{
		        FREArray array = ( FREArray )args[1];
		        long length = array.getLength();
		        long count = length >> 1;
		        if( count > 0 )
		        {
		        	JSONObject parameters = new JSONObject();
		            long i;
		            for( i = 0; i < count; ++i )
		            {
		            	String key = array.getObjectAt( i * 2 ).getAsString();
		            	String value = array.getObjectAt( i * 2 + 1 ).getAsString();
		                parameters.put( key, value );
		            }
		            Apsalar.event( event, parameters );
		        }
		        else
		        {
		        	Apsalar.event( event );
		        }
			}
			else
			{
				Apsalar.event( event );
			}
		}
		catch ( Exception exception )
		{
			Log.w( "Apsalar", exception );
		}
		return null;
	}

}

