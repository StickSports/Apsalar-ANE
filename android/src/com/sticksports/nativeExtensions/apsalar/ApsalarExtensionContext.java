package com.sticksports.nativeExtensions.apsalar;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;

public class ApsalarExtensionContext extends FREContext
{
	@Override
	public void dispose()
	{
	}

	@Override
	public Map<String, FREFunction> getFunctions()
	{
		Map<String, FREFunction> functionMap = new HashMap<String, FREFunction>();
		functionMap.put( "apsalar_setFacebookAppId", new ApsalarSetFacebookAppId() );
		functionMap.put( "apsalar_startSession", new ApsalarStartSession() );
		functionMap.put( "apsalar_endSession", new ApsalarEndSession() );
		functionMap.put( "apsalar_logEvent", new ApsalarLogEvent() );
		return functionMap;
	}

}
