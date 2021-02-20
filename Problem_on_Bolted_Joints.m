%% Design of Non-Permanent Joint to Solve Q1 and 4 Given
%% Name- Saurabh Singh Reg no- 20183022 Class- ME4 MEB
%% Input 
A =input('Enter the value of A in mm'); % The first dimension
B =input('Enter the value of B in mm'); % The second dimension
C =input('Enter the value of C in mm'); % The third dimension
D =input('Enter the value of D in mm'); % The fourth dimension
E =input('Enter the value of E in mm'); % The fifth dimension
F =input('Enter the value of F in mm'); % The Sixth dimension
N =input('Enter the number of nuts and bolts'); %getting the number of nuts and Bolts
pg= input('Enter the gasket pressure in MPa'); %getting the gasket pressure in MPa
%% Bolt specs are M12 *1.75
%% Bolt Stifness calculation
l= D+E; 
c= 0;
L= input('Select the value of L from the reference of Shigley book, with L>=l+H, H=10.8 mm');
H= 10.8;
while c==0
    if L>=H+l
        fprintf('Entered value is sufficient move ahead');
        c= 1;
    else
        fprintf('Entered value is not sufficient and enter another value');
        L= input('Select the value of L from the reference of Shigley book, with L>=l+H, H=10.8 mm');
    end    
end
Lt= 2*12+6;
ld= L-Lt;
lt= l-ld;
Ad= pi*12*12*0.25; %(Area in mm2)
At= input('Enter the corresponding value of tensile area from table 8-1 MD shigley');
E= input('Enter the Youngs Modulus according to Material');
kb= Ad*At*E/(Ad*lt+At*ld); %Stifness of the bolt
%% Stifness of the member
Em1 =input('Enter the Modulus of Elasticity or youngs Modulus of First member');
Em2 =input('Enter the Modulus of Elasticity or youngs Modulus of second member');
t= 20;
D= 18;
d= 12;
q1= 1.155*t+D-d;
q2= 1.155*t+D+d;
K1= 0.5774*pi*Em1*d/(log((q1*(D+d)/q2*(D-d))));
K2= 0.5774*pi*Em2*d/(log((q1*(D+d)/q2*(D-d))));
km= 1/((1/K1)+(1/K2));
%% Finding Factor of Safety as required
C= kb/(kb+km);
Sp= input('Enter the Minimum proof strength accoring to material from table 8-11 of MD shigley');
Fi= 0.75*At*Sp;
Dw= input('Enter the effective sealing diamter');
Ptotal= pg*pi*0.25*Dw*Dw;
P= Ptotal/N;
np= Sp*At/(C*P+Fi);    %yeild factor of safety
nl= (Sp*At-Fi)/(C*P);  %Overload factor of safety
no= Fi/(P*(1-C));   %Sepreation factor of safety
%% Calculating gerbers and goodman FOS
x =input('Enter 1 for calcuting if fatigue loading is there otherwise press 0 to exist');
if x==1
    pgmin =input('Enter the minimum value of gasket pressure');
    pgmax =input('Enter the maximum value of gasket pressure');
    Se =input('Enter the modified Endurance strength');
    Sut =input('Enter the Ultimate tensile strength');
    Pmax= (pgmax*pi*0.25*Dw*Dw)/N;
    Pmin= (pgmin*pi*0.25*Dw*Dw)/N;
    sigmaA= C*(Pmax-Pmin)/(2*At);
    sigmai= Fi/At;
    sigmam= C*(Pmax+Pmin)/(2*At) + sigmai;
    %% Applying Goodmans 
    ngoodman= Se*(Sut-sigmai)/(sigmaA*(Sut+Se));
    %% Applying gerbers
    ngerber= (Sut*sqrt(Sut*Sut+4*Se*(Se+sigmai))-Sut*Sut-2*sigmai*Se)/(2*sigmaA*Se);
else
    fprintf('The Problem is Solved and no more step is required');
end
%% End of the Program
    

