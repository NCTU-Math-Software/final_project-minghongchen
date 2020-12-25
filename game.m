function game()
   %
   %mode==1 slow version
   %mode==2 quick version
   %mode==3 increasing version
   %
   %上下左右控制蛇，如果想跳出遊戲則按esc
   %
   ContinueGame=true; %是否繼續flg
   fig = figure('name','貪吃蛇遊戲','KeyPressFcn',@kpfcn);
   while(ContinueGame)
       mode=drawMode_1_2_3();
       
       speed=0.5;
       
       if(mode==2) %quick
           speed=0.1;
       end
       
       countPoint=0;
       
       drawReadyGo();
       
       mv=[1 0];
       x=[-4 -3];
       y=[0 0];
       
       eatx=randi([-4 4]);
       eaty=randi([-4 4]);
       
       while(true)
           clf;
           
           if(~ContinueGame)  %break
               break;
           end

           tempx=x(length(x))+mv(1);
           tempy=y(length(y))+mv(2);
           
           if(checkdie([x tempx],[y tempy]))
               clf;
               x(1)=[];
               y(1)=[];
               drawSnake_Point_Title([x tempx],[y tempy],eatx,eaty,countPoint,speed);
               drawLose();
               break;
           end
           
           if(tempx==eatx&&tempy==eaty)
               countPoint=countPoint+1;
               flgrepeat=true;
               while(flgrepeat)
                   eatx=randi([-4 4]);
                   eaty=randi([-4 4]);
                   flgrepeat=checkRepeat([x tempx],[y tempy],eatx,eaty);
               end
               x=[x(1) x];
               y=[y(1) y];
               
               if(mode==3)
               speed=speed-0.018;
               end
           end
           x(1)=[];
           y(1)=[];
           x=[x tempx];
           y=[y tempy];
           drawSnake_Point_Title(x,y,eatx,eaty,countPoint,speed);
           
           if(countPoint==25)
               drawWIN();
               clf;
               axis([-5 5 -5 5])
               hold on;
               box on;
               set(gca,'ytick',[],'xtick',[]); pause(0.5)
               drawWIN();
               clf;
               axis([-5 5 -5 5])
               hold on;
               box on;
               set(gca,'ytick',[],'xtick',[]); pause(0.5)
               drawWIN();
               break;
           end
       end
       
       if(ContinueGame)
           drawAGAIN_YES_NO();
           flgGet=false;
           while(~flgGet)
               [x,y,button]=ginput(1);
               flgGet=checkAgainYesOrNo(x,y,button);
           end
           if(flgGet==-1)
               ContinueGame=false;
           end
       end
   end
   drawThankYou();
   
function kpfcn(obj,event)
    switch event.Key
        case 'uparrow'
            if(checkReverse(mv,[0 1]))
                mv=[0 -1];
            else
                mv=[0 1];
            end
        case 'downarrow'
            if(checkReverse(mv,[0 -1]))
                mv=[0 1];
            else
                mv=[0 -1];
            end
        case 'rightarrow'
            if(checkReverse(mv,[1 0]))
                mv=[-1 0];
            else
                mv=[1 0];
            end
        case 'leftarrow'
            if(checkReverse(mv,[-1 0]))
                mv=[1 0];
            else
                mv=[-1 0];
            end
        case 'escape'
            ContinueGame=false;
    end
end
   
end

function y=f(x,o)
   %此函數為劃出 READY GO! ,LOSE所需函數
   switch o
       case 1
           y=sqrt(1-(x+4.5).*(x+4.5))+1;
       case 2
           y=-sqrt(1-(x+4.5).*(x+4.5))+1;
       case 3
           y=(-2).*(x+4.5);
       case 4
           y=sqrt(4-(2*x-3).*(2*x-3));
       case 5
           y=-sqrt(4-(2*x-3).*(2*x-3));
       case 6
           y=sqrt(4-(x+3).*(x+3));
       case 7
           y=-sqrt(4-(x+3).*(x+3));
       case 8
           y=sqrt(4-(x-1.5).*(x-1.5));
       case 9
           y=-sqrt(4-(x-1.5).*(x-1.5));
       case 10
           y=sqrt(1-(x+2).*(x+2));
       case 11
           y=-sqrt(1-(x+2).*(x+2));
       case 12
           y=sqrt(0.25-x.*x)+0.5;
       case 13
           y=-sqrt(0.25-x.*x)+0.5;
       case 14
           y=sqrt(0.25-x.*x)-0.5;
       case 15
           y=-sqrt(0.25-x.*x)-0.5;
       case 16
           y=sqrt(1-(x+2).*(x+2))+2;
       case 17
           y=-sqrt(1-(x+2).*(x+2))+2;      
       case 18
           y=sqrt(1-(x-3).*(x-3))-2;
       case 19
           y=-sqrt(1-(x-3).*(x-3))-2;
       case 20
           y=sqrt(1-(x+1.75).*(x+1.75))+2;
       case 21
           y=-sqrt(1-(x+1.75).*(x+1.75))+2;
       case 22
           y=sqrt(1-(x+0.5).*(x+0.5))+2;
       case 23
           y=-sqrt(1-(x+0.5).*(x+0.5))+2;
       case 24
           y=sqrt(2.25-(x+0.5).*(x+0.5))-2.5;
       case 25
           y=-sqrt(2.25-(x+0.5).*(x+0.5))-2.5;
   end
