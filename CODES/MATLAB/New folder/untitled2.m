clear all	
	
% Question 1	
	
xdata=[0 0.02 0.04 0.06 0.08 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 0.95 1.0]	
ydata=[0 0.134 0.23 0.304 0.365 0.418 0.579 0.665 0.729 0.779 0.825 0.87 0.915 0.958 0.979 1]	
	
x0=[1 1 1]	
fun = @(x,xdata) (x(1).*xdata)./(1+x(2).*xdata+x(3).*xdata.*xdata)	
p = lsqcurvefit(fun,x0,xdata,ydata)	
	
y_fitted=(p(1).*xdata)./(1+p(2).*xdata+p(3).*xdata.*xdata)	
	
figure	
plot(xdata, y_fitted)	
hold on	
plot(xdata,ydata,'o')	
xlabel('x')	
ylabel('y')	
title('Equilibrium Curve')	
	
% Q3	
	
z=0.45	
F=500	
q=0.8	
	
x_d=0.97	
x_w=0.2	
	
S=50	
x_s=0.70	
q_s=1	
	
D=(F*z-F*x_w-S*x_s+S*x_w)/(x_d-x_w)	
W=F-D-S	
	
% Feed Line	
x_data=linspace(0.3,0.5,10)	
y_feed=x_data*(q/(q-1))-z/(q-1)	
	
figure	
plot(xdata, y_fitted)	
hold on	
plot(xdata,xdata)	
plot(x_d, x_d, 'o')	
plot(x_w, x_w, 'o')	
plot(z, z, 'o')	
plot(x_s, x_s, 'o')	
plot(x_data,y_feed)	
	
xlabel('x')	
ylabel('y')	
title('Equilibrium Curve')	
	
% Q5	
	
plot(x_s*ones(10,1),linspace(0.7,1,10))	
	
% Q6	
y_intersect=(p(1).*x_s)./(1+p(2).*x_s+p(3).*x_s.*x_s)	
	
m=(x_d-y_intersect)/(x_d-x_s)	
R_min=m/(1-m)	
	
R_actual=2.5*R_min	
	
% Q7	
	
V1 = (R_actual+1)*D	
L1 = R_actual*D	
x_val = linspace(0.97,0.7,10)	
y_val = (L1/V1)*x_val+x_d/(R_actual+1)	
	
plot(x_val,y_val)	
	
x_val1=linspace(0.2,0.7,10)	
y_val1=((L1-S)/V1)*x_val1+(x_d*D+S*x_s)/V1	
	
plot(x_val1, y_val1)	
	
L3 = F*q+L1-S	
V3=(q-1)*F+V1	
y_val2=(L3/V3)*x_val1-W*x_w/V3	
	
plot(x_val1, y_val2)	
	






slope_1 = r/(r+1)	
slope_2 = m	
slope_3 = l_bar*x/(l_bar-w)	
	
x_int_1 = xs	
y_int_1 = r*x_int_1/(r+1) + xd/(r+1)	
x_int_2 = 0.3958	
y_int_2 = l_bar*x_int_2/(l_bar - w) - w*xw/(l_bar-w)	
	
X_1 = .97	
Y_1 = .97	
nt = -1	
while(X_1 >= x_int_1)	
    X_old = X_1	
    Y_old = Y_1	
    Y_1 = y_int_1 + (X_1 -x_int_1)*slope_1	
    X_1 = fsolve(@(X) Y_1 - para(1)*X/(1+para(2)*X + para(3)*X^2) , 0)	
   	
    nt = nt + 1	
    line([X_old X_old],[Y_old Y_1])	
    line([X_old X_1],[Y_1 Y_1])	
end	
	
	
while(X_1 >= x_int_2)	
    X_old = X_1	
    Y_old = Y_1	
    Y_1 = y_int_2 + (X_1 -x_int_2)*slope_2	
    X_1 = fsolve(@(X) Y_1 - para(1)*X/(1+para(2)*X + para(3)*X^2) , 0)	
   	
    nt = nt + 1	
    line([X_old X_old],[Y_old Y_1])	
    line([X_old X_1],[Y_1 Y_1])	
end	
	
	
	
while(X_1 >= xw)	
    X_old = X_1	
    Y_old = Y_1	
    Y_1 = y_int_2 + (X_1 -x_int_2)*slope_3	
    X_1 = fsolve(@(X) Y_1 - para(1)*X/(1+para(2)*X + para(3)*X^2) , 0)	
   	
    nt = nt + 1	
    line([X_old X_old],[Y_old Y_1])	
    line([X_old X_1],[Y_1 Y_1])	
end	
