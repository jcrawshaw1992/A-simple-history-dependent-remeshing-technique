


function [NewNodes,NewNodes_0,Elements_New, NewEdges,numbNodes, H] = RemeshingAndMapping(InitalNodes,DeformedNodes, Elements_old,Edges_old ,hfun, Plot)


initmsh();

%------ Get the boundaies of the old mesh so I can remesh
BoundaryNodes = [0,0];
for i=1:length(Edges_old)
    
    Node1 = DeformedNodes(Edges_old(i,1),:); Node2 = DeformedNodes(Edges_old(i,2),:);
    if (~IsNumberInVector(BoundaryNodes(:,1), Node1(1)) ||~IsNumberInVector(BoundaryNodes(:,2), Node1(2)) )
        BoundaryNodes = [BoundaryNodes;  Node1];
    end
    if (~IsNumberInVector(BoundaryNodes(:,1), Node2(1)) ||~IsNumberInVector(BoundaryNodes(:,2), Node2(2)) )
        BoundaryNodes = [BoundaryNodes;  Node2];
    end
end

BoundaryNodes = unique(BoundaryNodes, 'rows');
BoundaryEdges = [0,0];
for i=1:length(Edges_old)
    Node1 = DeformedNodes(Edges_old(i,1),:); Node2 = DeformedNodes(Edges_old(i,2),:);
    % These two nodes will also be in the Boundary nodes
    Index1 = find(BoundaryNodes(:,1) == Node1(1) & BoundaryNodes(:,2) == Node1(2) );
    Index2 = find(BoundaryNodes(:,1) == Node2(1) & BoundaryNodes(:,2) == Node2(2) );
    BoundaryEdges = [BoundaryEdges ;  Index1,Index2];
end
BoundaryEdges =  BoundaryEdges(2:end,:);


%-------------------------------------------
Centroids = zeros(length(Elements_old),3);
for j =1:length(Elements_old)
    Nodes = DeformedNodes(Elements_old(j,:),:);
    % Get the centorid for element j at time t
    Centroids(j,:) = [sum(Nodes(:,1))/3, sum(Nodes(:,2))/3,0];
end


% Now remesh the deformed mesh
[NewNodes,~, ...
    Elements_New,~] = refine2(BoundaryNodes,BoundaryEdges,[],[],hfun) ;

numbNodes = length(NewNodes);


if size(NewNodes,2) == 2
    NewNodes(:,3) = zeros(length(NewNodes),1);
    DeformedNodes(:,3)= zeros(length(DeformedNodes),1);
    InitalNodes(:,3) = zeros(length(InitalNodes),1);
end
NewNodes_0 = zeros(length(NewNodes), 3);
for k=1:length(NewNodes)
    Distance =1000;
    ClosestCentorid =-1000;
    for i =1:length(Centroids)
        DistanceBetweenNodeAndElementCentroid = norm(NewNodes(k,:)- Centroids(i,:));
        if DistanceBetweenNodeAndElementCentroid < Distance
            Distance = DistanceBetweenNodeAndElementCentroid;
            ClosestCentorid = i;
        end
    end
    
    Nodes   = DeformedNodes(Elements_old(ClosestCentorid,:),:);
    Nodes_0 = InitalNodes(Elements_old(ClosestCentorid,:),:);
    NewNodes_0(k,:) =NewNodeInInitalConfigurationFromChangeOfBasis(Nodes_0,Nodes,NewNodes(k,:));% NewNodeInInitalConfiguration(Nodes_0,Nodes,P)
end


for j = 1:length(Elements_New)
    NewEdges(k,:) = [Elements_New(j,1), Elements_New(j,2)]; k = k+1;
    NewEdges(k,:) = [Elements_New(j,2), Elements_New(j,3)]; k = k+1;
    NewEdges(k,:) = [Elements_New(j,1), Elements_New(j,3)]; k = k+1;
end
NewEdges = sort(NewEdges, 2);
NewEdges =  unique(NewEdges,'rows'); % Remove any edges that may have repeatedm

