package com.overmindgc.games.bitdoudou.model
{
	
	import com.overmindgc.games.bitdoudou.utils.Consts;
	
	import flash.display.Sprite;
	
	public class Board extends Sprite
	{
		public var w:Number = Consts.boardWidth;
		public var h:Number = Consts.boardHeight;
		
		public var xNum:int = Consts.xNum;
		public var yNum:int = Consts.yNum;
		public var paneW:Number = Consts.paneWidth;
		
		public var bg:Sprite = new Sprite();
		
		public var grid:Sprite = new Sprite();
		
		public function Board()
		{
			bg.graphics.beginFill(0xffffff,1);
			bg.graphics.drawRect(0,0,w,h);
			bg.graphics.endFill();
			this.addChild(bg);
			
			//画边框（粗线）
			grid.graphics.lineStyle(1, 0x222222);
			grid.graphics.lineTo(xNum * paneW , 0);
			grid.graphics.lineTo(xNum * paneW ,yNum * paneW);
			grid.graphics.lineTo(0, yNum * paneW );
			grid.graphics.lineTo(0,0);
			grid.graphics.lineStyle();
			
			//画垂直和水平方向的线条
			grid.graphics.lineStyle(1, 0x333333, 0.5);
			for (var i:int = 0; i < xNum-1;i++ ) {
				grid.graphics.moveTo(paneW * (i + 1), 0);
				grid.graphics.lineTo(paneW * (i + 1), paneW*yNum);
			}
			for (i = 0; i < yNum-1;i++ ) {
				grid.graphics.moveTo(0, paneW*(i+1));
				grid.graphics.lineTo(paneW * xNum , paneW*(i+1));
			}
			
			this.addChild(grid);
		}
	}
}