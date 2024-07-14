
syms F1_CO2 F2_H2 F3_CO2 F3_H2 
     F3_CH3OH F3_H2O F4_CO2 F4_H2 F4_CH3OH
     F4_H2O F5_CO2 F5_H2 F5_CH3OH F5_H2O F5R_CO2 F5R_H2 
     F5R_CH3OH F5R_H2O F5P_CO2 F5P_H2 F5P_CH3OH F5P_H2O
     F6_CO2 F6_H2 F6_CH3OH F6_H2O F7_CO2 F7_H2 
     F7_CH3OH F7_H2O F8_CO2 F8_H2 F8_CH3OH 
             F8_H2O F9_CO2 F9_H2 F9_CH3OH F9_H2O F10_CO2
            F10_H2 F10_CH3OH F10_H2O
 
OC = 0.6356; %OVERALL CONVERSION IS 0.6356 OF CO2
 
 
EQNS = [
 F1_CO2 == 2000;
 F2_H2 == 4000;
 F6_CO2 == 145.34;
 F6_H2 == 0.789;
 F6_CH3OH == 1265.53;
 F6_H2O == 1269.99;
 F8_H2 == 0;
 
 F3_CO2 == F1_CO2 + F5R_CO2,
 F3_H2 == F2_H2 + F5R_H2,
 F3_CH3OH == F5R_CH3OH,
 F3_H2O == F5R_H2O,
 F5P_CO2 == (1-OC)*F1_CO2 - F6_CO2,
 F5_CO2 == 20*F5P_CO2,
 F4_CO2 == F5_CO2 + F6_CO2,
 F5P_H2 == F2_H2 - 3*OC*F1_CO2 - F6_H2,
 F5_H2 == 20*F5P_H2,
 F4_H2 == F5_H2 + F6_H2,
 F5P_CH3OH == OC*F1_CO2 - F6_CH3OH,
 F5_CH3OH == 20*F5P_CH3OH,
 F4_CH3OH == F5_CH3OH + F6_CH3OH,
 F5P_H2O == OC*F1_CO2 - F6_H2O,
 F5_H2O == 20*F5P_H2O,
 F4_H2O == F5_H2O + F6_H2O,
 
 F5R_CO2 == 0.95*F5_CO2,
 F5R_H2 == 0.95*F5_H2,
 F5R_CH3OH == 0.95*F5_CH3OH,
 F5R_H2O == 0.95*F5_H2O,
 F7_CO2 == (57.74/58.74)*F6_CO2,
 F7_H2 == F6_H2,
 F7_CH3OH == (0.0212/1.0212)*F6_CH3OH,
 F7_H2O == (0.0043/1.0043)*F6_H2O,
 F8_CO2 == F6_CO2 - F7_CO2,
 F8_CH3OH == F6_CH3OH - F7_CH3OH,
 F8_H2O == F6_H2O - F7_H2O,
 F9_CO2 == F8_CO2,
 F9_H2 == F8_H2,
 F9_CH3OH == F8_CH3OH,
 F9_H2O == 0.0091*F8_H2O,
 F10_CO2 == 0,
 F10_H2 == 0,
 F10_CH3OH == 0,
 F10_H2O == 0.9909*F8_H2O
];
 
SOL = solve(EQNS,[F1_CO2,F2_H2,F3_CO2,F3_H2,F3_CH3OH,F3_H2O,F4_CO2,F4_H2,F4_CH3OH,F4_H2O,F5_CO2,F5_H2,F5_CH3OH,F5_H2O,F5R_CO2,F5R_H2,F5R_CH3OH,F5R_H2O,F5P_CO2,F5P_H2,F5P_CH3OH,F5P_H2O,F6_CO2,F6_H2,F6_CH3OH,F6_H2O,F7_CO2,F7_H2,F7_CH3OH,F7_H2O,F8_CO2,F8_H2,F8_CH3OH,F8_H2O,F9_CO2,F9_H2,F9_CH3OH,F9_H2O,F10_CO2,F10_H2,F10_CH3OH,F10_H2O]);
 
fprintf('The molar flow rate of stream 1 is: %d kmol/hr\n', double(SOL.F1_CO2));
fprintf('The molar flow rate of stream 2 is: %d kmol/hr\n', double(SOL.F2_H2));
fprintf('The molar flow rate of stream 3 is: %d kmol/hr\n', double(SOL.F3_CO2 + SOL.F3_H2 + SOL.F3_CH3OH + SOL.F3_H2O));
fprintf('The molar flow rate of stream 4 is: %d kmol/hr\n', double(SOL.F4_CO2 + SOL.F4_H2 + SOL.F4_CH3OH + SOL.F4_H2O));
fprintf('The molar flow rate of stream 5 is: %d kmol/hr\n', double(SOL.F5_CO2 + SOL.F5_H2 + SOL.F5_CH3OH + SOL.F5_H2O));
fprintf('The molar flow rate of stream 5R is: %d kmol/hr\n', double(SOL.F5R_CO2 + SOL.F5R_H2 + SOL.F5R_CH3OH + SOL.F5R_H2O));
fprintf('The molar flow rate of stream 6 is: %d kmol/hr\n', double(SOL.F6_CO2 + SOL.F6_H2 + SOL.F6_CH3OH + SOL.F6_H2O));
fprintf('The molar flow rate of stream 7 is: %d kmol/hr\n', double(SOL.F7_CO2 + SOL.F7_H2 + SOL.F7_CH3OH + SOL.F7_H2O));
fprintf('The molar flow rate of stream 8 is: %d kmol/hr\n', double(SOL.F8_CO2 + SOL.F8_H2 + SOL.F8_CH3OH + SOL.F8_H2O));
fprintf('The molar flow rate of stream 9 is: %d kmol/hr\n', double(SOL.F9_CO2 + SOL.F9_H2 + SOL.F9_CH3OH + SOL.F9_H2O));
fprintf('The molar flow rate of stream 10 is: %d kmol/hr\n', double(SOL.F10_CO2 + SOL.F10_H2 + SOL.F10_CH3OH + SOL.F10_H2O));
 
