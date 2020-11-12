    
function  [A,B,C] = ShapeFunctions(InitalNodes)
       
    
       vector_1 = InitalNodes(1,:);
       vector_2 = InitalNodes(2,:);
       vector_3 = InitalNodes(3,:);
       
    
       vector_12 = vector_2 - vector_1;%  PositionVector(2) - PositionVector(1); % Vector 1 to 2
       vector_13 = vector_3 - vector_1;%   PositionVector(3) - PositionVector(1); % Vector 1 to 3
       a = norm(vector_12); %% Lenght a -> edge connecting P1 and P2
       b = norm(vector_13); %% Lenght b -> edge connecting P1 and P3
       
       normalVector = cross(vector_12, vector_13);
       Area = 0.5 * norm(normalVector);
       
%        Send back to an origin
       alpha = acos(dot(vector_12, vector_13) / (a*b));

       x1 = [0,0];
       x2 = [a,0];
       x3 = [b * cos(alpha),b* sin(alpha)];
%         
        A(1) = (x2(2) - x3(2)) / (2 * Area);
        A(2) = (x3(2) - x1(2)) / (2 * Area);
        A(3) = (x1(2) - x2(2)) / (2 * Area);

        B(1) = (x3(1) - x2(1)) / (2 * Area);
        B(2) = (x1(1) - x3(1)) / (2 * Area);
        B(3) = (x2(1) - x1(1)) / (2 * Area);
%         
        C(1) = 1 - A(1)*x1(1) - B(1)* x1(2);
        C(2) = 1 - A(2)*x2(1) - B(2)* x2(2);
        C(3) = 1 - B(3)* x3(2);

        
end
