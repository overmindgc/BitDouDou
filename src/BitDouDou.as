package
{
	import com.overmindgc.games.bitdoudou.model.Bean;
	import com.overmindgc.games.bitdoudou.model.Board;
	import com.overmindgc.games.bitdoudou.model.GameOverPage;
	import com.overmindgc.games.bitdoudou.model.StartPage;
	import com.overmindgc.games.bitdoudou.utils.Consts;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class BitDouDou extends Sprite
	{
		public static const STATE_INIT:int = 10;
		public static const STATE_PLAY:int = 20;
		public static const STETE_GAMEOVER:int = 30;
		
		public var gameState:int = 0;
		
		public var board:Board = new Board();
		
		public var startPage:StartPage = new StartPage();
		
		public var gameOverPage:GameOverPage = new GameOverPage();
		
		public var scoreText:TextField = new TextField();
		
		public var timerText:TextField = new TextField();
		
		public var gameTimer:Timer = new Timer(1000);
		
		public var beanArr:Array = [];
		
		public var remainingTime:int = 60;
		
		public var score:int = 0;
		
		public function BitDouDou()
		{
			addChild(board);
			
			scoreText.x = Consts.boardWidth + 5;
			scoreText.y = 10;
			scoreText.visible = false;
			addChild(scoreText);
			
			timerText.x = Consts.boardWidth + 5;
			timerText.y = 50;
			timerText.visible = false;
			addChild(timerText);
			
			gameState = STATE_INIT;
			
			addEventListener(Event.ENTER_FRAME,gameLoop);
			
			board.bg.addEventListener(MouseEvent.CLICK,mouseClick_Handler);
			
			gameTimer.addEventListener(TimerEvent.TIMER,function(evt:TimerEvent):void
			{
				remainingTime--;
			});
		}
		
		public function gameLoop(event:Event):void
		{
			switch(gameState)
			{
				case STATE_INIT:
				{
					initGame();
					break;
				}
				case STATE_PLAY:
				{
					playGame();
					break;
				}
				case STETE_GAMEOVER:
				{
					gameOver();
					break;
				}
			}
		}
		
		public function initGame():void
		{
			generateBeans();
			
			addChild(startPage);
			
			startPage.addEventListener("startGame",startGame_Handler);
			
			gameState = STATE_PLAY;
		}
		
		public function playGame():void
		{
			scoreText.text = "得分:" + score; 
			timerText.text = "剩余:" + remainingTime + "s";
			
			if(remainingTime == 0)
			{
				gameTimer.stop();
				gameState = STETE_GAMEOVER;
				showGameOverPage();
			}
		}
		
		public function gameOver():void
		{
			
		}
		
		protected function generateBeans():void
		{
			if(beanArr.length > 0)
			{
				for each(var b:Bean in beanArr)
				{
					removeChild(b);
				}
				beanArr = [];
			}
			while(beanArr.length < 200)
			{
				//随机0-19的整数，然后乘以方格宽度(中心点在左上角)
				var randomX:Number = (Math.round(Math.random() * (Consts.xNum - 1))) * Consts.paneWidth;
				var randomY:Number = (Math.round(Math.random() * (Consts.yNum - 1))) * Consts.paneWidth;
				
				var hasOne:Boolean = false;
				for each(var beanObj:Bean in beanArr)
				{
					if(randomX == beanObj.x && randomY == beanObj.y)
					{
						hasOne = true;
						break;
					}
				}
				
				if(!hasOne)
				{
					var bean:Bean = new Bean();
					bean.x = randomX;
					bean.y = randomY;
					beanArr.push(bean);
					addChild(bean);
				}
				
			}
		}
		
		protected function startGame_Handler(event:Event):void
		{
			this.removeChild(startPage);
			startPage.removeEventListener("startGame",startGame_Handler);
			scoreText.visible = true;
			timerText.visible = true;
			gameTimer.start();
		}
		
		protected function mouseClick_Handler(event:MouseEvent):void
		{
			var pointX:Number = event.localX;
			var pointY:Number = event.localY;
			
			trace(event.localX + "," + event.localY);
			
			var hitObjR:Sprite;
			var hitObjL:Sprite;
			var hitObjT:Sprite;
			var hitObjB:Sprite;
			
			//右边
			while(pointX < Consts.boardWidth && !hitObjR)
			{
				pointX = pointX + Consts.paneWidth;
				
				hitObjR = testCollisions(pointX,pointY);
			}
			
			pointX = event.localX;
			
			//左边
			while(pointX > 0 && !hitObjL)
			{
				pointX = pointX - Consts.paneWidth;
				
				hitObjL = testCollisions(pointX,pointY);
			}
			
			pointX = event.localX;
			
			//上边
			while(pointY > 0 && !hitObjT)
			{
				pointY = pointY - Consts.paneWidth;
				
				hitObjT = testCollisions(pointX,pointY);
			}
			
			pointY = event.localY;
			
			//下边
			while(pointY < Consts.boardHeight && !hitObjB)
			{
				pointY = pointY + Consts.paneWidth;
				
				hitObjB = testCollisions(pointX,pointY);
			}
			
			destroySameBean(Bean(hitObjL),Bean(hitObjR),Bean(hitObjT),Bean(hitObjB));
		}
		
		public function testCollisions(x:Number,y:Number):Sprite
		{
			var hitBean:Sprite;
			
			for each(var bean:Bean in beanArr)
			{
				if(bean.hitTestPoint(x,y))
				{
					hitBean = bean;
					trace(bean.type + "---" + bean.x + "," + bean.y);
					break;
				}
			}
			
			return hitBean;
		}
		
		/**
		 * 检测相同的并消去
		 * */
		public function destroySameBean(beanLeft:Bean,beanRight:Bean,beanTop:Bean,beanBottom:Bean):void
		{
			var sameBeanArr:Array = [];
			
			var hitBeanArr:Array = [];
			
			beanLeft ? hitBeanArr.push(beanLeft) : "";
			beanRight ? hitBeanArr.push(beanRight) : "";
			beanTop ? hitBeanArr.push(beanTop) : "";
			beanBottom ? hitBeanArr.push(beanBottom) : "";
			
			if(hitBeanArr.length > 1)
			{
				for each(var beanLoop:Bean in hitBeanArr)
				{
					for each(var hitBean:Bean in hitBeanArr)
					{
						if(hitBean != beanLoop)
						{
							if(beanLoop.type == hitBean.type)
							{
								if(sameBeanArr.indexOf(beanLoop) == -1)
								{
									sameBeanArr.push(beanLoop);
								}
								
								if(sameBeanArr.indexOf(hitBean) == -1)
								{
									sameBeanArr.push(hitBean);
								}
							}
						}
					}
				}
			}
			
		
			if(sameBeanArr.length > 1)
			{
				for each(var sameBean:Bean in sameBeanArr)
				{
					removeChild(sameBean);
					score++;
					var tempBeanArr:Array = [];
					for each(var bean:Bean in beanArr)
					{
						if(bean != sameBean)
						{
							tempBeanArr.push(bean);
						}
					}
					
					beanArr = tempBeanArr;
				}
			} else
			{
				if(remainingTime - 5 > 0)
				{
					remainingTime = remainingTime - 5;
				} else
				{
					remainingTime = 0;
				}
			}
		}
		
		protected function showGameOverPage():void
		{
			addChild(gameOverPage);
			gameOverPage.scoreTex.text = "你的分数：" + score;
			scoreText.visible = false;
			timerText.visible = false;
			
			gameOverPage.addEventListener("reStartGame",reStartGame_Handler);
		}
		
		protected function reStartGame_Handler(evt:Event):void
		{
			this.removeChild(gameOverPage);
			gameOverPage.removeEventListener("reStartGame",reStartGame_Handler);
			scoreText.visible = true;
			timerText.visible = true;
			score = 0;
			remainingTime = 60;
			gameTimer.start();
			gameState = STATE_PLAY;
			generateBeans();
		}
		
	}
}