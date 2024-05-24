function ar=circstat(x)


s=sin(x/180*pi);
c=cos(x/180*pi);
s=mean(s);
c=mean(c);
if abs(s)<1e-5 s=0; end;
if abs(c)<1e-5 c=0; end;
r=sqrt(s^2+c^2);
if c>0
   a=atan(s/c);
elseif c<0
   a=pi+atan(s/c);
else
   if s>0
      a=pi/2;
   elseif s<0
      a=3*pi/2;
   else
      a=NaN;
   end;
end;
a=180*a/pi;
if a<0
   a=a+360;
end;
a=round(a);
ar=[a;r];
