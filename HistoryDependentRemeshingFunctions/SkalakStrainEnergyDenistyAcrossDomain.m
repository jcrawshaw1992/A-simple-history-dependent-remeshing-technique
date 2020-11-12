
function [SkalakEnergy] = SkalakStrainEnergyDenistyAcrossDomain(Elements, Nodes_0, Nodes )

for j =1:length(Elements)

        Element_j =Elements(j,:);

        x0_i = Nodes_0(Element_j(1),:);
        x1_i = Nodes_0(Element_j(2),:);
        x2_i = Nodes_0(Element_j(3),:);

        X0 =  Nodes(Element_j(1),:);
        X1 =  Nodes(Element_j(2),:);
        X2 =  Nodes(Element_j(3),:);
        SkalakEnergy(j) = SkalakStrainEnergy(x0_i,x1_i,x2_i,X0, X1, X2 );
end
end
