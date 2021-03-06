%% Design of Spur Gear for any Application
%% Name- Mani Sanguri   Registration no- 20183027  Class- MEB ME4
%% References- PSG Design Data Book, Machine Design Shigley, and Juvinel Machine components Design
%% Step 0- Input Parameters
Ptrans= input('Enter the value of Power transmitted in KW');  %This is the value of Power transmitted through the Spur gear and Pinion
rpm= input('Enter the Speed of Pinion or the Machine driving the Pinion'); %This is the RPM input
Rr= input('Enter the reduction ratio i.e. x in x:1');
%% Step 1-Selection of Gear tooth Profile
sp= input('Select the tooth Profile from the Following Options: Press 1 for 20 degrees Full depth Involute Press 2 for 14.5 degrees full depth Involute, there are more Options available though');
if sp==1
    phi= 20;
else
    phi= 14.5;
end
%% Step 2- Determining number of teeths in Gear and Pinion
fo= 1; %Addendum factor for full depth involute gear teeth profile
Z1= round(2*fo/(power(sind(phi),2))); %Number of teeths on Pinion
Z2= round(Rr*Z1);  %Number of teeths on Gear
Rrm= Z2/Z1; %Modified Reduction ratio from number of teeths calculation
%% Step 3- Selection of Materials
% Select the Material from PSG 8.4 and Input the Following Input Parameters
sb= input('Enter the safe Bending strength');
sc= input('Enter the safe contact Strength');
fos= input('Enter the factor of Safety');
sbb= sb/fos;
scc= sc/fos;
%% Step 4-Determining the Weaker Element
%a- Calculation for Pinion
y1= pi*(0.154-(0.912/Z1));  %Lewis form factor for Pinion
Fs1= sbb*y1; %Value for Pinion
%b- Calculation for Gear
y2= pi*(0.154-(0.912/Z2));  %Lewis form factor for Gear
Fs2= scc*y2; %Value for Gear
if Fs2>=Fs1
    fprintf('Pinion is Weaker and design will be based on Pinion now');
    %% Step 5- Calculation of Modules Based on Beam strength
    kdk= 1.5; %for Unsymetric overhanging scheme
    Mt= (97420/rpm)*1.2*1.3*kdk;
    m= 1.26*power((Mt/(sbb*10*y1*Z1)),0.333333333);
    %Increase the module by 20% to compensate in Radial loading
    ms= 1.2*m;
    %From the given Modules = ms, select the suitable greater than or equal
    %to value from PSG 8.2
    fprintf('%f',ms); 
    msd =input('Enter the Modules value selected from PSG in mm');
    dp= msd*Z1; %Pitch Circle Diameter
    b= 10*m; %Face width 
    %% Step 6- Calculation of Lewis dynamic loading and Buckinghams Dynamic Loading
    Fs1d= sbb*msd*b*y1; %Beam strength of Pinion
    %Finding the Pitch velocity for Calculating the Dynamic factor
    v= pi*dp*rpm/60; %(m/s)
    if v<=10
        Cv= (3+v)/3;
    elseif v>10&&v<=20
        Cv= (6+v)/6;
    else
        Cv= (5.5+sqrt(v))/5.5;
    end
    Fd= 2*Mt*Cv/dp; %Value of Dynamic loading
    if Fs1d>=Fd
        fprintf('Design is safe');
    else
        fprintf('Design is not safe');
    end
    %Calculating buckinghams dynamic loading
    e= input('Enter the excepted error in mm from design data for Commercially cut gear');
    Cb= 11860*e;
    Vm= v*60; %Velocity in m/min
    Ft= 2*Mt/dp;
    fdb= Ft+((0.164*Vm*(Cb+Ft))/(0.164*Vm+1.485*sqrt(Cb+Ft))); %Buckinghams Dynamic Loading
    if Fs1d>=fdb
        fprintf('Design is safe');
    else
        fprintf('Design is not safe');
    end
    %% Step 7- Checking for Wear Loading
    qw= input('Enter 1 for Internal Meshing and 2 for External Meshing');
    a= m*(Z1+Z2)/2;  %Centre to centre distance
    E= input('Enter the Modulus of Elasicity in MPa for Material of Pinion');
    if qw==1
        Q= (2*Rrm)/(Rrm-1);
        Scca= (0.74*(Rrm-1)/a)*sqrt(((Rrm-1)/(Rrm*b))*E*Mt);
    else
        Q= (2*Rrm)/(Rrm+1);
        Scca= (0.74*(Rrm+1)/a)*sqrt(((Rrm+1)/(Rrm*b))*E*Mt);
    end
    K= sbb*sbb*sind(phi)*(2/E)/1.4;
    Fw= dp*Q*K*b;
    if Fw>=Fd
        fprintf('Design is safe');
    else
        fprintf('Design is not safe');
    end
    %% Step 8- Checking for Contact Stresses
    if Scca<=scc
        fprintf('Design is safe');
    else
        fprintf('Design is not safe');
    end
