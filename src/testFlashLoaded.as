package
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.Security;
	import flash.text.TextField;
	
	public class testFlashLoaded extends Sprite
	{
		private	var loader:Loader;
		
		public 	var caption:TextField; 
		
		public	var loadedSWF:Sprite;
		
		public	var swfName:TextField;
		
		public function testFlashLoaded()
		{
			var red:Sprite = new Sprite();
			red.graphics.beginFill(0xff0000);
			red.graphics.drawRect(0, 0, 200, 200);
			red.graphics.endFill();
			
			addChild(red);
			
			Security.allowDomain('*');
			Security.allowInsecureDomain('*');
			
			trace('red', Security.sandboxType);
			
			loader = new Loader();
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete, false, 0, true);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loadIOError, false, 0, true);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadSecurityError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress, false, 0, true);
			
			var request:URLRequest = new URLRequest('green.swf');
			
			loader.load(request);
			
			caption = new TextField();
			caption.x = 0;
			caption.y = 180;
			caption.height = 20;
			caption.width = 200;
			caption.text = 'red';
			caption.name = 'caption';
			addChild(caption);
			
			swfName = new TextField();
			swfName.x = 0;
			swfName.y = 0;
			swfName.name = 'swfName';
			addChild(swfName);
		}
		private function loadSecurityError(e:SecurityErrorEvent):void{
			trace(e.text);
		}
		
		private function loadProgress(e:ProgressEvent):void{
			trace('testFlashLoaded loadProgress', e.bytesLoaded/e.bytesTotal);
		}
		
		private function loadIOError(e:IOErrorEvent):void{
			trace('testFlashLoaded loadIOError', e.text );
		}
		
		private function loadComplete(e:Event):void{
			
			trace('green loaded');

			loadedSWF = e.currentTarget.content as Sprite;
			
			((loadedSWF.getChildByName('green_mc') as Sprite).getChildByName('caption') as TextField).text += ' - red';
			addChild( loadedSWF );
			loader = null;
			
			this.dispatchEvent(new testEvent('greenLoaded', loadedSWF.name));
		}
	}
}