a = double(SOL.F9_CH3OH);
n4 = double(SOL.F4_CO2 + SOL.F4_H2 + SOL.F4_CH3OH + SOL.F4_H2O);
n6 = double(SOL.F6_CO2 + SOL.F6_H2 + SOL.F6_CH3OH + SOL.F6_H2O);
n8 = double(SOL.F8_CO2 + SOL.F8_H2 + SOL.F8_CH3OH + SOL.F8_H2O);
F3 = double(2000*44 + 4000*2);
F3p = double(SOL.F3_CO2 + SOL.F3_H2 + SOL.F3_CH3OH + SOL.F3_H2O);
 
pco2 = linspace(0.025,1,100);
ph2 = linspace(0.5,2,100);
 
for i=1:100
 for j=1:100
 
 C_cap(i,j) = 14694200 + 29418000 + (1.53*(10^7)*((F3/54000)^0.65)) + 269600 + 171300 + 168100 + 63000 + 1507900;
 C_capp(i,j) = 14694200 + 29418000 + (1.53*(10^7)((F3p/54000)^0.65)) + 269600(n4/4670)^(0.6) + 171300*(n4/4670)^(0.6) + 168100*(n6/(1.349251e+03))^(0.6) + 63000*(n8/(1.302675e+03))^(0.6) + 1507900*(n8/(1.302675e+03))^(0.6);
 phi = 0.1;
 C_op(i,j) = ((9.7+21.5)72 + (0.28+0.8+15.7)*1000*3600*2.5(10^-6) + (12+20.9+22.6+15.4)1000*3600*2.12(10^-7) + (2000*44)*pco2(i) + (4000*2)*ph2(j))*7884;
 TAC(i,j) = phi*C_cap(i,j) + C_op(i,j);
 TACp(i,j) = phi*C_capp(i,j) + C_op(i,j);
 C_methanol(i,j) = TAC(i,j)/(7884*(a*32/1000));
 C_methanolp(i,j) = TACp(i,j)/(7884*(a*32/1000));
 
 end
end
 
figure(1);
contour(ph2,pco2,C_methanol,1000);
colorbar();
figure(2);
contour(ph2,pco2,C_methanolp,1000);
colorbar();
figure(3);
contour(ph2,pco2,(C_methanol-C_methanolp),1000);
colorbar();
 
pco2 = 0.1;
ph2 = 1;
 
C_capf = 14694200 + 29418000 + (1.53*(10^7)((F3/54000)^0.65)) + 269600(n4/4670)^(0.6) + 171300*(n4/4670)^(0.6) + 168100*(n6/(1.349251e+03))^(0.6) + 63000*(n8/(1.302675e+03))^(0.6) + 1507900*(n8/(1.302675e+03))^(0.6);
C_elef = (9.7+21.5)*72*7884;
C_heatf = (0.28+0.8+15.7)*1000*3600*2.5(10^-6);
C_coolf = (12+20.9+22.6+15.4)*1000*3600*2.12(10^-7);
C_rawf = 2000*44*0.1 + 4000*2*1;
 
C_capff = 14694200 + 29418000 + (1.53*(10^7)((F3p/54000)^0.65)) + 269600(n4/4670)^(0.6) + 171300*(n4/4670)^(0.6) + 168100*(n6/(1.349251e+03))^(0.6) + 63000*(n8/(1.302675e+03))^(0.6) + 1507900*(n8/(1.302675e+03))^(0.6);
C_eleff = (9.7+21.5+0.97)*72*7884;
C_heatff = (19.76 + 1.76 + 30.22)*1000*3600*2.5(10^-6);
C_coolff = (12+20.9+65.7+29.6)*1000*3600*2.12(10^-7);
C_rawff = 2000*44*0.1 + 4000*2*1;
 
Matrix = [C_capf,C_capff;C_elef,C_eleff];
Matrix2 = [C_heatf,C_heatff;C_coolf,C_coolff;C_rawf,C_rawff];
Matrixf = Matrix';
Matrixf2 = Matrix2';
figure(4);
bar(Matrixf, 'stacked');
figure(5);
bar(Matrixf2, 'stacked');