else
    fprintf('Gear is Weaker and design will be based on Gear now');
    %% Step 5- Calculation of Modules Based on Beam strength
    kdk= 1.5; %for Unsymetric overhanging scheme
    Mt= (97420/rpm)*1.2*1.3*kdk;
    m= 1.26*power((Mt/(sbb*10*y2*Z2)),0.333333333);
    %Increase the module by 20% to compensate in Radial loading
    ms= 1.2*m;
    %From the given Modules = ms, select the suitable greater than or equal
    %to value from PSG 8.2
    fprintf('%f',ms);
    msd =input('Enter the Modules value selected from PSG in mm');
    dp= msd*Z2; %Pitch Circle Diameter
    b= 10*m; %Face width 
    %% Step 6- Calculation of Lewis dynamic loading and Buckinghams Dynamic Loading
    Fs1d= sbb*msd*b*y2; %Beam strength of Pinion
    %Finding the Pitch velocity for Calculating the Dynamic factor
    v= pi*dp*rpm/60; %(m/s)
    if v<=10
        Cv= (3+v)/3;
    elseif v>10&&v<=20
        Cv= (6+v)/6;
    else
        Cv= (5.5+sqrt(v))/5.5;
    end
    Fd= 2*Mt*Cv/dp; %Value of Dynamic loading
    if Fs1d>=Fd
        fprintf('Design is safe');
    else
        fprintf('Design is not safe');
    end
    %Calculating buckinghams dynamic loading
    e= input('Enter the excepted error in mm from design data for Commercially cut gear');
    Cb= 11860*e;
    Vm= v*60; %Velocity in m/min
    Ft= 2*Mt/dp;
    fdb= Ft+((0.164*Vm*(Cb+Ft))/(0.164*Vm+1.485*sqrt(Cb+Ft))); %Buckinghams Dynamic Loading
    if Fs1d>=fdb
        fprintf('Design is safe');
    else
        fprintf('Design is not safe');
    end
    %% Step 7- Checking for Wear Loading
    qw= input('Enter 1 for Internal Meshing and 2 for External Meshing');
    a= m*(Z1+Z2)/2;  %Centre to centre distance
    E= input('Enter the Modulus of Elasicity in MPa for Material of Pinion');
    if qw==1
        Q= (2*Rrm)/(Rrm-1);
        Scca= (0.74*(Rrm-1)/a)*sqrt(((Rrm-1)/(Rrm*b))*E*Mt);
    else
        Q= (2*Rrm)/(Rrm+1);
        Scca= (0.74*(Rrm+1)/a)*sqrt(((Rrm+1)/(Rrm*b))*E*Mt);
    end
    K= sbb*sbb*sind(phi)*(2/E)/1.4;
    Fw= dp*Q*K*b;
    if Fw>=Fd
        fprintf('Design is safe');
    else
        fprintf('Design is not safe');
    end
    %% Step 8- Checking for Contact Stresses
    if Scca<=scc
        fprintf('Design is safe');
    else
        fprintf('Design is not safe');
    end
end
%% Design is Completed

    
    
