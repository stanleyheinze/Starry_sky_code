function [m, ci, r, samplesize, p]=orientation(alpha)

% Diese Funktion erstellt Kreisdiagramme von Orientierungsdaten.

% INPUT

%         alpha:orientatio gemessene Orientierungswinkel in Grad.

% OUTPUT

%         m: Mittelvektor der Orientierungsdaten in Grad
%         ci: 95% Konfidenzintervall in Grad (wenn vorhanden)
%         r: r-Wert
%         n: Stichprobengröße
%         p: Signifikanzniveau

% Oldenburg, Animal Navigation Lab

alpha1=zeros(1, length(alpha));   
for n=1:length(alpha)
    alpha1(n)=round(alpha(n)/1)*1;  % /5 *5 Winkeldaten auf die nächsten 5 Grad runden 
    if alpha1(n)==0
        alpha1(n)=360;
    end
end

alpha1=sort(alpha1, 'ascend');      % und aufsteigend sortieren


num=zeros(1,360);                          % Anzahl bestimmen, wie oft ein Winkel vorkommt

for i=1:length(alpha1)    
    num(alpha1(i))=num(alpha1(i))+1;    
end

alpha2=[];                                 % neuen Vektor erstellen, in dem die doppelten Winkel nicht mehr vorkommen

for n=1:length(alpha1)
    if n==1
        alpha2(length(alpha2)+1)=alpha1(n);
    elseif alpha1(n)~=alpha1(n-1)
        alpha2(length(alpha2)+1)=alpha1(n);
    end
end

clear i n


g=figure;
set(g, 'Units', 'centimeters', 'Position', [5 3 12 12], 'PaperUnits', 'centimeters', 'PaperPositionMode', 'manual', 'PaperSize', [1 1], ...
    'PaperPosition', [0 0 1 1], 'DefaulttextFontUnits', 'points', 'DefaulttextFontName', 'Arial', 'DefaulttextFontSize', 14)
set(gca, 'Units', 'normalized', 'Position', [0 0 1 1])

Kreis=0:0.01:360;                        % Daten, um den Kreis zu zeichnen

a=sind(Kreis);
b=cosd(Kreis);

plot(a,b, '-k', 'LineWidth', 2.5), hold on  % zeichnet das Kreisdiagramm mit einem Radius von 1
plot([0 0], [1 1.2], '-k', 'LineWidth', 2.5), hold on % zeichnet einen Strich bei 0°
text('Position', [0.475, 0.83], 'Units', 'normalized', 'String', 'gN') % schreibt 'mN' an die Stelle von 0°

xlim([-2 2])
ylim([-2 2])
axis square
set(gca, 'XTick', [])
set(gca, 'YTick', [])

% Orientierungswinkel als Punkte in das Kreisdiagramm einzeichnen

for n=1:length(alpha2)                     % x- und y-Koordinaten der Winkel berechnen

    if num(alpha2(n))==1
        x=sind(alpha2(n))+sind(alpha2(n))*0.04;          % in einem rechtwinkligen Dreieck gilt: sin(alpha)=GegenKathete/Hypothenuse
        y=cosd(alpha2(n))+cosd(alpha2(n))*0.04;          % (Hyp=Kreisradius=1) und cos(alpha)=Ankathete/Hypothenuse
        
        xa=sind(Kreis)*0.04+x;
        ya=cosd(Kreis)*0.04+y;
        
    elseif num(alpha2(n))>1                % bei Winkeln, die mehrmals vorkommen, Punkte übereinander legen
        
        for j=1:num(alpha2(n))
            
            if j==1
                x(j)=sind(alpha2(n))+sind(alpha2(n))*0.04;
                y(j)=cosd(alpha2(n))+cosd(alpha2(n))*0.04;
                
                xa(:,j)=sind(Kreis)*0.04+x(j);
                ya(:,j)=cosd(Kreis)*0.04+y(j);
            else
                x(j)=x(j-1)+(sind(alpha2(n))*0.08);
                y(j)=y(j-1)+(cosd(alpha2(n))*0.08);
                xa(:,j)=sind(Kreis)*0.04+x(j);
                ya(:,j)=cosd(Kreis)*0.04+y(j);
            end
        end
    end
    
    fill(xa,ya, 'k'), hold on
    clear x y xa ya
    
end

VR=circstat(alpha);       % Die Funktion circstat berechnet den mittleren Winkel (1. Wert) und den R-Wert (2. Wert).

xr=[0, sind(VR(1))*VR(2)];  % x- und y-Koordinaten des R-Vektors berechnen nach den Kathetensätzen (x ist die Gegenkathete,
yr=[0, cosd(VR(1))*VR(2)];  % y die Ankathete, der R-Wert die Hypothenuse).

%plot(xr, yr, '-k', 'LineWidth', 2.5) % stellt den R-Vektor als Strich dar

annotation('arrow', [0.5 xr(2)*0.25+0.5], [0.5 yr(2)*0.25+0.5], 'Units', 'normalized', 'LineWidth', 2.5, 'HeadStyle', 'vback2', ...
            'HeadWidth', 10, 'HeadLength', 10);  % stellt den R-Vektor als Pfeil dar, Anzeige ändert sich mit Skalierung!!


samplesize=length(alpha);

p=rayleigh_statistics(samplesize,VR(2));  % Die Funktion rayleigh_statistics berechnet, unter welcher Signifikanzschwelle
                                          % das berechnete r bei gegebenem n liegt. p als Funktionsoutput.
if isnan(p)==1
    p=1;
end

load rayleigh_RWerte
                                          
