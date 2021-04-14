%% Name- Saurabh Singh  Regiatration no- 20183022  MEB ME4
%% Design of Bevel Gear, References: Machine Design Shigley and PSG DataBook
%% Step 1: Basic Input Parameters 
P = input('Enter the Power transmitted');
x = input('Enter the value of x in x:1 speed reducer for the Worm gear Mesh');
h = input('Enter the time in Hours for daily usage of the gearset');
w = input('Enter the RPM for the Motor and Intial attached gear');
T = input('Enter the ambient temperature in degree Farenheit');
nd = input('Enter the Design factor of Safety');
%% Step 2: Pre-priori decisions
Nw = 2; %Number of Worm threads
Ng = Nw*x; %Acceptable number of gear teeths for pressure angle of 20 degrees
phin = 20; %Pressure angle in degrees
%% Step 3: Some Priori Decisions and related calculations
px = input('Select the value of axial Pitch for Worm gear in inches');
pt = pi/px;
D = Ng/pt;
a = 0.3183*px; %radius of addendum circle for worm gear
b = 0.3683*px; %radius of dedendum circle for worm gear
ht = 0.6866*px;
sum = 1;
while sum == 1
    d = input('Choose a Mean diameter for the worm gear in inches');
    C = (d+D)/2; %Centre to Centre distance
    %Checking for the Satisfactory value of 'd'
    dlow = power(C,0.875)/3;
    dhigh = power(C,0.875)/1.6;
    if (d<=dhigh)&&(d>=dlow)
        fprintf('The Selected value of mean diameter is correct and proceed furthur');
        sum = 2;
    else
       fprintf('The selected value of mean diameter is not valid and choose Other values');
       sum = 1;
    end
end
L = px*Nw;
lamda = atand(L/(pi*d));
Vs = (pi*d/12)*(w/cosd(lamda));
Vw = pi*d*w/12;
ng = w/x;
Vg = pi*d*ng/12;
%% Step 4: Some basic Calculations according to Input and Priori decisions made
Cs = input('Enter the value of Cs according to the material of Worm gear from the Shigley');
if (x>3&&x<=20)
    S1 = -x*x+40*x-76;
    Cm = 0.02*power(S1,0.5)+0.46;
elseif (x>20&&x<=76)
    S1 = -x*x+56*x+5145;
    Cm = 0.0107*power(S1,0.5);
else
    Cm = 1.1483-0.00658*x;
end
%Consider the value of Vs in ft/min
Vsft = Vs*3.28084;
if Vsft<700
    Cv = 0.659*power(2.718, -0.0011*Vsft);
elseif (Vsft>=700&&Vsft<3000)
    Cv = 13.31*power(Vsft, -0.571);
else
    Cv = 65.52*power(Vsft,-0.744);
end
%calculating the coefficient of friction
if (Vsft ==0)
    f = 0.15;
elseif (Vsft>0&&Vsft<=10)
    S2 = power(Vsft,0.645);
    f = 0.124*power(2.718,-0.074*S2);
else
    S2 = power(Vsft, 0.45);
    f = 0.103*power(2.718,-0.110*S2)+0.012;
end
ew = (cosd(phin)-f*tand(lamda))/(cosd(phin)+f*cotd(lamda));
eg = (cosd(phin)-f*cotd(lamda))/(cosd(phin)+f*tand(lamda));
Wgt = 33000*nd*P*1.25/(Vg*eg); %Tangential load on gear
A = (cosd(phin)*sind(lamda)+f*cosd(lamda))/(cosd(phin)*cosd(lamda)-f*sind(lamda));
Wwt = Wgt*A; %Tangential load on Wheel
Hw = Wwt*Vw*3.28084/33000;
Hg = Wgt*Vg*3.28084/33000;
Wf = f*Wgt/(f*sind(lamda)-cosd(phin)*cosd(lamda));
Hf = abs(Wf)*Vsft/33000;
B = power(D,0.8);
Fe = Wgt/(Cs*B*Cm*Cv);
Clamda = 2*d/3;
fprintf('Avilable range of Fe');
fprintf('%f\n',Fe);
fprintf('%f\n',Clamda);
Fer = input('Enter the value for Fe in the given range');
Wallt = Cs*B*Fer*Cm*Cv; 
wer = input('Enter 1 if there is fan or worm shaft and 2 if there is no fan or worm shaft');
if wer == 1
    hcr = (w/6494)+0.13;
else
    hcr = (w/3939)+0.13;
end
Hloss = 33000*(1-ew)*Hw;
%getting the AGMA Area
Amin = 43.2*power(C,1.7);
%Considering 6 Inches clearnace
Ver = d+D+6;
width = D+6;
thick = d+6;
arealateral = 2*Ver*width+2*width*thick+2*thick*Ver;
ts = T+(Hloss/(hcr*arealateral));
fprintf('%f',ts);
fprintf('Check the temperature and compare with the safe temperature for the Lubricant');
Pn = pt/cosd(lamda);
pn = pi/Pn;
%calculating the value of Gear Bending stress
sigma = Wgt/(pn*Fer*0.125);
%Calculating the value of allowable wear
Kw = input('Enter the worm gear load factor');
Wgtall = Kw*d*Fer;
ndmo = Wgtall/Wgt;

fprintf('The value of modified design factor of safety is %f',ndmo);






     

  
    


