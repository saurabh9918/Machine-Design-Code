Se =input('Enter the value of Endurance limit');
Sut =input('Enter the value of Ultimate tensile strength');
Sy =input('Enter the value of yield strength');
x =linspace(0,600,50);
%% Langer line
y1 =Sy-x;
plot(x,y1);
title('Combined Plot of failure critieria');

hold on
%% Modified Goodman Line
y2 =Se-((Se/Sut)*x);
plot(x,y2);

%% Gerber Line
y3 =Se-Se*(power((x/Sy),2));
plot(x,y3);

%% ASME Elliptical
y4 =Se*(sqrt(1-(power((x/Sut),2))));
plot(x,y4);

hold off

