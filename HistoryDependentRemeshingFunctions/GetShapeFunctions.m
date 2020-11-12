    
function  [A,B,C] =  GetShapeFunctions( ClosestOldNodes, InitalOldNodes)
       
       Node1 = ClosestOldNodes(1);
       Node2 = ClosestOldNodes(2);
       Node3 = ClosestOldNodes(3);
%      
       vector_1 = InitalOldNodes(Node1,:);
       vector_2 = InitalOldNodes(Node2,:);
       vector_3 = InitalOldNodes(Node3,:);
       
       X1 = vector_1(1) ;X2 = vector_2(1); X3 = vector_3(1);
       Y1 = vector_1(2) ;Y2 = vector_2(2); Y3 = vector_3(2);
    
       
        syms a b c
        eqns = [a*vector_1(1)+b*vector_1(2)+c== 1, a*vector_2(1)+b*vector_2(2)+c== 0, a*vector_3(1)+b*vector_3(2)+c== 0];
        vars = [a,b, c];
        [AA(1),BB(1),CC(1)] = solve(eqns,vars);
        clear a,b,c;
        syms a b c;
        eqns = [a*vector_1(1)+b*vector_1(2)+c== 0, a*vector_2(1)+b*vector_2(2)+c== 1, a*vector_3(1)+b*vector_3(2)+c== 0];
        vars = [a,b, c];
        [AA(2),BB(2),CC(2)] = solve(eqns,vars);
        clear a,b,c;
        syms a b c;
        eqns = [a*vector_1(1)+b*vector_1(2)+c== 0, a*vector_2(1)+b*vector_2(2)+c== 0, a*vector_3(1)+b*vector_3(2)+c== 1];
        vars = [a,b, c];
        [AA(3),BB(3),CC(3)] = solve(eqns,vars);
       clear a,b,c;
       
%        for i=1:3
%          A(i) = double(AA(i));
%          B(i) = double(BB(i));
%          C(i) = double(CC(i));
%        end
% %        
% % %   
       vector_12 = InitalOldNodes(Node2,:) - InitalOldNodes(Node1,:);%  PositionVector(2) - PositionVector(1); % Vector 1 to 2
       vector_13 = InitalOldNodes(Node3,:) - InitalOldNodes(Node1,:);% PositionVector(3) - PositionVector(1); % Vector 1 to 3
       A = norm(vector_12); %% Lenght a -> edge connecting P1 and P2
       B = norm(vector_13); %% Lenght b -> edge connecting P1 and P3
       
       normalVector = cross(vector_12, vector_13);
       Area = 0.5 * norm(normalVector);
       
%        Send back to an origin
       alpha = acos(dot(vector_12, vector_13) / (A * B));

       x1 = [0,0];
       x2 = [A,0];
       x3 = [B * cos(alpha),B* sin(alpha)];
%         
        A(1) = (x2(2) - x3(2)) / (2 * Area)
        A(2) = (x3(2) - x1(2)) / (2 * Area);
        A(3) = (x1(2) - x2(2)) / (2 * Area);

        B(1) = (x3(1) - x2(1)) / (2 * Area)
        B(2) = (x1(1) - x3(1)) / (2 * Area);
        B(3) = (x2(1) - x1(1)) / (2 * Area);
%         
        C(1) = 1 - A(1)*x1(1) - B(1)* x1(2);
        C(2) = 1 - A(2)*x2(1) - B(2)* x2(2);
        C(3) = 1 - B(3)* x3(2);

        
end
