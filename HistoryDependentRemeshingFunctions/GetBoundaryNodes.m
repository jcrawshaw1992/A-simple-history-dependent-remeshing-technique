function [BoundaryNodes,BoundaryEdges] = GetBoundaryNodes(DeformedNodes,Edges_old)

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

end
