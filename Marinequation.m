%code for Marin Equation for Endurance limit, which differes from real
%endurance limit
Setest =input('Enter the value of tested endurance limit'); %Entering the value of tested endurance limit

%Getting the value of Ka, kb, kc, kd, ke, kf
for i = 1:6
    if i==1
        Sut =input('Enter the Value of ultimate tensile strength'); %getting the value of Ultimate tensile strength
        q =input('Enter the condition of Surface finish: 1-Ground  2-Machined or cold-rolled  3-Hot-rolled  4-As forged'); %getting the Surface condition
        if q==1
            a = 1.58;
            b = -0.085;
        elseif q==2
            a = 4.51;
            b = -0.265;
        elseif q==3
            a = 57.7;
            b = -0.718;
        else
            a = 272;
            b = -0.995;
        end
        Ka = a*power(Sut,b);  %getting the value of Surface_modification factor
    elseif i==2
        w = input('Enter the type of loading: 1-Bending and torsion  2-Axial Loading'); %getting the type of Loading
        if w==1
            d = input('Enter the diameter in mm');   %getting the diameter of rotating component
            if d>=2.79&&d<=51
                Kb = 1.24*power(d,-0.107); %getting the value of Size Modification factor
            elseif d>51&&d<=254
                Kb = 1.51*power(d,-0.157); %getting the value of Size Modification factor
            end
        else
            Kb = 1; %getting the value of size modification factor
        end
    elseif i==3
        we =input('Enter the type of Loading- 1:Bending 2:Axial 3:Torsion'); %Entering the type of Loading
        if we==1
            Kc = 1;  %getting the value of Load Modification factor
        elseif we==2
            Kc = 0.85;  %getting the Value of Load Modification factor
        else
            Kc = 0.59;  %getting the value of Load modification factor
        end  
    elseif i==4
        Tf =input('Enter the temperature in degree fahrenheit');
        Kd = 0.975+0.000432*Tf-0.00000115*Tf*Tf+0.00000000104*Tf*Tf*Tf-0.000000000000595*Tf*Tf*Tf*Tf; %Getting the value of Temperature Modification factor
    elseif i==5
        re =input('Enter the reliability Percentage');  %getting the reliability percentage
        if re==50
            za = 0;
        elseif re==90
            za = 1.288;
        elseif re==95
            za = 1.645;
        elseif re==99
            za = 2.326;
        elseif re==99.9
            za = 3.091;
        else
            za = 3.719;
        end
        Ke = 1-0.08*za;  %getting the value of Reliability factor
    else
        Kf =input('Enter the value of Miscellaneous modification factor'); %getting the value of miscellaneous modification factor
    end
end
Sereal = Ka*Kb*Kc*Kd*Ke*Kf*Setest; %real value of Endurance limit obtained using Marin Equation

fprintf('%f',Sereal);

   