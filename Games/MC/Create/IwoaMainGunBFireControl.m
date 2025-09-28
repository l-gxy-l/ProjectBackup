clearvars

syms k n x0 x1 y0 y1 z0 z1 w y  alpha rotatedegree 
% ------------input-------------------------------------
k=input("k(Iowa)=21，炮管长度=","s");
n=input("n(Iowa)=7，装药量=","s");
x0=input("炮台底座中心坐标x0=","s");
y0=input("炮台底座中心坐标y0=","s");
z0=input("炮台底座中心坐标z0=","s");
x1=input("打击坐标x1=","s");
y1=input("打击坐标y1=","s");
z1=input("打击坐标z1=","s");
% ------------trans-------------------------------------
k=str2double(k);
n=str2double(n);
x0=str2double(x0);
y0=str2double(y0);
z0=str2double(z0);
x1=str2double(x1);
y1=str2double(y1);
z1=str2double(z1);
% ---------calcu----------------------------------------
w = sqrt((x1 - x0)*(x1 - x0) + (z1 - z0)*(z1 - z0));
y = y1 - y0;

syms x
alpha = solve((x1-x0)/(z1-z0) == tan(x), x );
alpha = double(alpha);
rotatedegree=alpha/pi*180;
clear x;
if x1-x0 >= 0
    if z1-z0 >= 0
        rotatedegree=0-rotatedegree;
    end
    if z1-z0 < 0
        rotatedegree=-180-rotatedegree;
    end
else
    if z1-z0 >= 0
        rotatedegree=-rotatedegree;
    end
    if z1-z0 < 0
        rotatedegree=180-rotatedegree;
    end
end


syms x
theta=solve(0 ==((5*sec(x)/n) + tan(x))*w + 500*log(1 - ((w*sec(x) - k)/(100*n)) ) - 5*k/n - y + 2,x);
clear x

t=[];q=[];
% --updegree
t=zeros (size(theta));
q=t;

syms i 
for i=1:1:numel(t)
    t(i)=-1*theta(i)/pi*180;
    q(i)=t(i)*8;
end    
clear i
% ------------export------------------------------------------------
if size(t)==1
    fprintf("以向南（z正向）为旋转原点，偏西（x负向）为正偏转，旋转%.1f度；以向下（y负向）为正转角，垂面转角%.1f合%.1f(1：8)转换度", rotatedegree, t(1),q(1))
else
    fprintf("以向南（z正向）为旋转原点，偏西（x负向）为正偏转，旋转%.1f度；以向下（y负向）为正转角，垂面转角%.1f / %.1f度合%.1f / %.1f(1：8)转换度", rotatedegree, t(1),t(2), q(1),q(2))
end