end

function M=drawMode_1_2_3()
   %此函數畫出MODE,1,2,3 and return mode 1or 2 or 3
   clf;
   axis([-5 5 -5 5])
   box on;
   hold on;
   set(gca,'ytick',[],'xtick',[]);
   %MODE?
   plot([-4 -4 -3.5 -3 -3],[1 3 1.5 3 1],'color',[0 0 1]); 
   tt=linspace(-2.75,-0.75);
   plot(tt,f(tt,20),'color',[0 0 1]);
   plot(tt,f(tt,21),'color',[0 0 1]);
   plot([-0.5 -0.5],[1 3],'color',[0 0 1]); 
   tt=linspace(-0.5,0.5);
   plot(tt,f(tt,22),'color',[0 0 1]);
   plot(tt,f(tt,23),'color',[0 0 1]);
   plot([1.75 0.75 0.75 1.75 0.75 0.75 1.75],[3 3 2 2 2 1 1],'color',[0 0 1]); 
   plot([2 3 3 2.5 2.5],[3 3 2 2 1.5],'color',[0 0 1]); 
   plot(2.5,1,'-bo','MarkerFaceColor','b'); 
   %1
   plot([-4 -2.5 -2.5 -4 -4],[-1 -1 -3 -3 -1],'color',[0 0 1]); 
   plot([-3.25 -3.25],[-1.25 -2.75],'color',[0 0 1]); 
   %2
   plot([-1 0.5 0.5 -1 -1],[-1 -1 -3 -3 -1],'color',[0 0 1]); 
   plot([-0.75 0.25 0.25 -0.75 -0.75 0.25],[-1.25 -1.25 -2 -2 -2.75 -2.75],'color',[0 0 1]); 
   %3
   plot([2 3.5 3.5 2 2],[-1 -1 -3 -3 -1],'color',[0 0 1]); 
   plot([2.25 3.25 3.25 2.25 3.25 3.25 2.25],[-1.25 -1.25 -2 -2 -2 -2.75 -2.75],'color',[0 0 1]);
   flg=true; %check user choose again?
   while(flg)
       [x,y,button]=ginput(1);
       if(x>=-4&&x<=-2.5)
           if(y>=-3&&y<=-1)
               M=1;
               flg=false;
           end
       end
       if(x>=-1&&x<=0.5)
           if(y>=-3&&y<=-1)
               M=2;
               flg=false;
           end
       end
       if(x>=2&&x<=3.5)
           if(y>=-3&&y<=-1)
               M=3;
               flg=false;
           end
       end
       if(button~=1)
       flg=true;
       end
   end
end
   
function drawThankYou()
   %此函數畫出ThankYou
   clf;
   axis([-5 5 -5 5])
   box on;
   hold on;
   set(gca,'ytick',[],'xtick',[]);
   plot([-4.9 -3.1 -4 -4],[3 3 3 0],'color',[0 0 1]);
   plot([-2.9 -2.9 -2.9 -1.1 -1.1 -1.1],[3 0 1.5 1.5 3 0],'color',[0 0 1]); 
   plot([-0.9 0 0.9],[0 3 0],'color',[0 0 1]);
   plot([-0.5 0.5],[1.4 1.4],'color',[0 0 1]);
   plot([1.1 1.1 2.4 2.4],[0 3 0 3],'color',[0 0 1]); 
   plot([2.8 2.8 2.8 4.2 2.8 4.2],[3 0 1.5 3 1.5 0],'color',[0 0 1]);
   plot([-4 -3 -2 -3 -3],[-1 -2 -1 -2 -4],'color',[0 0 1]);
   tt=linspace(-2,1);
   plot(tt,f(tt,24),'color',[0 0 1]);
   plot(tt,f(tt,25),'color',[0 0 1]);  
   plot([1.5 1.5 3.2 3.2],[-1 -4 -4 -1],'color',[0 0 1]); 
   plot([4 4],[-1 -3.5],'color',[0 0 1]); 
   plot(4,-4,'-bo','MarkerFaceColor','b');drawnow;
end
  
