function game()
   %
   %**代處理問題**
   %多重輸入問題
   %level等級
   %***********
   %
   %上下左右控制蛇，如果想跳出遊戲則按esc
   %
   flg_break=false; %跳出flg
   countPoint=0;
   %fig=figure([1 2],[1 1],'-o');
   fig = figure('name','貪吃蛇遊戲','KeyPressFcn',@kpfcn);
   drawReadyGo();
   
   mv=[1 0];
   x=[-4 -3];
   y=[0 0];
   
   eatx=randi([-4 4]);
   eaty=randi([-4 4]);
   
   while(true)
       clf;
       
       if(flg_break)  %break
           break;
       end
       
       drawSnake_Point_Title(x,y,eatx,eaty,countPoint);
       
       tempx=x(length(x))+mv(1);
       tempy=y(length(y))+mv(2);
       
       if(checkdie(x,y,tempx,tempy))
           x(1)=[];
           y(1)=[];
           clf;
           drawSnake_Point_Title([x tempx],[y tempy],eatx,eaty,countPoint); pause(0.5)
           drawLose();
           break;
       end
       
       if(tempx==eatx&&tempy==eaty)
           countPoint=countPoint+1;
           flgrepeat=true;
           while(flgrepeat)
               eatx=randi([-4 4]);
               eaty=randi([-4 4]);
               flgrepeat=checkRepeat(x,y,eatx,eaty);
           end
           x=[x(1) x];
           y=[y(1) y];
       end
       x(1)=[];
       y(1)=[];
       x=[x tempx];
       y=[y tempy];
   end
    
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
        flg_break=true;
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
           
   end
end

function drawReadyGo()
   %此函數畫出Ready Go !
   axis([-5 5 -5 5])
   set(gca,'ytick',[],'xtick',[]);
   hold on;
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
   set(gca,'ytick',[],'xtick',[]);
   hold on;
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
   plot(3,-1,'-ro','MarkerFaceColor','r'); drawnow; pause(3)
end
   
   
function drawSnake_Point_Title(x,y,ex,ey,countPoint)
   %此函數畫出蛇的身體，要吃的點，與計分Title
   axis([-5 5 -5 5])
   set(gca,'ytick',[],'xtick',[]);
   hold on;
   plot(ex,ey,['red','d'])    
   title(['point:',num2str(countPoint)],'Color','r','FontSize',15);
   plot(x,y,'-ko','MarkerFaceColor','k'); drawnow; pause(0.3)
end
   

function flg=checkdie(X,Y,x,y)
   %X,Y 為蛇的位置
   %x,y 下一個要到的位置
   %此函數檢測貪吃蛇是否死掉(i.e. 碰到自己or碰到牆壁)
   flg=false;
   for kk=1:length(X)-1
       if(X(kk)==x&&Y(kk)==y)
           disp('uu')
           flg=true;
           break;
       end
   end
   if(x==5||x==-5)
       flg=true;
   end
   if(y==5||y==-5)
       flg=true;
   end
end

function flg=checkReverse(a,b)
   %此函數檢測蛇吃到的此令使否違反方向(i.e 原本方向為向右，向左為反方向)
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
   
      
      