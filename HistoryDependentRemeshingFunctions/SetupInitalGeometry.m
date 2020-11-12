


function [InitalNodes, Edges_old,Elements_old,tnum] = SetupInitalGeometry(Width,Height, hfun)

 %------------------------------------------- setup geometry

    node = [                % list of xy "node" coordinates
        0, 0                % outer square
        Width, 0
        Width, Height
        0, Height ] ;

    edge = [                % list of "edges" between nodes
         1, 2                % outer square 
         2, 3
         3, 4
         4, 1 ] ;
     initmsh();
         
%------------------------------------------- call mesh-gen.

[InitalNodes,Edges_old, ...
    Elements_old,tnum] = refine2(node,edge,[],[],hfun) ; % Is 0.5 when constant


end