if samplesize >= 5 && samplesize <= 25         % aus der R-Werte-Tabelle den entsprechenden R-Wert für die Signifikanzschwellen
    N=find(rayleigh_RWerte(:,1)==samplesize);  % auslesen
elseif samplesize >25 && samplesize <= 30
    N=23;
elseif samplesize > 30 && samplesize <= 50
    N=24;
elseif samplesize > 50 && samplesize <= 100
    N=25;
elseif samplesize > 100 && samplesize <= 200
    N=26;
elseif samplesize > 200 && samplesize <= 500
    N=27;
end

if samplesize >=5 && samplesize <= 25           % x- und y-Koordinaten des 5%, 1% und 0.1%-Niveau-Kreises berechnen
    a05=sind(Kreis)*rayleigh_RWerte(N,2);
    b05=cosd(Kreis)*rayleigh_RWerte(N,2);
    a01=sind(Kreis)*rayleigh_RWerte(N,3);
    b01=cosd(Kreis)*rayleigh_RWerte(N,3);
    a001=sind(Kreis)*rayleigh_RWerte(N,4);
    b001=cosd(Kreis)*rayleigh_RWerte(N,4);
elseif samplesize < 5                           % bei einem n < 5 kann man nicht auf Signifikanz testen

else
    a05=sind(Kreis)*sqrt(rayleigh_RWerte(N,2)/samplesize);
    b05=cosd(Kreis)*sqrt(rayleigh_RWerte(N,2)/samplesize);
    a01=sind(Kreis)*sqrt(rayleigh_RWerte(N,3)/samplesize);
    b01=cosd(Kreis)*sqrt(rayleigh_RWerte(N,3)/samplesize);
    a001=sind(Kreis)*sqrt(rayleigh_RWerte(N,4)/samplesize);
    b001=cosd(Kreis)*sqrt(rayleigh_RWerte(N,4)/samplesize);
end

if samplesize >= 5                                    % ab einem n von 5 den 5%-Niveau-Kreis einzeichnen
    plot(a05, b05, '--k', 'LineWidth', 1.5), hold on
end

if p <= 0.01 && p < 0.05                              % wenn p<1%, den 1%-Niveau-Kreis einzeichnen
   plot(a01, b01, '--k', 'LineWidth', 1.5), hold on
end

if p == 0.001                                         % wenn p<0.1%, den 0.1%-Niveau-Kreis einzeichnen
    plot(a001, b001, '--k', 'LineWidth', 1.5), hold on
end


if p <= 0.05                    % wenn p<5%, Konfidenzintervalle einzeichnen
    
    alpha3=alpha*pi/180;        % Winkel in Bogenmaß umrechnen
    [m,d]=CircularConfidenceIntervals2(alpha3);    % Funktion berechnet die Konfidenzintervalle
    d=d*180/pi;                 % Konfidenzintervalle in Grad umrechnen
    
    for n=1:2                   % berücksichtigt die Verteilung um 0 bzw. 360°
        if d(n) < 0             
            d(n)=360+d(n);
        elseif d(n) > 360
            d(n)=d(n)-360;
        end
    end
    
    if (d(1) > 270 && d(2) < 90)                  % Genauigkeit beträgt ca. +- 5 Grad, deshalb Differenz der KI
        ci=round(abs(((d(1)+d(2))/2)+180-d(1)));  % zum zuvor berechneten und eingezeichneten Mittelwert berechnen
    elseif (d(2) > 270 && d(1) < 90)
        ci=round(abs(((d(1)+d(2))/2)+180-d(2)));
    else                                          % ci als Funktionsoutput
        ci=round(abs(((d(1)+d(2))/2)-d(1)));
    end
    
    xci=[sind(ci+VR(1)), sind(VR(1)-ci)];         % x- und y-Koordinaten der KI
    yci=[cosd(ci+VR(1)), cosd(VR(1)-ci)];
    
    plot([0 xci(1)], [0 yci(1)], '-k', 'LineWidth', 2), hold on
    plot([0 xci(2)], [0 yci(2)], '-k', 'LineWidth', 2), hold on
    
else ci=0;
    
end


if p<=0.05
    text('Position', [0.78, 0.95], 'Units', 'normalized', 'String', [num2str(VR(1)), '° +- ', num2str(ci), '°']);  % gibt die                                                                             % Informationen zum Mittelwert,
else                                                                                                                 % wenn gegeben, 
    text('Position', [0.78, 0.95], 'Units', 'normalized', 'String', [num2str(VR(1)), '°']);                        % Konfidenzintervall,
end

if round(VR(2)*100)/100 ~= 1
    text('Position', [0.78, 0.91], 'Units', 'normalized', 'String', ['r = ', num2str(round(VR(2)*100)/100)]);       % r-Wert,
else
    text('Position', [0.78, 0.91], 'Units', 'normalized', 'String', 'r = 0.99');
end

text('Position', [0.78, 0.87], 'Units', 'normalized', 'String', ['n = ', num2str(samplesize)]);                    % n und

if p<=0.05
    text('Position', [0.78, 0.83], 'Units', 'normalized', 'String', ['p < ', num2str(round(p*1000)/1000)]);         % Signifikanzniveau  
elseif n < 5                                                                                                         % in einer Textbox an.
    
else
    text('Position', [0.78, 0.83], 'Units', 'normalized', 'String', 'p = n.s.');
end

disp(['mean vector = ', num2str(VR(1)), '°'])
if p<=0.05
    disp(['ci = +-', num2str(ci), '°'])
end
disp(['r = ', num2str(VR(2))])
disp(['n = ', num2str(samplesize)])
if p<=0.05
    disp(['p < ', num2str(p)])
elseif n < 5
    
else
    disp('p = n.s.')
end

m=VR(1);
r=VR(2);

 













