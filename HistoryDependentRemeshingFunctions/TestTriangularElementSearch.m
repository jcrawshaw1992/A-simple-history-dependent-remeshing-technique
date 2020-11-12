


function main

close all; clc
p = [0,0,0];
Center = [2.0000    4/3    2.5/3];

% send directoryly out from center normaly;

elements = [1,1,0;2,0,2;3,3,0.5];
Normal = cross(elements(2,:) - elements(3,:), elements(1,:)-elements(3,:));
Elements = [1,2,3]

scatter3(elements(:,1),elements(:,2),elements(:,3), 200,'filled')
hold on 
 patch('faces',Elements,'vertices',elements,...
        'edgecolor','k', 'faceColor', [1 0 0.5] ) ;
    scatter3(Center(:,1),Center(:,2),Center(:,3), 200,'filled')
    
%     Move the center a little 
Normal = Normal /norm(Normal);
k = 0;
kk=0;
counter = 0;
for j=-0.5:0.1:0.5
    p = Center + j*(Center - elements(1,:));
    scatter3(p(:,1),p(:,2),p(:,3), 200,'filled')
    hold off
    pause()

   figure() 
    scatter3(p(:,1),p(:,2),p(:,3), 200,'filled')
    scatter3(elements(:,1),elements(:,2),elements(:,3), 200,'filled')
    hold on 
     patch('faces',Elements,'vertices',elements,...
            'edgecolor','k', 'faceColor', [1 0 0.5] ) ;
        
        
    for i =-2:0.5:2
        p = p + i*Normal;
        
%         scatter3(p(:,1),p(:,2),p(:,3), 200,'filled')
%         drawnow
%         pause(0.01)

        % is this point in the element? 
        Answer = PointInTriangle(p, elements(1,:),elements(2,:),elements(3,:))  
        Answer2 = PointInTriangle3D(p, elements(1,:),elements(2,:),elements(3,:))  
        if Answer ==1
            k = k+1;
        end
        if Answer2 ==1
            kk=kk+1
        end
%         if Answer~=Answer2
%             keyboard
%         end
        counter = counter +1
    end
end
k
kk
frac = k/counter

frac2 = kk/counter

%-------------------------------------------

end



function Answer =  SameSide(p1,p2, a,b)
cp1 = cross(b-a, p1-a);
cp2 = cross(b-a, p2-a);
if dot(cp1, cp2) >= 0
    Answer =1;
else
    Answer =0;
end
end



function Answer = PointInTriangle(p, a,b,c)
if SameSide(p,a, b,c) & SameSide(p,b, a,c)& SameSide(p,c, a,b) ;
    Answer = 1;
else
    Answer = 0;
end
end


function Answer = PointInTriangle3D(p, a,b,c)
if SameSideOfPlane(p,a, b,c) & SameSideOfPlane(p,b, a,c)& SameSideOfPlane(p,c, a,b) ;
    Answer = 1;
else
    Answer = 0;
end
end

function Answer =  SameSideOfPlane(p1,p2, a,b)

% Need to create plane from one of the lines and the opposite point -- here
% order of points is very important... dam 

Line = a- b;
Midpoint = (a+b)/2;
NormalToPlane = (Midpoint - p2)/norm((Midpoint - p2));
% now determine if this is above or below plane

sign = dot(NormalToPlane, (p1 - Midpoint));
% if sign is neg, point is below plane, i.e on the triangle side of the
% plane, is sign is pos, the point is away from the triangle 

if sign <= 0
    Answer =1;
else
    Answer =0;
end
end








