function [pl,ql,pr,qr] = bcfun(xl,ul,xr,ur,t)

pl = ul - 1;  
ql = 0;     
Bi = 10;
pr = ur * (1 + Bi);  
qr = 1;    

end