%-------------------------------------------
if Plot ==1
    Width = 15;
    Length =15;% hight
    % Plot out the three current meshes
    H= figure();
    subplot(2,2,1)
    patch('faces',Elements_old(:,1:3),'vertices',InitalNodes, ...
        'facecolor','w', ...
        'edgecolor',[.2,.2,.2]) ;
    hold on
    scatter(InitalNodes(:,1), InitalNodes(:,2),30,'k', 'filled'); % Plot the cells 1
    H.Children(1).FontSize =10;
    axis equal
    xlim([0,Width ]);
    ylim([0,Length]);
    H.Children(1).Box = 'off'
    H.Children(1).LineWidth =1.5;
    title("Orignal Mesh in the intial configuration",'Interpreter','latex');
    xlabel("x",'Interpreter','latex');
    ylabel("y", 'Interpreter','latex');
    H.Children(1).XTick = [0,5,10, 15,20];
    H.Children(1).YTick = [0,5,10, 15,20];
    H.Children(1).FontSize =10;
    
    
    subplot(2,2,2)
    patch('faces',Elements_old(:,1:3),'vertices',DeformedNodes, ...
        'facecolor','w', ...
        'edgecolor',[0,0,1]) ;
    hold on
    scatter(DeformedNodes(:,1), DeformedNodes(:,2),30,'b', 'filled'); % Plot the cells 1
    axis equal
    xlim([0,Width ]);
    ylim([0,Length]);
    H.Children(1).Box = 'off'
    H.Children(1).LineWidth =1.5;
    title("Deformed orignal mesh",'Interpreter','latex');
    xlabel("x",'Interpreter','latex');
    ylabel("y", 'Interpreter','latex');
    H.Children(1).XTick = [0,5,10, 15,20];
    H.Children(1).YTick = [0,5,10, 15,20];
    H.Children(1).FontSize =10;
    
    
    subplot(2,2,4)
    patch('faces',Elements_New(:,1:3),'vertices',NewNodes, ...
        'facecolor','w', ...
        'edgecolor',[.8,.2,.2]) ;
    hold on
    scatter(NewNodes(:,1), NewNodes(:,2),30,'r', 'filled'); % Plot the cells 1
    H.Children(1).FontSize =10;
    axis equal
    xlim([0,Width ]);
    ylim([0,Length]);
    H.Children(1).Box = 'off'
    H.Children(1).LineWidth =1.5;
    title("Adapted stretched Mesh",'Interpreter','latex');
    xlabel("x",'Interpreter','latex');
    ylabel("y", 'Interpreter','latex');
    H.Children(1).XTick = [0,5,10, 15,20];
    H.Children(1).YTick = [0,5,10, 15,20];
    H.Children(1).FontSize =10;
    
    subplot(2,2,3)
    patch('faces',Elements_New(:,1:3),'vertices',NewNodes_0, ...
        'facecolor','w', ...
        'edgecolor',[.4,0,.4]) ;
    hold on
    scatter(NewNodes_0(:,1), NewNodes_0(:,2),30,[.4,0,.4], 'filled'); % Plot the cells 1
    H.Children(1).FontSize =10;
    axis equal
    xlim([0,Width ]);
    ylim([0,Length]);
    H.Children(1).Box = 'off'
    H.Children(1).LineWidth =1.5;
    title("Adapted Mesh mapped to inital configuration",'Interpreter','latex');
    xlabel("x",'Interpreter','latex');
    ylabel("y", 'Interpreter','latex');
    H.Children(1).XTick = [0,5,10, 15,20];
    H.Children(1).YTick = [0,5,10, 15,20];
    
    
    
    keyboard
    H = figure()
    errorbar(NodeCount,MeanError,stdError,'o')
    H.Children.Children.MarkerFaceColor = 'b'
    H.Children.Children.MarkerSize =13;
    H.Children.Children.LineWidth =1.5;
    H.Children.Children.MarkerEdgeColor = 'k' ;
    H.Children.Children.Color = [ 0 , 0.2, 1];
    xlim([0,1200])
    
end

end



