


function [NewNodes_0] = MappingAdaptedMeshToInitialGeometry(InitalNodes,DeformedNodes, Elements_old,NewNodes,Edges,Elements)

OldEdges = [];
for i=1:length(Elements_old)
    
    OldEdges = [OldEdges; sort(Elements_old(i,1:2)); sort(Elements_old(i,2:3)); sort([ Elements_old(i,3),Elements_old(i,1)])];
end
OldEdges = unique(OldEdges,'rows');
Edges = OldEdges;

TroublsomeNodeSet = [];
%-- Get the centorid for element j at time t

Centroids = zeros(length(Elements_old),3);
for j =1:length(Elements_old)
    Nodes = DeformedNodes(Elements_old(j,:),:);
    Centroids(j,:) = mean(Nodes);
end

NewNodes_0 = zeros(length(NewNodes), 3);
for k=1:length(NewNodes)
    ClosestCentorid =-20;
    
    for i =1:length(Elements_old)
        
        if  1 == PointInTriangle(NewNodes(k,:),DeformedNodes(Elements_old(i,1),:), DeformedNodes(Elements_old(i,2),:), DeformedNodes(Elements_old(i,3),:))
            ClosestCentorid = i;
            break
        end
        
    end
%     scatter(NewNodes(:,1),NewNodes(:,2),'b')
%     xlim([ 0 6.7])
%     ylim([ 0 6.7])
    
    % If it closestCentroid is still -20, then this node is lying
    % on an edge -- probably the boundary ... might even have the
    % same position as an old node
    
    if ClosestCentorid > 0
             
        Nodes   = DeformedNodes(Elements_old(ClosestCentorid,:),:);
        Nodes_0 = InitalNodes(Elements_old(ClosestCentorid,:),:);
        
        NewNodes_0(k,:) = NewNodeInInitalConfigurationFromChangeOfBasis(Nodes_0,Nodes,NewNodes(k,:));% NewNodeInInitalConfiguration(Nodes_0,Nodes,P)

    else
        Distance =1; EdgeIndex =-20; ClosestEdge = [-20, -20];
        for e=1:length(Edges)
           
            if e >length(Edges)
                keyboard
            end
            x1 = DeformedNodes(Edges(e,1),:); x2 = DeformedNodes(Edges(e,2),:);  x0 = NewNodes(k,:);
            
            P = x1 - (x2-x1)* ( dot((x1-x0),(x2-x1))/dot( (x2-x1),(x2-x1)) );
            Dist2Edge = norm(P-x0);
            
            if (Dist2Edge <= Distance)
                 if( round(x1(1),2) <= round(P(1),2)  && round(P(1),2) <= round(x2(1),2) && round(x1(2),2) <= round(P(2),2)  && round(P(2),2) <= round(x2(2),2) || ...
                        round(x1(1),2) <= round(P(1),2)  && round(P(1),2) <= round(x2(1),2)  && round(x1(2),2) >= round(P(2),2)  && round(P(2),2) >= round(x2(2),2) || ... 
                        round(x1(1),2) >= round(P(1),2)  && round(P(1),2) >= round(x2(1),2) && round(x1(2),2) <= round(P(2),2)  && round(P(2),2) <= round(x2(2),2) || ...
                        round(x1(1),2) >= round(P(1),2)  && round(P(1),2) >= round(x2(1),2)  && round(x1(2),2) >= round(P(2),2)  && round(P(2),2) >= round(x2(2),2))
            
                    Distance = Dist2Edge;
                    ClosestEdge = Edges(e,:);
                    EdgeIndex =e;

                 end
            end
        end
        if EdgeIndex <0
            
             scatter(DeformedNodes(:,1),DeformedNodes(:,2),'b')
                patch('faces',Elements_old,'vertices',DeformedNodes, ...
                'edgecolor','k','FaceColor','none');
                drawnow;
               
                hold on 
                scatter( NewNodes(k,1), NewNodes(k,2),'r')
                keyboard 
        end   
        
        P1 = DeformedNodes(Edges(EdgeIndex,1),:); P2 = DeformedNodes(Edges(EdgeIndex,2),:); 
        if norm(NewNodes(k,:) - P1) < 0.001 % here we are assuming that this old node and new node are at the same possition
            
            NewNodes_0(k,:) =InitalNodes(ClosestEdge(1),:);
        elseif  norm(NewNodes(k,:) - P2) < 0.001 % here we are assuming that this old node and new node are at the same possition
            
            NewNodes_0(k,:) =InitalNodes(ClosestEdge(2),:);
        else
 
            [a, ~] = find(Elements_old == ClosestEdge(1));
            [c, ~] = find(Elements_old(a,:) == ClosestEdge(2));
             
             ElementAssociatedToElements = a(c) ;  
             if length(ElementAssociatedToElements) < 2 && length(ElementAssociatedToElements) > 0
                ClosestCentorid = ElementAssociatedToElements;            
                Nodes   = DeformedNodes(Elements_old(ClosestCentorid,:),:);
                Nodes_0 = InitalNodes(Elements_old(ClosestCentorid,:),:);
                NewNodes_0(k,:) = NewNodeInInitalConfigurationFromChangeOfBasis(Nodes_0,Nodes,NewNodes(k,:));% NewNodeInInitalConfiguration(Nodes_0,Nodes,P) 
             elseif length(ElementAssociatedToElements) == 2
                 
                 for m = 1:length(a)
                        A = a(m);
                        if 1== PointOnTriangleEdge(NewNodes(k,:),DeformedNodes(Elements_old(A,1),:), DeformedNodes(Elements_old(A,2),:), DeformedNodes(Elements_old(A,3),:))
                            ClosestCentorid =  A; 
                             Nodes   = DeformedNodes(Elements_old(ClosestCentorid,:),:);
                            Nodes_0 = InitalNodes(Elements_old(ClosestCentorid,:),:);
                            NewNodes_0(k,:) = NewNodeInInitalConfigurationFromChangeOfBasis(Nodes_0,Nodes,NewNodes(k,:));% NewNodeInInitalConfiguration(Nodes_0,Nodes,P) 
                        end
                
                 end
                 
                 
             else 
                 TroublsomeNodeSet = [TroublsomeNodeSet,k];
                 
                % look at both 
                % Answer = PointOnTriangleEdge(p, a,b,c)
                scatter(DeformedNodes(:,1),DeformedNodes(:,2),'b')
                patch('faces',Elements_old,'vertices',DeformedNodes, ...
                'edgecolor','k','FaceColor','none');
                drawnow;
               
                hold on 
                scatter( NewNodes(k,1), NewNodes(k,2),'r')
                keyboard
                
                P1 = DeformedNodes(Edges(EdgeIndex,1),:); P2 = DeformedNodes(Edges(EdgeIndex,2),:); 
        

        
                plot([P1(1),P2(1)],[P1(2),P2(2)] ,'b',"LineWidth" ,2)
                
                
                 [a, ~] = find(Elements_old == ClosestEdge(1) | Elements_old == ClosestEdge(2));
                 
                    for m = 1:length(a)
                        A = a(m);
                        if 1 == PointOnTriangleEdge(NewNodes(k,:),DeformedNodes(Elements_old(A,1),:), DeformedNodes(Elements_old(A,2),:), DeformedNodes(Elements_old(A,3),:))
                           disp("found Element")
                            keyboard
                        end