function flg=checkAgainYesOrNo(x,y,button)
   %此函數判斷使用者點擊Yes還是No
   %yes:flg=1,no:flg=-1,沒有判定flg=0
   flg=0;
   if(x>=-4.6&&x<=-0.9)
       if(y>=-3.1&&y<=-0.9)
           flg=1;
       end
   end
   if(x>=0.65&&x<=4.1)
       if(y>=-3.1&&y<=-0.9)
           flg=-1;
       end
   end  
   
   if(button~=1)
       flg=0;
   end
end
   
function drawAGAIN_YES_NO()
   %此函數畫AGAIN?,YES,NO
   clf;
   axis([-5 5 -5 5])
   box on;
   hold on;
   set(gca,'ytick',[],'xtick',[]);
   %A
   plot([-4 -3.5],[1 3],'color',[0 0 1]);
   plot([-3.5 -3],[3 1],'color',[0 0 1]);
   plot([-3.75 -3.25],[2 2],'color',[0 0 1]); 
   %G
   tt=linspace(-3,-1,201);
   plot(tt(1:101),f(tt(1:101),16),'color',[0 0 1]);
   plot(tt,f(tt,17),'color',[0 0 1]); 
   plot([-2 -1 -1],[2 2 1],'color',[0 0 1]); 
   %A
   plot([-0.75 -0.25],[1 3],'color',[0 0 1]);
   plot([-0.25 0.25],[3 1],'color',[0 0 1]);
   plot([-0.5 0],[2 2],'color',[0 0 1]);  
   %I
   plot([0.75 0.75],[3 1],'color',[0 0 1]);
   plot([0.5 1],[3 3],'color',[0 0 1]);
   plot([0.5 1],[1 1],'color',[0 0 1]); 
   %N
   plot([1.25 1.25 2.25 2.25],[1 3 1 3],'color',[0 0 1]);
   %?
   plot([3 4 4 3.5 3.5],[3 3 2 2 1.5],'color',[0 0 1]); 
   plot(3.5,1,'-bo','MarkerFaceColor','b');
   %YES
    plot([-4.6 -0.9 -0.9 -4.6 -4.6],[-0.9 -0.9 -3.1 -3.1 -0.9],'color',[0 0 1]); 
    plot([-4.5 -4 -4],[-1 -2 -3],'color',[0 0 1]); 
    plot([-3.5 -4],[-1 -2],'color',[0 0 1]); 
    plot([-2.25 -3.25 -3.25],[-1 -1 -2],'color',[0 0 1]); 
    plot([-2.25 -3.25 -3.25 -2.25],[-2 -2 -3 -3],'color',[0 0 1]); 
    plot([-1 -2 -2 -1 -1 -2],[-1 -1 -2 -2 -3 -3],'color',[0 0 1]);
    %NO
    plot([0.65 4.1 4.1 0.65 0.65],[-0.9 -0.9 -3.1 -3.1 -0.9],'color',[0 0 1]); 
    plot([0.75 0.75 1.75 1.75],[-3 -1 -3 -1],'color',[0 0 1]); 
    tt=linspace(2,4);
    plot(tt,f(tt,18),'color',[0 0 1]); 
    plot(tt,f(tt,19),'color',[0 0 1]);  drawnow;
end
   
function drawWIN()
   %此函數畫出WIN
   axis([-5 5 -5 5])
   box on;
   hold on;
   set(gca,'ytick',[],'xtick',[]);
   plot([-4.5 -3.5],[2 -2],'color',[1 0 0]);
   plot([-3.5 -2.5],[-2 2],'color',[1 0 0]);
   plot([-2.5 -1.5],[2 -2],'color',[1 0 0]);
   plot([-1.5 -0.5],[-2 2],'color',[1 0 0]); 
   plot([0.5 0.5],[2 -2],'color',[1 0 0]);
   plot([1.5 1.5],[2 -2],'color',[1 0 0]);
   plot([1.5 3.5],[2 -2],'color',[1 0 0]);
   plot([3.5 3.5],[2 -2],'color',[1 0 0]);
   plot([4.5 4.5],[2 -1],'color',[1 0 0]); 
   plot(4.5,-1.5,'-ro','MarkerFaceColor','r'); drawnow; pause(1)
end

