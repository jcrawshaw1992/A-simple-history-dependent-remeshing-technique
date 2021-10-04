# A simple history dependent remeshing technique

The code in this git hub repository is an example of the  history dependent meshing technique introduced in "A simple history-dependent remeshing technique to increase finite element model stability in elastic surface deformations" Crawshaw et al. (currently in review). This paper can be found on the archive: https://arxiv.org/abs/2011.06756

This example is written in MatLab because we believe it is the easiest language to demonstrate the code. We have also implemented this technique in C++ in Chaste (https://github.com/Chaste/Chaste), although this is not yet in the main trunk. Feel free to email me for the C++ code or if you have any questions (jessica.crawshaw@maths.ox.ac.uk).

Matlab code to transfer history dependent variables between meshes.

Need to also install MESH2D --  a matlab repository by  Darren Engwirda needed to generate sample meshes in 2D. 
Mesh2D is called in initmesh();
This can be found at:
https://au.mathworks.com/matlabcentral/fileexchange/25555-mesh2d-delaunay-based-unstructured-mesh-generation
https://github.com/dengwirda/mesh2d


D. Engwirda, Locally-optimal Delaunay-refinement and optimisation-based mesh generation, Ph.D. Thesis, School of Mathematics and Statistics, The University of Sydney, http://hdl.handle.net/2123/13148, 2014.

D. Engwirda, Unstructured mesh methods for the Navier-Stokes equations, Honours Thesis, School of Aerospace, Mechanical and Mechatronic Engineering, The University of Sydney, 2005.
