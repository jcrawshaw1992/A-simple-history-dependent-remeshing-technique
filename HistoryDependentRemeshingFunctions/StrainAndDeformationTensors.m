
% Membrane Shear force Skalak et al
function [ Strain, Deformation, Invarients ]= StrainAndDeformationTensors(x0,x1,x2,Xt0, Xt1, Xt2  )

x1=x1-x0;
x2=x2-x0;
x0=x0-x0;
% PlotTriangle(x0,x1,x2)

Xt1 = Xt1 - Xt0;
Xt2 = Xt2 - Xt0;
Xt0 = Xt0 - Xt0;
% PlotTriangle(Xt0,Xt1,Xt2)


% do this without the complicated rotations 

%Find the rotated nodes at time t 
At = norm(Xt1);
Bt = norm(Xt2);
Alphat = acos(dot(Xt1, Xt2) / (At * Bt));

normalVectort = cross(Xt1, Xt2);

RP1 =  [0, 0];
RP2 =  [At, 0];
RP3 =  [Bt* cos(Alphat), Bt*sin(Alphat)];
            

A = norm(x1);
B = norm(x2);
Alpha = acos(dot(x1, x2) / (A * B));
normalVector = cross(x1, x2);
Area = 0.5 * norm(normalVector);

%Inital Positions rotated
Rx1 =  [0, 0];
Rx2 =  [A, 0];
Rx3 =  [B* cos(Alpha), B*sin(Alpha)];


 a = [(Rx2(2) - Rx3(2)) /(2*Area), (Rx3(2) - Rx1(2))/(2*Area) ,(Rx1(2) - Rx2(2))/(2*Area)];
 b = [(Rx3(1) - Rx2(1)) /(2*Area), (Rx1(1) - Rx3(1)) /(2*Area) ,(Rx2(1) - Rx1(1)) /(2*Area)];
% RP3 = RP3(1:2);
 
 V1 = RP1 - Rx1 ;
 V2 = RP2 - Rx2 ;
 V3 = RP3 - Rx3 ;
 
Dxx = 1 + a(1) * V1(1) + a(2) * V2(1) + a(3) * V3(1);
Dxy = b(1) * V1(1) + b(2) * V2(1) + b(3) * V3(1);
Dyx = a(1) * V1(2) + a(2) * V2(2) + a(3) * V3(2);
Dyy = 1+b(1)*V1(2)+b(2)*V2(2)+b(3)*V3(2) ;
D = [Dxx,Dxy; Dyx,Dyy];

 G=D'*D;

I1 = trace(G) -2;
I2 = det(G) -1;

Strain = G;
Deformation =D;

Invarients = [I1;I2];

end




function PlotTriangle(x0,x1,x2)
plot3([x0(1),x1(1)],[x0(2),x1(2)], [x0(3),x1(3)], 'r')
hold on
plot3([x1(1),x2(1)],[x1(2),x2(2)],[x1(3),x2(3)], 'r')
plot3([x2(1),x0(1)],[x2(2),x0(2)],[x2(3),x0(3)], 'r')
axis equal

end