
  function [V1,V2,V3] =  GetDispalcementVectors( ClosestOldNodes, InitalOldNodes, OldNodes)
% 
         Vector0 = OldNodes(ClosestOldNodes(1),:)
         Vector1 = OldNodes(ClosestOldNodes(2),:)
         Vector2 = OldNodes(ClosestOldNodes(3),:)
         
         Vector0i = InitalOldNodes(ClosestOldNodes(1),:)
         Vector1i = InitalOldNodes(ClosestOldNodes(2),:)
         Vector2i = InitalOldNodes(ClosestOldNodes(3),:)
         
         V1 = Vector0 -Vector0i;
         V2 = Vector1 -Vector1i;
         V3 = Vector2 -Vector2i;   


% SetNodes
         Vector0 = OldNodes(ClosestOldNodes(1),:);
         Vector1 = OldNodes(ClosestOldNodes(2),:);
         Vector2 = OldNodes(ClosestOldNodes(3),:);
         
         
        % PRINT_VECTOR(Vector0 );
        
     

         vector_12 = Vector1 - Vector0; % Vector 1 to 2
         vector_13 = Vector2 - Vector0; % Vector 1 to 33);
       

        % Get side lengths and angle to create an equal triangle at the origin
         a = norm(vector_12); % Lenght a -> edge connecting P0 and P1
         b = norm(vector_13); % Lenght b -> edge connecting P0 and P2
         alpha = acos(dot(vector_12, vector_13) / (a * b));

        % This will create an equal triangle at the origin
         x1 = [0, 0, 0];
         x2 = [a, 0, 0];
         x3 = [b * cos(alpha), b * sin(alpha), 0];

        % Get the original triangle        
         Vector0 = InitalOldNodes(ClosestOldNodes(1),:);
         Vector1 = InitalOldNodes(ClosestOldNodes(2),:);
         Vector2 = InitalOldNodes(ClosestOldNodes(3),:);
        % PRINT_VECTOR(Vector0 );

         vector_12 = Vector1 - Vector0; % Vector 1 to 2
         vector_13 = Vector2 - Vector0; % Vector 1 to 33);
       

        % Get side lengths and angle to create an equal triangle at the origin
         a = norm(vector_12); % Lenght a -> edge connecting P0 and P1
         b = norm(vector_13); % Lenght b -> edge connecting P0 and P2
         alpha = acos(dot(vector_12, vector_13) / (a * b));

        % This will create an equal triangle at the origin
         x10 = [0, 0, 0];
         x20 = [a, 0, 0];
         x30 = [b * cos(alpha), b * sin(alpha), 0];
         
         
%          there is a problem somewhere in here :P
% % % %         Displacement vectors.
         V1 = x1 - x10;
         V2 = x2 - x20;
         V3 = x3 - x30;
      
    end   
%   