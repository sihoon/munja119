package
{
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.core.UIComponent;
	public class BitmapTextC extends UIComponent
	{
		private var cellWidth:uint = 12;
		private var cellGap:uint = 2;
		private var speed:uint = 20;
		private var bitmapData:Array = [];
		private var timer:Timer;
		private var shiftCount:uint = 0;
		private var currentCount:uint = 0;
		
		public function BitmapTextC()
		{
			super();
		}
		override protected function createChildren():void{
			super.createChildren();
			
		}
		override public function initialize():void{
			super.initialize();
			timer = new Timer(speed,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerHandler);
		}
		private function timerHandler(e:TimerEvent):void{
			bitmapData.shift();
			invalidateDisplayList(); 
		}
		public function set Data(aValue:Array):void{
			for(var k:uint=0; k<aValue.length; k++){
				bitmapData.push(aValue[k]);
			}
			shiftCount = bitmapData.length;
			invalidateDisplayList();
		}
		public function set CellWidth(nValue:uint):void{
			if(nValue >= 2){
				cellWidth = nValue;
				invalidateDisplayList();
			}
		}
		public function set CellGap(nValue:uint):void{
			if(nValue >= 1){
				cellGap = nValue;
				invalidateDisplayList();
			}
		}
		public function set SlideSpeed(nValue:uint):void{
			if(nValue >= 1) timer.delay = speed = nValue;
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			graphics.clear();
			var celLen:uint = unscaledWidth / cellWidth;
			for(var k:uint=0; k<celLen; k++){
				for(var b:uint=0; b<13; b++){ 
					draw(k*cellWidth, b*cellWidth, (bitmapData[k]!=null)? bitmapData[k][b]:0x333333);
				}
			}
			shiftCount --;
			if(shiftCount <= celLen){
				this.dispatchEvent(new Event('shiftComplete'));
			}
			timer.start();
		}
		private function draw(x:Number, y:Number, color:uint=0x333333):void{
			var w:uint = x + cellWidth - cellGap;
			var h:uint = y + cellWidth - cellGap;
			var g:Graphics = this.graphics;
			g.beginFill(color);
			g.moveTo(x,y);
			g.lineTo(w,y);
			g.lineTo(w,h);
			g.lineTo(x,h);
			g.lineTo(x,y);
			g.endFill();
		}
	}

}