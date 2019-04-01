# Here is MATLAB code I have developed for some geomorphology projects. 


_Items included here:_

- WRTT_clean.m -- This is a script that creates a swath profile from input XY positions. 
  - First, it uses the Topotoolbox swath tool to extract a 200 m profile along the kinked path of the points. Secondly, I used the swath profile to pull a 1 m wide profile (just 1 or two points) along the kinked path. But then I too the xy positions of those extracted points and rotated them (-13 so it is along the 103 bearing). The distance along the profile is then projected to that single plane.  I plotted it with and without vertical exaggeration.
  - I used Topotoolbox (https://topotoolbox.wordpress.com/) . Should be sure to cite Schwanghart and Scherler (Schwanghart, W., Scherler, D. (2014): TopoToolbox 2 – MATLAB-based software for topographic analysis and modeling in Earth surface sciences. Earth Surface Dynamics, 2, 1-7. [DOI: 10.5194/esurf-2-1-2014]) when we introduce the methods.
  - The raster data come from OpenTopography: http://opentopo.sdsc.edu/raster?opentopoID=OTSDEM.022015.26911.2
  
- Xu_profs.m -- This is a script that is modified from WRTT_clean.m. 
  - It uses the mouse to click out the vertices (or endpoints) of the profile. It makes two swaths with user defined widths. The first is a wider one to explore how that looks. The second is intended to be very narrow (just a couple of pixels wide--so it depends on the input DEM resolution). The mouse-defined vertices are written out as a text file as well as the profile of the narrow swath (with cross-profile averaged elevations).
    - I used Topotoolbox (https://topotoolbox.wordpress.com/) . Should be sure to cite Schwanghart and Scherler (Schwanghart, W., Scherler, D. (2014): TopoToolbox 2 – MATLAB-based software for topographic analysis and modeling in Earth surface sciences. Earth Surface Dynamics, 2, 1-7. [DOI: 10.5194/esurf-2-1-2014]) when we introduce the methods.
    - The raster data come from OpenTopography: http://opentopo.sdsc.edu/dataspace/dataset?opentopoID=OTDS.102018.32611.2
    
  

