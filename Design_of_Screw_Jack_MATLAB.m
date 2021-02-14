%% Design of Screw Jack
%% Step 1: Input of Basic Parameters
s =input('Enter the value of Maximum load capacity in N'); %Entering maximum load capacity
h =input('Enter the maximum height for moving the Load in mm'); %Entering maximum height of load
fos =input('Enter the Factor of Safety'); %Entering the Factor of Safety
%% Step 2: Selecting the material and general consideration
Hf = 400; %consideration of general force for analysis
n =input('Enter the number of worker exerting the force'); %No. of worker input to get the overall exerted force
Fe = 0.9*n*Hf; %Overall exerted force
Syc =input('Enter the compressive yeild strength'); %Entering the value of compressive yield strength according to material
Syt =input('Enter the tensile yield strength'); %Entering the value of tensile yeild strength according to material
sc = Syc/fos; %finding the compressive stress
%% Step 3: Design of Screw
dc = sqrt((4*s)/(3.1416*sc));  %Finding the core diameter
% Consideration of other stresses such as torsional stress and bending
% moments, the value of dc will be increased a little
% Doing the trail for value of dc
d =input('Enter the nominal diamter in mm'); %Entering the value of nominal diamter
p =input('Enter the value of pitch diamter in mm'); %Entering the value of pitch diameter
dcr = d-p; %Getting the trial value of core diameter
dm = d-(0.5*p); %Entering the trial value of mean diamter
% Assuming screw having single start threads
l =p;
a = atan(l/(3.1416*dm)); %getting the value of alpha
mu = 0.18; %maximum possible value of coefficient of friction
phi = atan(mu); %Finding the value of phi
if phi>a
    fprintf('The screw is self locking');
else
    fprintf('The screw is not self locking');
end
Mt =(s*dm*0.5)*tan(phi+a); 
tau =(16*Mt)/(3.1416*dcr*dcr*dcr); %value of shear stress due to moment
scc =(4*s)/(3.1416*dcr*dcr); %value of calculated compressive stress
l1 =h+70; %value of maximum height modified in mm
Mb =Fe*l1; %Bending moment
sb =(32*Mb)/(3.1416*dcr*dcr); %bending stress due to bending moment
taum = sqrt((power(sb,2))+power(tau,2)); %finding the maximum shear stress
FOS1 =0.5*Syt/taum;  %Finding the FOS in design of screw 
if FOS1>5
    fprintf('Design is safe');
else
    fprintf('Improve the design');
end
%% Step 4: Buckling consideration
lc =h+50; %Coloumn length in mm
k=dcr/4; %value of k
sr= l/k; %slendress ratio of screw for appliciability of Euler law
n = 0.25; %End fixity coefficient
E= input('Enter the Modulus of Elasticity in MPa'); %Enetering the elastic modulus for the Material
srcr =sqrt(2*n*3.1416*3.1416*E/Syt);  %Critical Slendress ratio
A= 3.1416*0.25*dcr*dcr; %Area of cross section
if sr>=srcr
    % Applying Euler formula
    Pcr =A*3.1416*3.1416*E*(1/(sr*sr)); %critical value of load
else
    %Applying Johnson formula
    Pcr= Syt*A*(1-((Syt*sr*sr)/(4*n*3.1416*3.1416*E))); %critical value of Load
end
FOS2= Pcr/s;
if FOS2>5
    fprintf('Design is safe');
else
    fprintf('Improve the design');
end
%% Step 5: Design of Nut
Sb= 10; %permissible bearing pressure in N/mm2
zy= (4*s)/(3.1416*Sb*(d*d-dcr*dcr)); %number of threads required
z= round(zy); %Rounding to the nearest integer as thread value can be integer only
H= z*p; %Axial length of Nut
taun= s/(3.1416*d*4.5*z);  %value of transverse shear stress at the root of thread
Sut= input('Enter the Ultimate tensile strength of material of Nut');
FOS3= 0.5*Sut/taun; 
if FOS3>5
    fprintf('Design is safe');
else
    fprintf('Improve the design');
end
%% Step 6: Design of Cup
Do= 1.6*d;
Di= 0.8*d;
Mtc= 0.2*s*(Do+Di)/4; %value of collar friction torque
Mtt= Mt+Mtc; %Total torque
lh= Mtt/(Fe); %Length of handle
% The length of the handle (lh) is too large and
%impractical. It is, therefore, necessary to change the
%design of the cup and replace the sliding friction
%by rolling friction by using thrust ball bearing. In
%thrust ball bearing, the friction torque (Mt
%)c is so
%small, that it can be neglected. 
Lh= 3000; %Life of thrust bearing assumed
N= input('Enter the speed of rotation of Handle in RPM'); %speed of rotation of Handle
L= 60*N*Lh/1000000; %Life of bearing
C= s*power(L,0.33333); %Dynamic Load capacity of bearing
% use rhe Data table according to DATA obtained above
%% Step 7: Design of Handle
lhm= Mt/Fe; %Modified value of Handle length by ignoring the friction torque
Syth =input('Enter the yeild tensile strength of material of Handle');
dh= power((32*Fe*lhm)/(3.1416*(Syth/5)),0.333333); %Diamter of Handle
%% NOTE: all the Dimensions of different components are found out and itrative process can be used to arrive at the most Appropriate value








