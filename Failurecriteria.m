%% code for Failure criteria in case of Variable Loading(Fatigue failure)
%% This Program is for getting the Factor of Safety of Material from given value of Loading (with constant Amplitude), Modified endurance strength, and Ultimate tensile strength or Yeild strength
%% Section 1: Getting all the Inputs
Se =input('Input the Modified Endurance Strength'); %Value of Modified Endurance strength can be decided from the last code homework
Sut =input('Input the value of Ultimate tensile strength for the Material from data sheet'); %Value of ultimate tensile stregth
Sy =input('Input the value of Yeild strength'); %Value of yeild strength to check localized yeilding and failure criteria
x =input('Enter the type of Loading: 1-Simple loading  2-Combined loading'); %Here we will get the type of loading and accordingly apply the formula for failure criteria
%% Section 2: Distributing according the type of Loading
%% Type of Loading to be Simple
if x==1
    y =input('Enter the loading type 1:Tensile and compressive  2:Shear');
    if y==1
        sigmamax =input('Enter the value of maximum tensile stress');
        sigmamin =input('Enter the minimum value of tensile stress');
        sigmaM =(sigmamax+sigmamin)/2;
        sigmaA =abs((sigmamax-sigmamin)/2);
        if sigmaM >=0
            %% Using Langer criteria
            nlanger =Sy/(sigmaM+sigmaA); %Design factor of safety
            %% Using Modified Goodman criteria
            nModifiedGoodman =1/((sigmaA/Se)+(sigmaM/Sut)); %Design factor of safety
            %% Using Gerber failure criteria
            ngerber =1/((sigmaA/Se)+(power((sigmaM/Sy),2))); %Design Factor of safety
            %% Using ASME Elliptical Failure criteria
            nASME =1/sqrt(power((sigmaA/Se),2)+power((sigmaM/Sut),2)); %Design factor of Safety
        else
            ndesign =Se/sigmaA; %Design Factor of Safety
        end
    elseif y==2
        Taumax =input('Enter the value of maximum shear stress');
        Taumin =input('Enter the minimum value of shear stress');
        TauM =(Taumax+Taumin)/2;
        TauA =abs((Taumax-Taumin)/2);
        if TauM >=0
            %% Using Langer criteria
            nlanger =(0.577*Sy)/(TauM+TauA); %Design factor of safety
            %% Using Modified Goodman criteria
            nModifiedGoodman =1/((Tau/Se)+(TauM/Sut)); %Design factor of safety
            %% Using Gerber failure criteria
            ngerber =1/((TauA/Se)+(power((TauM/Sy),2))); %Design Factor of safety
            %% Using ASME Elliptical Failure criteria
            nASME =1/sqrt(power((TauA/Se),2)+power((TauM/Sut),2)); %Design factor of Safety
        else
            ndesign =Se/TauA; %Design Factor of Safety
        end
    end
%% Assuming type of Loading to be Combined
else
   Asigmamax =input('Enter the value of maximum Axial stress');
   Asigmamin =input('Enter the value of minimum Axial stress');
   Bsigmamax =input('Enter the value of maximum bending stress');
   Bsigmamin =input('Enter the value of minimum Bending stress')'
   Taumax =input('Enter the value of maximum shear stress');
   Taumin =input('Enter the value of minimum shear stress');
   AKf =input('Enter the stress intensity factor for Axial Loading');
   BKf =input('Enter the stress intensity factor for Bending');
   Kfs =input('Enter the stress intensity factor for shear loading');
   AsigmaA =(Asigmamax+Asigmamin)/2;
   AsigmaM =abs((Asigmamax-Asigmamin)/2);
   TauA =(Taumax+Taumin)/2;
   Taum =abs((Taumax-Taumin)/2);
   BsigmaA =(Bsigmamax+Bsigmamin)/2;
   BsigmaM =abs((Bsigmamax-Bsigmamin)/2);
   sigmaA =sqrt(power(BKf*BsigmaA+AKf*AsigmaA*(1/0.85),2)+3*(power(Kfs*TauA,2)));
   sigmaM =sqrt(power(BKf*BsigmaM+AKf*AsigmaM,2)+3*(power(Kfs*TauM,2)));
   %% Checking for Failure
   if sigmaM>=0
      %% Using Langer criteria
            nlanger =(0.577*Sy)/(sigmaM+sigmaA); %Design factor of safety
            %% Using Modified Goodman criteria
            nModifiedGoodman =1/((sigmaA/Se)+(sigmaM/Sut)); %Design factor of safety
            %% Using Gerber failure criteria
            ngerber =1/((sigmaA/Se)+(power((sigmaM/Sy),2))); %Design Factor of safety
            %% Using ASME Elliptical Failure criteria
            nASME =1/sqrt(power((sigmaA/Se),2)+power((sigmaM/Sut),2)); %Design factor of Safety
   else
       ndesign =Se/sigmaA; %Design Factor of Safety
   end
end

            
         
        
            