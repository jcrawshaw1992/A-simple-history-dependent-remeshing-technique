function DeformedNodes = Deformation(InitalNodes)

DeformedNodes = InitalNodes;
DeformedNodes(:,1) = 0.85*(InitalNodes(:,1) .*(InitalNodes(:,1)+0.5));
DeformedNodes(:,2) = 0.85*(InitalNodes(:,2) .*(InitalNodes(:,2)+0.5));%(InitalNodes(:,2) +InitalNodes(:,2)); %1.5*InitalNodes(:,2) +InitalNodes(:,1).*InitalNodes(:,1)/20;%;sqrt(InitalNodes(:,1)+1)+InitalNodes(:,1)/5);%.*(InitalNodes(:,1)+20)/20 +InitalNodes(:,1) ;



% 
% DeformedNodes = InitalNodes;
% DeformedNodes(:,1) = (InitalNodes(:,1) .*(InitalNodes(:,1)+0.5));
% DeformedNodes(:,2) = (InitalNodes(:,2) .*(InitalNodes(:,2)+0.5));%(InitalNodes(:,2) +InitalNodes(:,2)); %1.5*InitalNodes(:,2) +InitalNodes(:,1).*InitalNodes(:,1)/20;%;sqrt(InitalNodes(:,1)+1)+InitalNodes(:,1)/5);%.*(InitalNodes(:,1)+20)/20 +InitalNodes(:,1) ;



% % 
%  DeformedNodes(:,1) = 1.7*(InitalNodes(:,1) +InitalNodes(:,2).*InitalNodes(:,2)/10);
%  DeformedNodes(:,2) = 2*InitalNodes(:,2) +InitalNodes(:,1)/5;%;sqrt(InitalNodes(:,1)+1)+InitalNodes(:,1)/5);%.*(InitalNodes(:,1)+20)/20 +InitalNodes(:,1) ;
% 
% DeformedNodes(:,1) = 1.7*(InitalNodes(:,1) +InitalNodes(:,2).*InitalNodes(:,2)/10);
%  DeformedNodes(:,2) = 2*InitalNodes(:,2) +InitalNodes(:,1)/5;%;sqrt(InitalNodes(:,1)+1)+InitalNodes(:,1)/5);%.*(InitalNodes(:,1)+20)/20 +InitalNodes(:,1) ;
% 

end

%  DeformedNodes(:,1) = 1.7*(InitalNodes(:,1) +InitalNodes(:,2).*InitalNodes(:,2)/10);
%  DeformedNodes(:,2) = 2*InitalNodes(:,2) +InitalNodes(:,1)/5;%;sqrt(InitalNodes(:,1)+1)+InitalNodes(:,1)/5);%.*(InitalNodes(:,1)+20)/20 +InitalNodes(:,1) ;
% 
% DeformedNodes(:,1) = InitalNodes(:,1) *4;
%  DeformedNodes(:,1) = (InitalNodes(:,1) .*(InitalNodes(:,1)+1))/3;

% DeformedNodes(:,1) = DeformedNodes(:,1)*2;
% DeformedNodes(:,2) = DeformedNodes(:,2)*2;


% 
% Try next
% DeformedNodes(:,1) = 1*(InitalNodes(:,1) +InitalNodes(:,2).*InitalNodes(:,2)/10);
% DeformedNodes(:,2) = 1.2*InitalNodes(:,2) +InitalNodes(:,1).*InitalNodes(:,1)/10;%;sqrt(InitalNodes(:,1)+1)+InitalNodes(:,1)/5);%.*(InitalNodes(:,1)+20)/20 +InitalNodes(:,1) ;
