package
{
	import com.sticksports.nativeExtensions.apsalar.Apsalar;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	[SWF(width='320', height='480', frameRate='30', backgroundColor='#000000')]

	public class ApsalarExtensionTest extends Sprite
	{
		private var direction : int = 1;
		private var shape : Shape;
		private var feedback : TextField;

		private var buttonFormat : TextFormat;
		
		private var eventName : String = "testEvent";
		private var paramEventName : String = "testParamEvent";
		
		private var apsalarKey : String = "richardlord";
		private var apsalarSecret : String = "2KDLK4go";
		
		public function ApsalarExtensionTest()
		{
			shape = new Shape();
			shape.graphics.beginFill( 0x666666 );
			shape.graphics.drawCircle( 0, 0, 100 );
			shape.graphics.endFill();
			shape.x = 0;
			shape.y = 240;
			addChild( shape );

			feedback = new TextField();
			var format : TextFormat = new TextFormat();
			format.font = "_sans";
			format.size = 16;
			format.color = 0xFFFFFF;
			feedback.defaultTextFormat = format;
			feedback.width = 320;
			feedback.height = 260;
			feedback.x = 10;
			feedback.y = 170;
			feedback.multiline = true;
			feedback.wordWrap = true;
			addChild( feedback );

			addEventListener( Event.ENTER_FRAME, animate );

			createButtons();
		}

		private function createButtons() : void
		{
			var tf : TextField = createButton( "startSession" );
			tf.x = 10;
			tf.y = 10;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, startSession );
			addChild( tf );

			tf = createButton( "endSession" );
			tf.x = 170;
			tf.y = 10;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, endSession );
			addChild( tf );

			tf = createButton( "logEvent" );
			tf.x = 10;
			tf.y = 50;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, logEvent );
			addChild( tf );

			tf = createButton( "logEventWithParams" );
			tf.x = 170;
			tf.y = 50;
			tf.addEventListener( MouseEvent.MOUSE_DOWN, logEventWithParams );
			addChild( tf );
		}

		private function createButton( label : String ) : TextField
		{
			if ( !buttonFormat )
			{
				buttonFormat = new TextFormat();
				buttonFormat.font = "_sans";
				buttonFormat.size = 14;
				buttonFormat.bold = true;
				buttonFormat.color = 0xFFFFFF;
				buttonFormat.align = TextFormatAlign.CENTER;
			}

			var textField : TextField = new TextField();
			textField.defaultTextFormat = buttonFormat;
			textField.width = 140;
			textField.height = 30;
			textField.text = label;
			textField.backgroundColor = 0xCC0000;
			textField.background = true;
			textField.selectable = false;
			textField.multiline = false;
			textField.wordWrap = false;
			return textField;
		}

		private function startSession( event : MouseEvent ) : void
		{
			feedback.text = "Apsalar.startSession( apsalarKey, apsalarSecret )";
			Apsalar.startSession( apsalarKey, apsalarSecret );
		}

		private function endSession( event : MouseEvent ) : void
		{
			feedback.text = "Apsalar.endSession()";
			Apsalar.endSession();
		}

		private function logEvent( event : MouseEvent ) : void
		{
			feedback.text = "Apsalar.logEvent( eventName )";
			Apsalar.logEvent( eventName );
		}

		private function logEventWithParams( event : MouseEvent ) : void
		{
			feedback.text = "Apsalar.logEvent( paramEventName, {...} )";
			Apsalar.logEvent( paramEventName, { size : Capabilities.screenResolutionX + " x " + Capabilities.screenResolutionY, dpi : Capabilities.screenDPI } );
		}

		private function animate( event : Event ) : void
		{
			shape.x += direction;
			if ( shape.x <= 0 )
			{
				direction = 1;
			}
			if ( shape.x > 320 )
			{
				direction = -1;
			}
		}
	}
}