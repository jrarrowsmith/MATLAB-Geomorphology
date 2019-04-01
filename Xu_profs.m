%script to produce swath profile and narrow swath profile
%Needs Topotoolbox
%addpath(C:\Program Files\MATLAB\topotoolbox-master)
%JRA April 2019
clear all
close all
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%set a few variables
dem_file_name='GalwayLakeRd.9GCPs.2cmDEM.crop2.tif'; %geotiff DEM
output_file_name='landerstest1'; %for output of narrow profile
swathwidth=10; %bigger swath width in meters
narrowswathwidth=0.1; %narrow swath width in meters
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

%Here is a basic TopoToolbox set of commands to get started:
DEM = GRIDobj(dem_file_name); %Topotoolbox command to build gridobject
info(DEM) % everything's seems alright print out

%show the DEM with the swath location
figure(1)
imageschs(DEM,DEM,'ticklabels','nice','colorbar',false);
hold on
%these are the vertices of the swath profile:
[x,y]=ginput;
plot(x,y,'k-')

%Extract the broader swath along the x y path
SW = SWATHobj(DEM,x,y, 'width',swathwidth) %swathwidth wide swath
plot(SW)
title('DEM with swath location')

figure(2)
plotdz(SW)
title('Profile along swath')


%Extract a very narrow swath for scarp models
SW = SWATHobj(DEM,x,y, 'width',narrowswathwidth) %now do the swath again but just 0.2 m wide

figure(3) %shows the detailed map of the narrow swath
imageschs(DEM,DEM,'ticklabels','nice','colorbar',false);
hold on
plot(SW.X,SW.Y,'k.')
axis([min(min(SW.X)) max(max(SW.X)) min(min(SW.Y)) max(max(SW.Y))])

figure(4) %profile along swath (takes the average of each of the points in the narrowswath
plot(SW.distx,mean(SW.Z)','k.')
title('Profile along swath')

%write out the information
%first output the vertices of the profile in case we need them again
fileID = fopen(join([output_file_name "vertices" "txt"],"."),'w');
A=[x y];
fprintf(fileID,'%f %f\n',A');
fclose(fileID);

%now output the profile
fileID = fopen(join([output_file_name "profile" "txt"],"."),'w');
A=[SW.distx mean(SW.Z)'];
fprintf(fileID,'%f %f\n',A');
fclose(fileID);


