r1 = [2000 0 0 0];
r2 = [0 4000 0 0];
r3 = [4064 10266.1 14.8 3.1];
r4 = [2844.8 6608.5 1233.9 1222.3]; %flow rates
r5 = [2172.6 6595.8 15.5 3.3];
r5r = r3-r1-r2;
r6 = r4-r5;
tb_CH3OH = 64.7; Hv_CH3OH = 35.37;
tb_H2O = 100; Hv_H2O = 40.656; %temp and heat of vaporization
%% stream 1
t1 = 210;
H1_CO2 = calculate_H_CO2(25,t1);
H1 = [H1_CO2 0 0 0];
exp1 = r1.*H1;
%% stream 2
t2 = 210;
H2_H2 = calculate_H_H2(25,t2);
H2 = [0 H2_H2 0 0];
exp2 = r2.*H2;
%% stream 5r
t5r = 40;
H5r_CO2 = calculate_H_CO2(25,t5r);
H5r_H2 = calculate_H_H2(25,t5r);
H5r_CH3OH = calculate_H_CH3OH(25,tb_CH3OH)+ Hv_CH3OH + calculate_H_CH3OH(tb_CH3OH,t5r);
H5r_H2O = calculate_H_H2O(25,tb_H2O)+ Hv_H2O + calculate_H_H2O(tb_H2O,t5r);
H5r = [H5r_CO2 H5r_H2 H5r_CH3OH H5r_H2O];
exp5r = r5r.*H5r;
options = optimset("Display","off");
t3 = fsolve(@(t3) sum(r3.*[calculate_H_CO2(25,t3) calculate_H_H2(25,t3) calculate_H_CH3OH(25,tb_CH3OH)+ Hv_CH3OH + calculate_H_CH3OH(tb_CH3OH,t3) calculate_H_H2O(25,tb_H2O)+ Hv_H2O + calculate_H_H2O(tb_H2O,t3)])-sum(exp1,"all")-sum(exp2,"all")-sum(exp5r,"all"),0,options);


%% part2 -> cooling duty of C1
%stream 4
t4 = 210;
H4_CO2 = calculate_H_CO2(25,t4);
H4_H2 = calculate_H_H2(25,t4);
H4_CH3OH = calculate_H_CH3OH(25,tb_CH3OH)+ Hv_CH3OH + calculate_H_CH3OH(tb_CH3OH,t4);
H4_H2O = calculate_H_H2O(25,tb_H2O)+ Hv_H2O + calculate_H_H2O(tb_H2O,t4);
H4 = [H4_CO2 H4_H2 H4_CH3OH H4_H2O];
exp4 = r4.*H4;
%% stream 5
t5 = 40; %same as 5r
H5 = [H5r_CO2 H5r_H2 H5r_CH3OH H5r_H2O];
exp5 = r5.*H5;
%% stream6
t6 = t5; %liquid phase(so Hv can be neglected for CH3OH and H2 as T>Tc)
H6_CO2 = calculate_H_CO2(25,t6);
H6_H2 = calculate_H_H2(25,t6)-0.904;
H6_CH3OH = calculate_H_CH3OH(25,t6);
H6_H2O = calculate_H_H2O(25,t6);
H6 = [H6_CO2 H6_H2 H6_CH3OH H6_H2O];
exp6 = r6.*H6;
cooling_duty_C1 = (sum(exp5,"all")+sum(exp6,"all")-sum(exp4,"all"))/3600;
fprintf("The cooling duty of C1: %0.2f Megawatts(negative sign indicates heat lost)",cooling_duty_C1);
%% enthalpy functions
%% CO2
function f = calculate_H_CO2(t1,t2)
func = @(T) 36.11*10^(-3) + 4.233*10^(-5)*T - 2.887*10^(-8)*T.^2 + 7.464*10^(-12)*T.^3;
f = integral(func,t1,t2);
end
%% H2
function f = calculate_H_H2(t1,t2)
func = @(T) 28.84*10^(-3) + 0.00765*10^(-5)*T + 0.3288*10^(-8)*T.^2 - 0.8698*10^(-12)*T.^3;
f = integral(func,t1,t2);
end
%% CH3OH
function f = calculate_H_CH3OH(t1,t2)
if t1<65 && t2<65
func = @(T) 75.86*10^(-3) + 16.83*10^(-5)*T;
else
func = @(T) 42.93*10^(-3) + 8.301*10^(-5)*T - 1.87*10^(-8)*T.^2 - 8.03*10^(-12)*T.^3;
end
f = integral(func,t1,t2);
end
%% H2O
function f = calculate_H_H2O(t1,t2)
if t1<100 && t2<100
func = @(T) 75.4*10^(-3)*T.^0;
else
func = @(T) 33.46*10^(-3) + 0.688*10^(-5)*T + 0.7604*10^(-8)*T.^2 - 3.593*10^(-12)*T.^3;
end
f = integral(func,t1,t2);
end