%                         P1 = DeformedNodes(Elements_old(A,1),:); 
%                        P2 = DeformedNodes(Elements_old(A,2),:);
%                        P3 = DeformedNodes(Elements_old(A,3),:);
%                        Nodeseee = [P1;P2;P3]
%                        scatter( Nodeseee(:,1), Nodeseee(:,2), 'r')
% 
%                        plot([P1(1),P2(1)],[P1(2),P2(2)] ,'r',"LineWidth" ,5)
%                        plot([P2(1),P3(1)],[P2(2),P3(2)] ,'r',"LineWidth" ,5)
%                        plot([P1(1),P3(1)],[P1(2),P3(2)] ,'r',"LineWidth" ,5)
%                      
                        
                      
                    end
            
            
                
                keyboard 
                
                
             end

        end

    end 
   

end

%     keyboard
%     figure()
%     patch('faces',Elements_old,'vertices',DeformedNodes, ...
%                 'edgecolor','k','FaceColor','none');
%                 drawnow;
%                 
%                 hold on
%     patch('faces',Elements,'vertices',NewNodes, ...
%         'edgecolor','r','FaceColor','none');
%         drawnow;
% 
%         figure()
%     patch('faces',Elements_old,'vertices',InitalNodes, ...
%                 'edgecolor','k','FaceColor','none');
%                 drawnow;
%                 
%                 hold on
%     patch('faces',Elements,'vertices',NewNodes_0, ...
%         'edgecolor','r','FaceColor','none');
%         drawnow;
                
                %    xlim([0 3.1]);
%     ylim([0 3.1]);
%     patch('faces',Elements,'vertices',NewNodes_0, ...
%     'edgecolor','k','FaceColor','w');
%     drawnow;
%     
%     
    
% 
% hold on
% scatter(NewNodes(TroublsomeNodeSet,1),NewNodes(TroublsomeNodeSet,2),'r')
% keyboard
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
if (SameSide(p,a, b,c) && SameSide(p,b, a,c)&& SameSide(p,c, a,b))
    Answer = 1;
else
    Answer = 0;
end
end


function Answer = PointOnTriangleEdge(p, a,b,c)
if (SameSide(p,a, b,c) + SameSide(p,b, a,c) +  SameSide(p,c, a,b)>=2)
    Answer = 1;
else
    Answer = 0;
end
end




