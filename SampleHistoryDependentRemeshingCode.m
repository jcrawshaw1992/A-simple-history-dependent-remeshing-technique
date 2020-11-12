function main

clc; clear all; close all;
Directory = "/Users/jcrawshaw/Documents/Projects/Writing/JobApplications/FrancisCrick_014707/CodeSnippets/HistoryDependentRemeshing/MatlabCode/";
addpath(Directory+'HistoryDependentRemeshingFunctions'); addpath(Directory+'MESH2D_MatlabCodeToGenerateMeshes');

Refinment = 1;
RemeshedRefinment= 1;
MatFileName = "SampleOutput"; 

% Initial mesh 
initmsh();
[InitalNodes, Edges_old,Elements_old,~] = SetupInitalGeometry(3,3, Refinment); % Course inital mesh refinment it 0.5 :) 

%------ Quad deformation in X and Y
DeformedNodes = QuadDef(InitalNodes);

%------ Get the boundaies of the old mesh so I can remesh
[BoundaryNodes,BoundaryEdges] = GetBoundaryNodes(DeformedNodes,Edges_old);

DeformedNodes(:,3)= zeros(length(DeformedNodes),1);
InitalNodes(:,3) = zeros(length(InitalNodes),1);


%------ Now remesh the deformed mesh
[NewNodes,~,Elements_New,~] = refine2(BoundaryNodes,BoundaryEdges,[],[],RemeshedRefinment) ;

%
% Needs to be in 3D because cross products are used everywhere 
NewNodes(:,3) = zeros(length(NewNodes),1);
[NewNodes_0] = MappingAdaptedMeshToInitialGeometry(InitalNodes,DeformedNodes, Elements_old,NewNodes);


PlotMeshes(Elements_old, InitalNodes,DeformedNodes,Elements_New, NewNodes, NewNodes_0 )
keyboard
save(Directory+MatFileName+".mat")
end


function ResultsFigure = PLotMeshes(Elements_old, InitalNodes,DeformedNodes,Elements_New, NewNodes, NewNodes_0 )

linewidth = 1.1;
Width = 9.1;
Length =9.1;% hight
ScatterSize = 30;

H= figure();
subplot(2,2,1)
patch('faces',Elements_old(:,1:3),'vertices',InitalNodes, ...
    'facecolor','w', ...
    'edgecolor',[0,0,0]) ;
H.Children(1).Children(1).LineWidth =1;
hold on
scatter(InitalNodes(:,1), InitalNodes(:,2),ScatterSize,'k', 'filled'); % Plot the cells 1
xlim([0-3,Width-3]);
ylim([0-3,Width-3]);


axis equal


subplot(2,2,2)
patch('faces',Elements_old(:,1:3),'vertices',DeformedNodes, ...
    'facecolor','w', ...
    'edgecolor',[0,0,0]);%[0,0,1]) ;
H.Children(1).Children(1).LineWidth =1;
hold on
scatter(DeformedNodes(:,1), DeformedNodes(:,2),ScatterSize+3,'k', 'filled'); %'b', 'filled'); % Plot the cells 1
axis equal

xlim([0,Width]);
ylim([0,Length]);


H.Children(1).Box = 'off'
H.Children(1).LineWidth =linewidth;

subplot(2,2,4)
patch('faces',Elements_New(:,1:3),'vertices',NewNodes, ...
    'facecolor','w', ...
    'edgecolor',[.2,.2,.2]);%[.8,.2,.2]) ;
H.Children(1).Children(1).LineWidth =1;
H.Children(1).Children(1).LineWidth =1;
hold on
scatter(NewNodes(:,1), NewNodes(:,2),ScatterSize,'k', 'filled');%'r', 'filled'); % Plot the cells 1
axis equal
xlim([0,Width]);
ylim([0,Length]);


subplot(2,2,3)
patch('faces',Elements_New(:,1:3),'vertices',NewNodes_0, ...
    'facecolor','w', ...
    'edgecolor',[0,0,0]) ;
hold on

scatter(NewNodes_0(:,1), NewNodes_0(:,2),ScatterSize-10,'k', 'filled'); % Plot the cells 1

axis equal
xlim([0-3,Width-3]);
ylim([0-3,Width-3]);


            
 for i=1:4
     H.Children(i).YColor = [ 1 1 1]
     H.Children(i).XColor = [ 1 1 1]
     H.Children(i).Position(4) =  0.412
     
     H.Children(i).XAxis.Visible = 'off'
     H.Children(i).YAxis.Visible = 'off'
     
     H.Children(i).Box = 'off'

 end

end







function [DeformedNodes] = QuadDef(InitalNodes)
    DeformedNodes = InitalNodes;
    DeformedNodes(:,1) = DeformedNodes(:,1).*DeformedNodes(:,1);
    DeformedNodes(:,2) = DeformedNodes(:,2).*DeformedNodes(:,2);
end




function y = rootmeansquare(x)
y = sqrt(mean(x.*x));
end


function y = rmsE(x)
y = sqrt(sum( (x-mean(x)).*(x-mean(x)))/ length(x));
end




function  AddAllPaths
addpath("/Users/jcrawshaw/Documents/Projects/MeshMatlab/HistoryDependentRemeshingFunctions");
addpath("/Users/jcrawshaw/Documents/Projects/MeshMatlab/MeshingTools")
addpath("/Users/jcrawshaw/Documents/Projects/MeshMatlab/MeshingTools/stlTools")
addpath("/Users/jcrawshaw/Documents/Projects/MeshMatlab/MeshingTools/MESH2D_MatlabCodeToGenerateMeshes")
addpath("/Users/jcrawshaw/Documents/Projects/MeshMatlab/")

% SkalakStrainCourse = SkalakStrainEnergyDenistyAcrossDomain(Elements_old,InitalNodes, DeformedNodes);

    
    %------ Get the skalak strain for the new mesh
%     [SkalakStrain_New{k}] = SkalakStrainEnergyDenistyAcrossDomain(Elements_New{k}, NewNodes_0{k}, NewNodes{k});

end



% Snippit to collect stats
% stats = [EdgeLength;MeanErrorC;stdErrorC;NodeCountC;ElementCountC]';
% fileID = fopen(("/Users/jcrawshaw/Documents/Projects/MeshMatlab/ErrorAnalysis/2DErrorAnaysis_CourseInital.txt"),'w');
% fprintf(fileID, '2D Error Anaysis on Square -- Wavy def -- CourseInital\n');
% fprintf(fileID, 'EdgeLength, MeanError, StdError, NodeCount, ElementCount\n');
%  fprintf(fileID,'%f %f %f %f %f \n',Stats' );
% fclose(fileID);
% close all



function [Median_1,Q25_1, Q75_1] = GetErrorStats(NewStrain,OriginalStrain)

% Now get the error terms here pls
% Error between original and remeshed mesh

Err1 = abs(NewStrain' - OriginalStrain);

% ---------------------------------------------------------

% Error between original and remeshed mesh
Median_1 = quantile(Err1(:),0.5);   
Q25_1 = quantile(Err1(:),0.25);     
Q75_1 = quantile(Err1(:),0.75);     

end




