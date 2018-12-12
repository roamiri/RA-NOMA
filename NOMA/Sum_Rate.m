
clear;
clc;

Pm = linspace(10,30,20);
PL = [ -10, -5, 0;
       -10, -5, 0;
       -10, -5, 0; ];
h = 10.^(PL./20);
Rate_Matrix = zeros(size(Pm,2), 3); % Each row contains the rate of OMA, RAMA-OMA, and RA-NOMA
sigma2 = 1e0;
NRF = 3; % Number of RF Chains
NB = 3; % Number of beams 
%% OMA (TDMA) 
for j=1:size(Pm,2)
    sum_rate = 0.;
    for i=1:9
        sum_rate = sum_rate + log2(1 + (Pm(1,j).*h(i)^2)/(sigma2));
    end
    OMA_rate = sum_rate/9; % Since it is TDMA and averaged over nine time slots.
    Rate_Matrix(j,1)= OMA_rate;
end

%% RAMA-OMA

for j=1:size(Pm,2)
    sum_rate = 0.;
    for i=1:9
        sum_rate = sum_rate + log2(1 + (Pm(1,j).*h(i)^2)/(NB*sigma2));
    end
    RAMA_OMA_rate = sum_rate/3; % Since it is TDMA for each group of RAMA and averaged over three time slots.
    Rate_Matrix(j,2)= RAMA_OMA_rate;
end

for i=1:size(Pm,2)
    Rate_Matrix(i,3)= PowerAllocation(Pm(1,i), sigma2, h, true);
end

SNR = Pm; %10*log10(Pm);
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
plot(SNR, Rate_Matrix(:,1), '--o', 'LineWidth',1.3,'MarkerSize',8, 'color', red, 'MarkerFaceColor',red);
plot(SNR, Rate_Matrix(:,2), '--o', 'LineWidth',1.3,'MarkerSize',8, 'color', blue, 'MarkerFaceColor',blue);
plot(SNR, Rate_Matrix(:,3), '--o', 'LineWidth',1.3,'MarkerSize',8, 'color', green, 'MarkerFaceColor',green);
xlabel('SNR','FontSize',12);%, 'FontWeight','bold');
ylabel('Sum transmission rate (b/s/Hz)','FontSize',12);%, 'FontWeight','bold');
xlim([min(SNR) max(SNR)]);
ylim([0 1.2*max(max(Rate_Matrix))]);
legend({'OMA','RAMA-OMA','proposed RA-NOMA'},'Interpreter','latex','FontSize',12);