function drawReadyGo()
   %此函數畫出Ready Go !
   clf;
   axis([-5 5 -5 5])
   box on;
   hold on;
   set(gca,'ytick',[],'xtick',[]);
   %R
   plot([-4.5 -4.5],[-2 2],'color',[1 0 0]);
   tt=linspace(-4.5,-3.5);
   plot(tt,f(tt,1),'color',[1 0 0]);
   plot(tt,f(tt,2),'color',[1 0 0]);
   plot(tt,f(tt,3),'color',[1 0 0]); 
   %E
   plot([-3 -3],[-2 2],'color',[1 0 0]);
   plot([-3 -1.5],[2 2],'color',[1 0 0]);
   plot([-3 -1.5],[0 0],'color',[1 0 0]);
   plot([-3 -1.5],[-2 -2],'color',[1 0 0]);
   %A
   plot([-1 0],[-2 2],'color',[1 0 0]);
   plot([0 1],[2 -2],'color',[1 0 0]); 
   plot([-2/3,2/3],[-0.5 -0.5],'color',[1 0 0]);
   %D
   plot([1.5 1.5],[2 -2],'color',[1 0 0]);
   tt=linspace(1.5,2.5);
   plot(tt,f(tt,4),'color',[1 0 0]);
   plot(tt,f(tt,5),'color',[1 0 0]);  
   %Y
   plot([2.5 3.5],[2 0],'color',[1 0 0]);
   plot([4.5 3.5],[2 0],'color',[1 0 0]);
   plot([3.5 3.5],[0 -2],'color',[1 0 0]); drawnow; pause(1)
   clf;
   axis([-5 5 -5 5])
   set(gca,'ytick',[],'xtick',[]);
   hold on;
   %G
   tt=linspace(-5,-1);
   plot(tt,f(tt,7),'color',[1 0 0]);
   tt=linspace(-5,-3);
   plot(tt,f(tt,6),'color',[1 0 0]); 
   plot([-3 -1],[0 0],'color',[1 0 0]);
   plot([-1 -1],[0 -2],'color',[1 0 0]);
   %O
   tt=linspace(-0.5,3.5);
   plot(tt,f(tt,8),'color',[1 0 0]);
   plot(tt,f(tt,9),'color',[1 0 0]);  
   %!
   plot([4.5 4.5],[2 -1],'color',[1 0 0]); 
   plot(4.5,-1.5,'-ro','MarkerFaceColor','r'); drawnow; pause(1)
end
           
function drawLose()
   %此函數畫出LOSE
   clf;
   axis([-5 5 -5 5])
   box on;
   hold on;
   set(gca,'ytick',[],'xtick',[]);
   %L
   plot([-4 -4],[1 -1],'color',[1 0 0]);
   plot([-4 -3],[-1 -1],'color',[1 0 0]);
   %O
   tt=linspace(-3,-1);
   plot(tt,f(tt,10),'color',[1 0 0]);
   plot(tt,f(tt,11),'color',[1 0 0]);
   %S
   tt=linspace(-0.5,0.5,201);
   plot(tt,f(tt,12),'color',[1 0 0]);
   plot(tt(1:101),f(tt(1:101),13),'color',[1 0 0]);
   plot(tt(101:201),f(tt(101:201),14),'color',[1 0 0]);
   plot(tt,f(tt,15),'color',[1 0 0]);  
   %E
   plot([1 1],[-1 1],'color',[1 0 0]);
   plot([1 2],[1 1],'color',[1 0 0]);
   plot([1 2],[0 0],'color',[1 0 0]);
   plot([1 2],[-1 -1],'color',[1 0 0]); 
   %!
   plot([3 3],[-0.5 1],'color',[1 0 0]);
   plot(3,-1,'-ro','MarkerFaceColor','r'); drawnow; pause(2)
end
   
function drawSnake_Point_Title(x,y,ex,ey,countPoint,speed)
   %此函數畫出蛇的身體，要吃的點，與計分Title
   axis([-5 5 -5 5])
   box on;
   hold on;
   set(gca,'ytick',[],'xtick',[]);
   plot(ex,ey,['red','d'])    
   title(['point:',num2str(countPoint)],'Color','r','FontSize',15);
       
   plot(x,y,'-ko','MarkerFaceColor','k'); drawnow; pause(speed)
end
   
function flg=checkdie(X,Y)
   %X,Y 為蛇的位置
   %此函數檢測貪吃蛇是否死掉(i.e. 碰到自己or碰到牆壁)
   flg=false;
   L=length(X);
   for kk=2:L-1
       if(X(kk)==X(L)&&Y(kk)==Y(L))
           flg=true;
           break;
       end
   end
   
   if(X(L)==5||X(L)==-5)
       flg=true;
   end
   if(Y(L)==5||Y(L)==-5)
       flg=true;
   end
end

function flg=checkReverse(a,b)
   %此函數檢測蛇吃到的此令使否違反方向(e.x. 原本方向為向右，向左為反方向)
   %a,b are vector
   flg=true;
   for jj=1:length(a)
       if(~(a(jj)+b(jj)==0))
           flg=false;
           break;
       end
   end
end

function flg=checkRepeat(X,Y,x,y)
   %此函數檢測產生的點是否為貪吃蛇的身體
   %yes return true otherwise return false
   % X,Y 為貪吃蛇的位置
   % x,y are 要吃的點的位置
   flg=false;
   for ii=1:length(X)
       if(X(ii)==x&&Y(ii)==y)
           flg=true;
           break;
       end
   end
end

  
      
      