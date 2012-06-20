package com.overmindgc.games.bitdoudou.model
{
	import com.overmindgc.games.bitdoudou.utils.Consts;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class GameOverPage extends Sprite
	{
		public var bg:Sprite = new Sprite();
		
		public var gameOverText:TextField = new TextField();
		
		public var scoreTex:TextField = new TextField();
		
		public var overLinkText:TextField = new TextField();
		
		public function GameOverPage()
		{
			bg.graphics.beginFill(0xffffff,0.9);
			bg.graphics.drawRect(0,0,Consts.boardWidth,Consts.boardHeight);
			bg.graphics.endFill();
			this.addChild(bg);
			
			var tfTitle:TextFormat = new TextFormat();
			tfTitle.align = "center";
			tfTitle.size = 50;
			tfTitle.bold = true;
			
			gameOverText.width = Consts.boardWidth;
			gameOverText.defaultTextFormat = tfTitle;
			gameOverText.text = "时间到!";
			gameOverText.textColor = 0xFF5809;
			gameOverText.x = 0;
			gameOverText.y = (Consts.boardHeight - gameOverText.height) / 3;
			
			bg.addChild(gameOverText);
			
			var tfScore:TextFormat = new TextFormat();
			tfScore.align = "center";
			tfScore.size = 30;
			tfScore.bold = true;
			
			scoreTex.width = Consts.boardWidth;
			scoreTex.defaultTextFormat = tfScore;
			scoreTex.text = "你的得分：";
			scoreTex.textColor = 0x00BB00;
			scoreTex.x = 0;
			scoreTex.y = gameOverText.y + gameOverText.height;
			
			bg.addChild(scoreTex);
			
			var tfOver:TextFormat = new TextFormat();
			tfOver.size = 40;
			tfOver.bold = true;
			
			overLinkText.text = "重新开始";
			overLinkText.textColor = 0x000000;
			overLinkText.defaultTextFormat = tfOver;
			overLinkText.x = (this.width - overLinkText.width) / 2 + 25;
			overLinkText.y = scoreTex.y + scoreTex.height + 7;
			bg.addChild(overLinkText);
			
			var overButton:Sprite = new Sprite();
			overButton.graphics.beginFill(0xf58220,1);
			overButton.graphics.drawRoundRect(0,0,80,30,5,5);
			overButton.graphics.endFill();
			overButton.buttonMode = true;
			overButton.alpha = 0.5;
			overButton.x = (this.width - overButton.width) / 2;
			overButton.y = scoreTex.y + scoreTex.height;
			bg.addChild(overButton);
			
			overButton.addEventListener(MouseEvent.CLICK,function(evt:MouseEvent):void
			{
				dispatchEvent(new Event("reStartGame",true));
			});
		}
	}
}