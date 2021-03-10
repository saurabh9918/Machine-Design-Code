
%% Design of Helical Gear for any application
%% Name- Saurabh Singh
%% References- PSG Design Data Book, Machine Design Shigley, and Juvinel Machine Components Design
%% Steps 0 to 8 are carried out to Design a Helical Gear

%% Step 0- Input Parameters

Ptrans= input('Enter the value of Power transmitted in KW');  %This is the value of Power transmitted through the Spur gear and Pinion
N1= input('Enter the Speed of Pinion or the Machine driving the Pinion'); %This is the RPM of the pinion input
N2= input('Enter the Speed of Gear or the Motor driving the Gear'); %This is the RPM of the gear input
b= input('Enter the value of Helix angle'); %This is the value of the Helix Angle
sp= input('Select the tooth Profile from the Following Options: \nPress 1 for 20 degrees Full depth Involute \nPress 2 for 14.5 degrees full depth Involute, there are more Options available though'); %This is the value of Prssure Angle
pi= 3.1416;

%% Step 1-Selection of Gear tooth Profile

if sp==1
    phi= 20;
else
    phi= 14.5;
end

%% Step 2- Determining number of teeths in Gear and Pinion

fo= 1; %Addendum factor for full depth involute gear teeth profile
Zv1= 2*fo/(power(sind(phi),2)); %Virtual number of teeths on Pinion 
Z1= round(Zv1*(cosd(b))^3); 
i= N1/N2; %Reduction ratio from rpm of the gear and pinion
Z2= round(i*Z1);  
Zv2= Z2/((cosd(b))^3); %Virtual number of teeths on Gear 
i= Z2/Z1; %Modified Reduction ratio from number of teeths calculation

%% Step 3- Selection of Materials

% Select the Material from PSG 8.4 and Input the Following Input Parameters

% For Pinion
sbp= input('Enter the safe Bending Strength for material selected for pinion'); %Bending Strength for pinion
scp= input('Enter the safe Contact Stress for material selected for pinion'); %Contact Stress for pinion
fosp= input('Enter the factor of Safety'); %Factor of Safety for the Pinion
sbbp= sbp/fosp;
sccp= scp/fosp;

% For Gear
sbg= input('Enter the safe Bending Strength for material selected for gear'); %Bending Strength for gear
scg= input('Enter the safe Contact Stress for material selected for gear'); %Contact Stress for gear
fosg= input('Enter the factor of Safety'); %Factor of Safety for the Gear
sbbg= sbg/fosg;
sccg= scg/fosg;

%% Step 4-Determining the Weaker Element

%a- Calculation for Pinion
Yv1= pi*(0.154-(0.912/Zv1));  %Lewis form factor for Pinion
Fs1= sbbp*Yv1; %Strength factor for Pinion

%b- Calculation for Gear
Yv2= pi*(0.154-(0.912/Zv2));  %Lewis form factor for Gear
Fs2= sbbg*Yv2; %Strength factor for Gear

if Fs2>=Fs1
    fprintf('Pinion is Weaker and design will be based on Pinion now');
    
    %% Step 5- Calculation of Modules Based on Beam strength
    
    P= Ptrans*1.2; % Design Power
    mtn= 97420*P/N1; % Nominal Torsional Moment
    Kdk= 1.3; % For Symmetrical System
    mto= mtn*Kdk; % Design Torsional Moment
    mn= 1.15*cosd(b)*power((mto/(Yv1*sbbp*Z1*15)),(1/3)); 
    ms= 1.2*mn; %Increase the module by 20% to compensate in Radial loadingms= 1.2*mn;
    
    %From the given Modules = ms, select the suitable greater than or equal
    %to value from PSG 8.2
    
    fprintf('\n%f\n',ms); 
    msd= input('Enter the Modules value selected from PSG in mm');
    mt= msd/cosd(b); %Transverse Module in mm
    d1= mt*Z1; %Pitch Circle Diameter in mm
    b1= 15*mn; %Face width in mm
    a= ((Z1+Z2)*mt)/20; %Centre to centre distance in cm
    
    %% Step 6- Calculation of Buckinghams Dynamic Loading
    
    Fsld= sbbp*msd*b1*Yv1; %Beam strength of Pinion
    Ft= 2*mt/d1; %Tangential Load
    Vm= pi*d1*N1; 
    e= input('Enter the excepted error in mm from design data for Commercially cut gear');
    c= 11860*e; %PSG 8.53 Table 41
    Fdb= Ft+((0.164*Vm*(c*b1*(cosd(b))^2+Ft)*cosd(b))/(0.164*Vm+1.485*(c*b1*(cosd(b))^2))); %Buckinghams Dynamic Loading
    if Fsld>=Fdb
        fprintf('Design is safe\n');
    else
        fprintf('Design is not safe\n');
    end
    % Increase msd to the next value and re-check by re-running the code
    
    %% Step 7- Checking for Wear Loading
    
    qw= input('Enter 1 for Internal Meshing and 2 for External Meshing');
    a= mt*(Z1+Z2)/2;  %Centre to centre distance
    E1= input('Enter the Modulus of Elasicity in MPa(E1)');
    E2=E1; %PSG 8.15
    if qw==1
        Q= (2*i)/(i-1);
    else
        Q= (2*i)/(i+1);
    end
    K= (((sccp)^2)*sind(phi)*(1/E1+1/E2))/1.4;
    Fw= d1*Q*K*b1/(cosd(b))^2;
    if Fw>=Fdb
        fprintf('Design is safe');
    else
        fprintf('Design is not safe');
        %To make the design safe
        sccp= sqrt((Fdb*1.4*(cosd(b))^2)/(d1*Q*sind(phi)*(1/E1+1/E2)));
        %PSG 8.15
        cb=input('Enter the value of cB from table 16');
        kcl=input('Enter the value of Kcl from table 17');
        hb= sccp/cb*1;
        fprintf('Brinell Hardness Number is %f',hb);
    end
    
    %% Step 8- Checking for Contact Stresses
    
    Scca= ((0.7*i+1)/a)*sqrt(((i+1)/(i*b1))*E1*mt);
    if Scca<=scp
        fprintf('Design is safe');
    else
        fprintf('Design is not safe');
    end
    
