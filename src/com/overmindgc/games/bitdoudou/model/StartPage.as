package com.overmindgc.games.bitdoudou.model
{
	import com.overmindgc.games.bitdoudou.utils.Consts;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class StartPage extends Sprite
	{
		public var bg:Sprite = new Sprite();
		
		public var titleText:TextField = new TextField();
		
		public var startLinkText:TextField = new TextField();
		
		public var startButton:Sprite = new Sprite();
		
		public function StartPage()
		{
			bg.graphics.beginFill(0xffffff,0.9);
			bg.graphics.drawRect(0,0,Consts.boardWidth,Consts.boardHeight);
			bg.graphics.endFill();
			this.addChild(bg);
			
			var tfTitle:TextFormat = new TextFormat();
			tfTitle.align = "center";
			tfTitle.size = 50;
			tfTitle.bold = true;
			
			titleText.width = Consts.boardWidth;
			titleText.defaultTextFormat = tfTitle;
			titleText.text = "打豆豆小游戏";
			titleText.textColor = 0x9ACD32;
			titleText.x = 0;
			titleText.y = (Consts.boardHeight - titleText.height) / 2.8;
			
			bg.addChild(titleText);
			
			var tfStart:TextFormat = new TextFormat();
			tfStart.size = 40;
			tfStart.bold = true;
			
			startLinkText.text = "开始游戏";
			startLinkText.textColor = 0x000000;
			startLinkText.defaultTextFormat = tfStart;
			startLinkText.x = (this.width - startLinkText.width) / 2 + 25;
			startLinkText.y = titleText.y + titleText.height + 17;
			bg.addChild(startLinkText);
			
			
			startButton.graphics.beginFill(0xf58220,1);
			startButton.graphics.drawRoundRect(0,0,80,30,5,5);
			startButton.graphics.endFill();
			startButton.buttonMode = true;
			startButton.alpha = 0.5;
			startButton.x = (this.width - startButton.width) / 2;
			startButton.y = titleText.y + titleText.height + 10;
			bg.addChild(startButton);
			
			startButton.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void
			{
				dispatchEvent(new Event("startGame",true));
			});

		}
	}
}