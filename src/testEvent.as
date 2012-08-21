package {
	
	import flash.events.Event;
	
	public class testEvent extends Event{
		
		public var data:*;
		
		public function testEvent(type:String, body:* = null){
			
			this.data = body;
			
			super(type);
		}
	}
}