else
    fprintf('Gear is Weaker and design will be based on Gear now');
    
    %% Step 5- Calculation of Modules Based on Beam strength
    
    P= Ptrans*1.2; % Design Power
    mtn= 97420*P/N2; % Nominal Torsional Moment
    Kdk= 1.3; % For Symmetrical System
    mto= mtn*Kdk; % Design Torsional Moment
    mn= 1.15*((cosd(b)))*(mto/(Yv2*sbbg*Z2*15))^(1/3);%Increase the module by 20% to compensate in Radial loading
    ms= 1.2*mn;
    
    %From the given Modules = ms, select the suitable greater than or equal
    %to value from PSG 8.2
    
    fprintf('\n%f\n',ms); 
    msd= input('Enter the Modules value selected from PSG in mm');
    mt= msd/cosd(b);  %Transverse Module in mm
    d1= mt*Z1; %Pitch Circle Diameter in mm
    b1= 15*mn; %Face width in mm
    a= ((Z1+Z2)*mt)/20; %Centre to centre distance in cm
    
    %% Step 6- Calculation of Buckinghams Dynamic Loading
    
    Fsld= sbbg*msd*b1*Yv2; %Beam strength of Gear
    Ft= 2*mt/d1; %Tangential Load
    Vm= pi*d1*N2;
    e= input('Enter the excepted error in mm from design data for Commercially cut gear');
    c= 11860*e; %PSG 8.53 Table 41
    Fdb= Ft+((0.164*Vm*(c*b1*(cosd(b))^2+Ft)*cosd(b))/(0.164*Vm+1.485*(c*b1*(cosd(b))^2))); %Buckinghams Dynamic Loading
    if Fsld>=Fdb
        fprintf('Design is safe');
    else
        fprintf('Design is not safe');
    end
    % Increase msd to the next value and re-check
    
    %% Step 7- Checking for Wear Loading
    
    qw= input('Enter 1 for Internal Meshing and 2 for External Meshing');
    a= mt*(Z1+Z2)/2;  %Centre to centre distance
    E1= input('Enter the Modulus of Elasicity in MPa(E1)');
    E2=E1; %PSG 8.15
    if qw==1
        Q= (2*i)/(i-1);
    else
        Q= (2*i)/(i+1);
    end
    K= (((sccg)^2)*sind(phi)*(1/E1+1/E2))/1.4;
    Fw= d1*Q*K*b1/(cosd(b))^2;
    if Fw>=Fdb
        fprintf('Design is safe');
    else
        fprintf('Design is not safe');
        %To make the design safe
        sccg= sqrt((Fdb*1.4*(cosd(b))^2)/(d1*Q*sind(phi)*(1/E1+1/E2)));
        %PSG 8.15
        cb=input('Enter the value of cB from table 16');
        kcl=input('Enter the value of Kcl from table 17');
        hb= sccp/cb*1;
        fprintf('Brinell Hardness Number is %f',hb);
    end
    
    %% Step 8- Checking for Contact Stresses
    
    Scca= ((0.7*i+1)/a)*sqrt(((i+1)/(i*b1))*E1*mt);
    if Scca<=scg
        fprintf('Design is safe');
    else
        fprintf('Design is not safe');
    end
end

%% Design is Completed 