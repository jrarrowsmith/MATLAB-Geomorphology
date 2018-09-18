%script to produce swath profile and projected swath profile
%Needs Topotoolbox
%JRA September 2018
clear all
close all
bearing_for_profile = -13; %degrees
%Here is a basic TopoToolbox set of commands to get started:
DEM = GRIDobj('output_hh.tif');
info(DEM) % everything's seems alright
%these are the vertices of the swath profile:
point_names ={'PP01'
'PP02'
'PP03'
'PP04'
'PP05'
'PP06'
'PP07'
'PP08'
'PP09'
'PP10'}

x=[316221
316509
316817
317472
319108
320492
321080
321444
322254
322659];

y=[3876010
3875880
3875910
3875980
3875620
3875070
3874840
3874680
3874400
3874170];

%don't really need these z values
z=[652
647
645
635
505
379
356
339
315
315];

%show the DEM with the swath location
figure(1)
imageschs(DEM,DEM,'ticklabels','nice','colorbar',false);
hold on
plot(x,y,'k-')
text(x,y, point_names)

%Extract the broader swath along the x y path
SW = SWATHobj(DEM,x,y, 'width',200) %200 m wide swath
plot(SW)
title('DEM with swath location 200 m width')
print -dpng 'WRkinkedswathmap.png'
print -depsc 'WRkinkedswathmap.eps'

figure(2)
plotdz(SW)
title('Profile along kinked swath')
print -dpng 'WRkinkedswath.png'
print -depsc 'WRkinkedswath.eps'

%Extract a very narrow swath
SW = SWATHobj(DEM,x,y, 'width',1) %now do the swath again but just 1 m wide

figure(3)
imageschs(DEM,DEM,'ticklabels','nice','colorbar',false);
hold on
plot(SW.X,SW.Y,'k.')
%do our rotation
x=SW.X;
y=SW.Y;
z=SW.Z;
xx=size(x);
yy=size(y);
zz=size(z);

x=x(1:(xx(1)*xx(2)));
y=y(1:(yy(1)*yy(2)));
z=z(1:(zz(1)*zz(2)));

x_ave=mean(x);
y_ave=mean(y);
x=x-x_ave;
y=y-y_ave;

x_prime = -y.*sin(deg2rad(-bearing_for_profile))+x.*cos(deg2rad(-bearing_for_profile));
y_prime = y.*cos(deg2rad(-bearing_for_profile))+x.*sin(deg2rad(-bearing_for_profile));

figure(4)
plot(x+x_ave,y+y_ave, 'k.')
hold on
plot(x_prime+x_ave, y_prime+y_ave, 'ro')
xlabel('distance easting [and distance along profile--red] (m)')
ylabel('distance northing (m)')
axis equal
title('Map of points (red rotated)')
print -dpng 'rotatedprofilesmap.png'
print -depsc 'rotatedprofilesmap.eps'

x_distance=x-min(x);

figure(5)
subplot(2,1,1)
title('Projected profile')
plot(x_distance,z,'b-')
subplot(2,1,2)
plot(x_distance,z,'b-')
ylabel('Elevation (m)')
axis equal
xlabel('Projected distance (m)')

print -dpng 'WRprojectedprofile.png'
print -depsc 'WRprojectedprofile.eps'
