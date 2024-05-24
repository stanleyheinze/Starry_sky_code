% 
  %clear all
%path_name = sprintf(path_name)%'C:\Users\David\Desktop\Files for Rubing Xue\Test files\SL\';% insert path to folder with recorded text files within the two '' here. here.
files_imp = dir(fullfile(path_name,'*.txt'));

for u=1:length(files_imp)
    
    load(fullfile(path_name, files_imp(u).name),'-ascii');
    
end
% 
pause(2)

q7=[]
q900=[]
Q=[]
A=[]
 XY=[]
 XY1=[]
 XY2=[]
B=[]
%Create a cell array A with name of mothmoth431 plus angles to evaluate in one
%column

for k=1:1000;
filenumber=k;

filename = [sprintf(file_identifier), (num2str((k)))];%sprintf(GG+num2str(k), filenumber);%Moth%d

    if exist(eval('filename'));
    a=eval(filename);
    d=[cellstr(char(filename))];
    A = [A ;d, a];
    
 elseif 1+1==2;
    
end
end


%Duration_flight %Here you can type in the length of the files which you want to analyze.
%The files in the folder "Test files" are 1500 timestamps long. This enables
%you to ignore files which are shorter than the others, e.g. when a moth
%stopped flying during an experiment.
q=[];


for k2=1:length(A);
    i=zeros(1);
    cell2mat=A{k2,2};
    a=cell2mat(:,1);
  
    if length(a)>=Duration_flight;
        i=i+1;
        q(end+1)=i';
   
    elseif length(a)<Duration_flight;
         i=i;
        q(end+1)=i';
   
    end
end
    %f=0.0  
    B=[]
    Q=[q]'
    m=[find(Q==1)];
    PPP=[]
   
    for d1=1:length(m)
        t=m(d1);
        cell2mat=A{t,2};
        a=cell2mat(:,1);
        a1=a(1:end); % if you replace the word end with a respective timestamp, the file will be analyzed only to this point.
        e=circstat(((a1)*3));
       
  
 if e(2,1)>=f%Here you can type in the r-value of the files which you want to analyze.
 %This enables you to ignore files of animals with low r-values, e.g. when a moth
 %was not very oriented. The value (here 0.0) should be between 0 and 1.
        disp(num2str(A{t,1}));
        q7(end+1)=e(1,1);
        q900(end+1)=e(2,1);
        PPP=[PPP; t]
      elseif 1+1==2;
      end
      
    end
    q1000=[[q7]', [q900]', [zeros(1,length(q7))+90]', [zeros(1,length(q7))+1]'];
    assignin('base','q1000',q1000);
    disp(A(PPP));
    [~,idx] = sort(q1000(:,2));
   sortedmat = q1000(idx,:);
    
for h=1:length(sortedmat)
   xcomp = h .* cos(sortedmat(h,1) * pi/180);
   ycomp = h .* sin(sortedmat(h,1) * pi/180);
   xcomp1 = h .* cos(sortedmat(h,3) * pi/180);
   ycomp1 = h .* sin(sortedmat(h,3) * pi/180);
   xcomp2 = sortedmat(h,2) .* cos(sortedmat(h,1) * pi/180);
   ycomp2 = sortedmat(h,2) .* sin(sortedmat(h,1) * pi/180);
%    theta=sortedmat(h,1)
%    rho=h
%    [x,y]=pol2cart(theta, rho) 
    XY=[XY; xcomp, ycomp]; % weighted data
    XY1=[XY1; xcomp1, ycomp1]; % hoechst moeglicher Rstar
    XY2=[XY2; xcomp2, ycomp2]; % tatsaechliche daten
end
%Rstar values und so
N=length(sortedmat);
%orientation(Polback(:,1))
R=((sum(XY(:,1)))^2 + (sum(XY(:,2)))^2);
Rjg=((sum(XY1(:,1)))^2 + (sum(XY1(:,2)))^2);
R=sqrt(R);
Rjg=sqrt(Rjg);
Rstar=R/((N)^(3/2));
Rjg=Rjg/((N)^(3/2));
p=exp(-6*(Rstar^2)*(N^2)/((N+1)*(2*N+1)));
Rlim=[0.999 1.239 1.517];
Diameters=[Rlim]/Rjg
length_Rst= Rstar/Rjg

%confidence intervals
  
 XY3=[]
nnow=length(XY2);

x1=mean(XY2(:,1));
y1=mean(XY2(:,2));
s1=var(XY2(:,1));
s2=var(XY2(:,2));
%COVxy=cov(XY2(:,1),XY2(:,2))
for n=1:length(XY2);
 var1=(XY2(n,1)-x1)*(XY2(n,2)-y1);
 XY3=[XY3; var1];
