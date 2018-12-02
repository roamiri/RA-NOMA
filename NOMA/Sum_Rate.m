
clear;
clc;

Pm = linspace(7,30,20);

Rate_Matrix = zeros(size(Pm,2), 3); % Each row contains the rate of OMA, RAMA-OMA, and RA-NOMA
for i=1:size(Pm,2)
    Rate_Matrix(i,:)= PowerAllocation(Pm(1,i), 1e0, true);
end

%% Draw Figures
blue = [0, 0.4470, 0.7410];%	          	[0, 0, 1]
orange = [0.8500, 0.3250, 0.0980];%	          	[0, 0.5, 0]
yellow=[0.9290, 0.6940, 0.1250];%	          	[1, 0, 0]
purple=[0.4940, 0.1840, 0.5560];%	          	[0, 0.75, 0.75]
green=[0.4660, 0.6740, 0.1880];%	          	[0.75, 0, 0.75]
lightblue=[0.3010, 0.7450, 0.9330];%	          	[0.75, 0.75, 0]
red=[0.6350, 0.0780, 0.1840];

figure;
hold on;
grid on;
box on;
% plot(ones(1,10)*4.0, '--k', 'LineWidth',1);
plot(Pm, Rate_Matrix(:,1), '--o', 'LineWidth',1.3,'MarkerSize',8, 'color', red, 'MarkerFaceColor',red);
plot(Pm, Rate_Matrix(:,2), '--o', 'LineWidth',1.3,'MarkerSize',8, 'color', blue, 'MarkerFaceColor',blue);
plot(Pm, Rate_Matrix(:,3), '--d', 'LineWidth',1.3,'MarkerSize',8, 'color', green, 'MarkerFaceColor',green);
xlabel('SNR','FontSize',12);%, 'FontWeight','bold');
ylabel('Sum transmission rate (b/s/Hz)','FontSize',12);%, 'FontWeight','bold');
xlim([min(Pm) max(Pm)]);
ylim([0 1.2*max(max(Rate_Matrix))]);
legend({'OMA','RAMA-OMA','RA-NOMA'},'Interpreter','latex','FontSize',12);