%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              Simulations of RA_NOMA 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%             

x = linspace(0,1,100);
y = linspace(0,1,100);

[a1,a2] = meshgrid(x,y);

ro = [-20 -20 -20; -10 -10 -10; 0 0 0];

ro = 10.^(ro/10);

a3 = max(1 - a1 -a2, 0.0);
r31 = 1+a3./(9./ro(3,1)); r32 = 1+a3./(9./ro(3,2)); r33 =  1+a3./(9./ro(3,3));
r21 = 1+a2./(a3+9./ro(2,1)); r22= 1+a2./(a3+9./ro(2,2));
r11 = 1+a1./(a2+a3+9/ro(1,1));

% R = log2(r31) + log2(r32) + log2(r33) + log2(r21) + log2(r22) + log2(r11);
R = log2(r31) + log2(r21) + log2(r11);

figure;
% mesh(zz);
surface(a1,a2,R);
xlabel('a_{1}','FontSize',12);%, 'FontWeight','bold');
ylabel('a_{2}','FontSize',12);%, 'FontWeight','bold');
box on;
grid on;
% xlim([mue.SINR_min, mue.SINR_max]);
colorbar;