end
COVxy=sum(XY3)/(length(XY2)-1);
corcoef=COVxy/(sqrt(s1)*sqrt(s2));
Fval95=finv(0.95,2,(length(XY2)-2));
Fval99=finv(0.99,2,(length(XY2)-2));
Tsq95=2*((nnow-1)/(nnow-2))*Fval95;
Tsq99=2*((nnow-1)/(nnow-2))*Fval99;

 Ael=s2;
 Bel=COVxy*(-1);
 Cel=s1;
 Del95=(1-(corcoef^2))*s1*s2*(nnow^-1)*Tsq95;
 Del99=(1-(corcoef^2))*s1*s2*(nnow^-1)*Tsq99;
 Hel=Ael*Cel-(Bel^2);
 Gel95=Ael*(x1^2)+2*Bel*x1*y1+Cel*(y1^2)-Del95;
 Gel99=Ael*(x1^2)+2*Bel*x1*y1+Cel*(y1^2)-Del99;
 
U95=(Hel*(x1^2)-Cel*Del95)^-1;
U99=(Hel*(x1^2)-Cel*Del99)^-1;

V95=(Del95*Gel95*Hel)^(1/2);
V99=(Del99*Gel99*Hel)^(1/2);

W95=Hel*x1*y1+Bel*Del95;
W99=Hel*x1*y1+Bel*Del99;

m195=(W95+V95)*U95;
m295=(W95-V95)*U95;

ConfInt95min1=real(atand(m195))
ConfInt95min2=real(atand(m195)+180)
ConfInt95max1=real(atand(m295))
ConfInt95max2=real(atand(m295)+180)

%Grand mean vector
grand_mean_vec=atand(y1/ x1) ;

    if x1>0 & y1>0;
        grand_mean_vec=grand_mean_vec;
   elseif x1<0 & y1>0;
        grand_mean_vec=grand_mean_vec+180;
   elseif x1<0 & y1<0;
        grand_mean_vec=grand_mean_vec+180;
   elseif x1>0 & y1<0;
       grand_mean_vec=grand_mean_vec+360;
    end
    
 %Confidence intervalle
O1=abs(grand_mean_vec-ConfInt95min1)
if O1<=180 & O1>=0
    O1==O1
elseif O1>=180
    O1==abs(360-grand_mean_vec-ConfInt95min1)
end

O2=abs(grand_mean_vec-ConfInt95min2)
if O2<=180 & O2>=0
    O2==O2
elseif O2>=180
    O1==abs(360-grand_mean_vec-ConfInt95min2)
end

O3=abs(grand_mean_vec-ConfInt95max1)
if O3<=180 & O3>=0
    O3==O3
elseif O3>=180
    O3==abs(360-grand_mean_vec-ConfInt95max1)
end

O4=abs(grand_mean_vec-ConfInt95max2)
if O4<=180 & O4>=0
    O4==O4
elseif O4>=180
    O4==abs(360-grand_mean_vec-ConfInt95max2)
end

if O1 < O2 
    ConfInt95left=ConfInt95min1
elseif O2 < O1
    ConfInt95left=ConfInt95min2
end

if O3 < O4
    ConfInt95right=ConfInt95max1
elseif O4 < O3
     ConfInt95right=ConfInt95max2
end

if abs(ConfInt95right-ConfInt95left)<=180
    CI95 =abs(ConfInt95right-ConfInt95left)
elseif abs(ConfInt95right-ConfInt95left)>180
    CI95=abs(360-ConfInt95right-ConfInt95left)
end

if ConfInt95right <0
    ConfInt95right=ConfInt95right*(-1)
   ConfInt95right= abs(360-ConfInt95right)
elseif ConfInt95right >=0
    ConfInt95right=ConfInt95right%+180
end

if ConfInt95left <0
   ConfInt95left=ConfInt95left*(-1)
   ConfInt95left= abs(360-ConfInt95left)
elseif ConfInt95left >=0
    ConfInt95left=ConfInt95left+180%%%%change here
end

 assignin('base','ConfInt95right',ConfInt95right);
 assignin('base','ConfInt95left',ConfInt95left);
g=figure
set(g, 'Units', 'centimeters', 'Position', [5 3 12 12], 'PaperUnits', 'centimeters', 'PaperPositionMode', 'manual', 'PaperSize', [1 1], ...
    'PaperPosition', [0 0 1 1], 'DefaulttextFontUnits', 'points', 'DefaulttextFontName', 'Arial', 'DefaulttextFontSize', 14)
set(gca, 'Units', 'normalized', 'Position', [0 0 1 1])
 UT=round((sortedmat(:,1))/1)*1
 UT=UT*pi/180
 sortedmat=sortedmat(:,2)/max(sortedmat(:,2))
 [x,y]=pol2cart(UT, sortedmat)
 %h = compass(x,y,'-');
h=quiver(zeros(length(sortedmat),1),zeros(length(sortedmat),1),x,y,'AutoScaleFactor',1)
 set(h,'linewidth',2);
 set(h,'MaxHeadSize',0);
 set(h,'color','b') 
%  v1 = findall(gcf,'type','line')
%   set(v1,'Visible','off');

  
% v = findall(gcf,'type','text')
% delete(v)
% hold on
% for t = 1:length(h)
%     a = get(h(t), 'xdata'); 
%     b = get(h(t), 'ydata'); 
%     
%     set(h(t), 'xdata', a(1:2), 'ydata', b(1:2), 'color', 'b', 'linewidth',2)
%   % set(h(k), 'xdata', a(1:2), 'ydata', b(1:2), 'color', 'g', 'linewidth',3)
% end

