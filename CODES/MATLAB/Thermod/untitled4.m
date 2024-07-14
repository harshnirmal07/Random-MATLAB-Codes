clear; close all; clc;
n=1;
r=0.08314;cv = 3/2*r;cp=5/2*r; g=cp/cv;
ta = 343; pa=1;
ge=g/(1-g);
tb= 420;  pb=pa*ta^(ge)/(tb^ge);
va=n*r*ta/pa;
vb=n*r*tb/pb;

pc=pb;tc=ta;
vc=pa*pb/pc;

% plot of all the processes
x1=linspace(vb,va,100);
y1=pa*va^(g)./(x1.^(g)); %for adiabatic portion
plot(x1,y1);hold on;
x2 = linspace(vc,vb,100);
y2 = pb*ones(1,100);
plot(x2,y2);hold on;
x3=linspace(vc,va,100);
y3=n*r*ta./x3;
plot(x3,y3,'black');