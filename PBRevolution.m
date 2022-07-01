%PBR evolution exploration
%JRA June 30, 2022
clear all
close all
%the basic idea is a progressive decrease in fagility (alpha) over time as
%a result of environmental factors (weathering, fatigue, etc.) and rapid
%reset of low fragility objects in earthquakes.

%~~~~~~~~~~~~~~~~~~
%change variables here
n=1000; %number of samples
nlines=25; %number of histories to draw
alpha0=0.5; %initial alpha
alpha0sd=0.1; %initial alpha standard deviation
R=0.00001; %decrease in alpha per year
Rsd=R.*0.05;%R standard deviation
eq1 = 5000; %first earthquake years
alphathreshold=0.3; %alphas lower than this fail and return to initial alpha
alphamax=1; %helps with plotting
binedges=[0:0.01:1];
maxtime = 10000; % how long is the model run
alittlebit=10; %time before and after the earthquake so we can see the trajectories better
x=0+(100-0).*rand(n,1);
y=0+(100-0).*rand(n,1);
%~~~~~~~~~~~~~~~~~~~

%Compute intermediate values
alpha0dist=alpha0+alpha0sd.*randn(n,1);
Rdist=R+Rsd.*randn(n,1);
alpha = ripenPBR(alpha0dist,eq1, Rdist);
nhistory = floor(1+(n-1).*rand(nlines,1));
starttime=zeros(nlines,1);


%Start
figure(1)
clf
m=5;
n=1;
title('Fragility distributions')
subplot(m,n,1)
histogram(alpha0dist, binedges)
axis([0 alphamax -inf inf])
legend('\alpha initial')




%interseismic period 1
figure(1)
subplot(m,n,2)
histogram(alpha, binedges)
axis([0 alphamax -inf inf])
s=sprintf(' %d years\n',eq1);
ss=strcat('\alpha after', s);
legend(ss)

figure(2)
clf
hold on
for i=1:length(nhistory)
    plot([starttime starttime+eq1-alittlebit],[alpha0dist(nhistory(i)) alpha(nhistory(i))],'k-')
%drawnow
end
ylabel('alpha')
xlabel('time (yrs)')

%earthquake
[alphaoutput,alphastoppled, locs] = shakePBRs(alpha,alphathreshold, alpha0,alpha0sd);
figure(1)
subplot(m,n,3)
histogram(alphastoppled, binedges)
axis([0 alphamax -inf inf])
ylabel('number')
legend('\alpha removed in the earthquake')
subplot(m,n,4)
histogram(alphaoutput, binedges)
axis([0 alphamax -inf inf])
legend('\alpha reset')

figure(3)
clf
sz = 8;
scatter(x,y,sz,alpha,'filled')
hold on
plot(x(locs),y(locs),'ko')
colorbar
axis equal
xlabel('x distance (m)')
ylabel('y distance (m)')
title('fragility at the event and those that failed')


figure(2)
hold on
for i=1:length(nhistory)
    plot([eq1-alittlebit eq1+alittlebit],[alpha(nhistory(i)) alphaoutput(nhistory(i))],'k-')
%drawnow
end
plot(eq1,alphathreshold,'r*','MarkerSize',10)

%interseismic period 2
alpha = ripenPBR(alphaoutput,maxtime-eq1, Rdist);
figure(1)
subplot(m,n,5)
histogram(alpha, binedges)
axis([0 alphamax -inf inf])
xlabel('alpha')
s=sprintf(' %d years\n',maxtime);
ss=strcat('\alpha at', s);
legend(ss)


figure(2)
hold on
for i=1:length(nhistory)
    plot([eq1+alittlebit maxtime],[alphaoutput(nhistory(i)) alpha(nhistory(i))],'k-')
drawnow
end
title('Evolution of fragility')
