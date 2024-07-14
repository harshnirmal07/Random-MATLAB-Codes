%Coefficient Matrix
Coeff=[1 0 0 0 0 0 0 0;
       0.7783 -1 0 0 0 0 0 0;
       0 1 -1 -1 0 0 0 0;
       -0.5529 0 1 0 0 0 0 0;
       0 0 0 1 -1 -1 0 0;
       0 0 0 0 0 1 -1 -1;
       -0.2176 0 0 0 0 0 1 0;
       -0.10946 0 0 0 0 0 0 1];
Res=[6000;0;0;3.103;0;0;-3.06469;-0.36469];
N=linsolve(Coeff, Res);%Stream Molar Flow Rate
n3=N(1);
X4=[(1-33.25/100);(2-3*33.25/100);33.25/100;33.25/100]*n3;
n4=N(2);
X5=[X4(1:3,1).*[97.2/100;99.97/100;2.35/100];3.103];
n5=N(3);
X6=X4-X5;
n6=N(4);
X8=zeros(4,1);
ratio=[31.89;0;1.0125;1.00265];
for i=1:4
    if i==2
        X8(i)=0;
    else
        X8(i)=X6(i)/ratio(i);
    end
end
n8=N(6);
X7=X6-X8;
n7=N(5);
X9=[X8(1:3,1);0];
n9=N(7);
X10=X8-X9;
n10=N(8);
m_CO2=44*2000;
m_H2=2*2*2000;
m_CH3OH=32*X9(3);
Cost_CO2=m_CO2*linspace(0.025,1,10);
Cost_H2=m_H2*linspace(0.5,2,10);
Phi=0.1;
Power=[9.7,0,12;
    21.5,0,20.9;
    0,0.28,0;
    0,0,22.6;
    0,0,0;
    0,0,0;
    0,0.8,0;
    0,15.7,15.4];
Power_costs=zeros(8,3);
Power_costs(:,1)=Power(:,1)*10^3*7884*0.072;
Power_costs(:,2)=Power(:,2)*10^3*7884*2.5*3.6;
Power_costs(:,3)=Power(:,3)*10^3*7884*0.212*3.6;
Capital_costs=[14696200, 29418000, 1.53*10^7*((X4(1)*44+X4(2)*2+X4(3)*32+X4(4)*18)/54000)^0.65, 269600, 171300, 168100, 63000, 1507900];
Cop=sum(Power_costs,'all');
Ccap=sum(Capital_costs);
[X,Y]=meshgrid(Cost_CO2,Cost_H2);
Cost_CH3OH=((Phi*Ccap+Cop)*ones(1,10)+X+Y).*1000/m_CH3OH;
contourf(X,Y,Cost_CH3OH,10);