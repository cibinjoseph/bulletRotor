function dist=polarDist(P1,P2)
% Distance between P1(r1,psi1) and P2(r2,psi2)
dist=sqrt(P1(1)*P1(1)+P2(1)*P2(1)-2*P1(1)*P2(1)*cos(P1(2)-P2(2)));
return;