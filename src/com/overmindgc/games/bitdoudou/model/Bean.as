package com.overmindgc.games.bitdoudou.model
{
	
	import com.overmindgc.games.bitdoudou.utils.Consts;
	
	import flash.display.Sprite;

	public class Bean extends Sprite
	{
		//
		public var type:uint = 1;
		
		public function Bean()
		{
			randomColor();
		}
		
		/**
		 * 随机颜色
		 * */
		public function randomColor():void
		{
			var beanColor:uint = 0x0000ff;
			
			var randomNum:Number = Math.random();
			
			if(randomNum <= 0.1)
			{
				type = 1;
				beanColor = 0xff7575;
			} else if(randomNum > 0.1 && randomNum <= 0.2)
			{
				type = 2;
				beanColor = 0x9F35FF;
			} else if(randomNum > 0.2 && randomNum <= 0.3)
			{
				type = 3;
				beanColor = 0x0072E3;
			} else if(randomNum > 0.3 && randomNum <= 0.4)
			{
				type = 4;
				beanColor = 0xAE57A4;
			} else if(randomNum > 0.4 && randomNum <= 0.5)
			{
				type = 5;
				beanColor = 0xF9F900;
			} else if(randomNum > 0.5 && randomNum <= 0.6)
			{
				type = 6;
				beanColor = 0xFF5809;
			} else if(randomNum > 0.6 && randomNum <= 0.7)
			{
				type = 7;
				beanColor = 0x00ff00;
			} else if(randomNum > 0.7 && randomNum <= 0.8)
			{
				type = 8;
				beanColor = 0xAD5A5A;
			} else if(randomNum > 0.8 && randomNum <= 0.9)
			{
				type = 9;
				beanColor = 0xFF44FF;
			} else if(randomNum > 0.9 && randomNum <= 1)
			{
				type = 10;
				beanColor = 0x9D9D9D;
			}
			
			
//			this.graphics.clear();
			this.graphics.beginFill(beanColor);
			this.graphics.drawCircle(Consts.paneWidth / 2, Consts.paneWidth / 2, Consts.paneWidth/2);
		}
	}
}