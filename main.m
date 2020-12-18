function main()
fig = figure('KeyPressFcn',@kpfcn);
mv=[1 0];
x=[1 2];
y=[0 0];
eatx=randi([-9 10]);
eaty=randi([-9 10]);
while(true)
    clf;
     plot(eatx,eaty,'-o')
    axis([-10 10 -10 10])
    hold on;
    plot(x,y,'-o'); drawnow; pause(0.1)
    tempx=x(length(x))+mv(1);
    tempy=y(length(y))+mv(2);
    x(1)=[];
    y(1)=[];
    x=[x tempx];
    y=[y tempy];
end
 
function kpfcn(obj,event)
switch event.Key
case 'uparrow'
   mv=[0 1];
case 'downarrow'
    mv=[0 -1];
case 'rightarrow'
    mv=[1 0];
case 'leftarrow'
    mv=[-1 0];
end
end
end