hold on

if p<=0.05

 HT=round([ConfInt95left;ConfInt95right])
 HT=HT*pi/180
 sortedmat3=[1;1]
 [x,y]=pol2cart(HT, sortedmat3)
 m=quiver([0;0],[0;0],x,y,'AutoScaleFactor',1)
 set(m,'linewidth',2);
 set(m,'color','r')
 set(m,'LineStyle',':')
 set(m, 'ShowArrowHead', 'off')
 hold on

elseif p>0.05
        1+1==2
end
 
r =Diameters(1)
r2=Diameters(2)
r3=Diameters(3)
r4=1
k = 0;
for theta = 0:pi/100:2*pi
    k = k+1;
    xa(k) = r*cos(theta);
    ya(k) = r*sin(theta);
     xb(k) = r2*cos(theta);
    yb(k) = r2*sin(theta);
     xc(k) = r3*cos(theta);
    yc(k) = r3*sin(theta);
     xd(k) = r4*cos(theta);
    yd(k) = r4*sin(theta);
end
plot(xa,ya,'k--', 'linewidth',1);
hold on
plot(xb,yb,'k--', 'linewidth',1);
hold on
plot(xc,yc,'k--', 'linewidth',1);
hold on
plot(xd,yd,'k-', 'linewidth',1.5);

 PT=round([grand_mean_vec])
 PT=PT*pi/180
 sortedmat2=length_Rst
 [x,y]=pol2cart(PT, sortedmat2)
d=quiver(0,0,x,y,'AutoScale','off')%,'AutoScaleFactor',1)
 set(d,'linewidth',3);
 set(d,'MaxHeadSize',0);
 set(d,'color','y') 
            

 xr=[0, sind(grand_mean_vec)*sortedmat2];  % x- und y-Koordinaten des R-Vektors berechnen nach den Kathetensätzen (x ist die Gegenkathete,
 yr=[0, cosd(grand_mean_vec)*sortedmat2];
 
 ar=annotation('arrow', [0.5 xr(2)*0.33+0.5], [0.5 yr(2)*0.33+0.5], 'Units', 'normalized', 'LineWidth', 3, 'HeadStyle', 'vback2', ...
            'HeadWidth', 12, 'HeadLength', 12);  % stellt den R-Vektor als Pfeil dar, Anzeige ändert sich mit Skalierung!!
ar.Color = 'red';
 hold on

view(90,-90)

 axis off


xlim([-1.5 1.5])
ylim([-1.5 1.5])
plot([1 1.05], [0 0], '-k', 'LineWidth', 2.5), hold on % zeichnet einen Strich bei 0°
text('Position', [0.47, 0.88], 'Units', 'normalized', 'String', 'mN')
text('Position', [0.75, 0.82], 'Units', 'normalized', 'String', ['n = ', num2str(length(sortedmat))] ,'FontSize', 12)%text('Position', [0.48, 0.9], 'Units', 'normalized', 'String', 'mN') % 
text('Position', [0.75, 0.9], 'Units', 'normalized', 'String', ['R* = ', num2str(round(Rstar,3))] ,'FontSize', 12)%text('Position', [0.48, 0.9], 'Units', 'normalized', 'String', 'mN') % 
text('Position', [0.75, 0.94], 'Units', 'normalized', 'String', ['GM = ', num2str(round(grand_mean_vec,1)), '°'] ,'FontSize', 12)%text('Position', [0.48, 0.9], 'Units', 'normalized', 'String', 'mN') % 
text('Position', [0.75, 0.78], 'Units', 'normalized', 'String', ['p = ', num2str(p)],'FontSize', 12)%text('Position', [0.48, 0.9], 'Units', 'normalized', 'String', 'mN') % 
text('Position', [0.75, 0.86], 'Units', 'normalized', 'String', ['CI95% = ', num2str(round(CI95,1)), '°'],'FontSize', 12)%text('Position', [0.48, 0.9], 'Units', 'normalized', 'String', 'mN') % 
text('Position', [0.05, 0.05], 'Units', 'normalized', 'String', sprintf(Series),'Interpreter','none','FontSize', 8)%text('Position', [0.48, 0.9], 'Units', 'normalized', 'String', 'mN') % 
text('Position', [0.2, 0.05], 'Units', 'normalized', 'String', ['CI95% = ',num2str(round(ConfInt95left,2)),'°/'],'FontSize', 8)%text('Position', [0.48, 0.9], 'Units', 'normalized', 'String', 'mN') % 
text('Position', [0.4, 0.05], 'Units', 'normalized', 'String', [num2str(round(ConfInt95right,2)),'°'],'FontSize', 8)%text('Position', [0.48, 0.9], 'Units', 'normalized', 'String', 'mN') % 

set(gcf,'color','w');
p
grand_mean_vec
orientation(q1000(:,1));
% if POP==1
% orientation(q1000(:,1))
