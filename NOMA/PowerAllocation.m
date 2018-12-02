%% test 
Pm = 20 ; % 20 Watt = 43 dBm
PL = [ 110, 100, 90;
       110, 100, 90;
       110, 100, 90; ];
 
h = 10.^(-PL./10);
sigma2 = 4e-21;
%% OMA (TDMA) 
sum_rate = 0;
for i=1:9
    sum_rate = sum_rate + log2(1 + (Pm.*h(i)^2)/(sigma2));
end

OMA_rate = sum_rate/9; % Since it is TDMA and averaged over nine time slots.

%% RAMA-OMA
sum_rate = 0;
for i=1:9
    sum_rate = sum_rate + log2(1 + (Pm.*h(i)^2)/(3*sigma2));
end

RAMA_rate = sum_rate/3; % Since it is TDMA for each group of RAMA and averaged over three time slots.
%% RA-NOMA
NRF = 3; % Number of RF Chains
Rb = ones(1,NRF);  % R_bar = minimum requirements
p = zeros(1,NRF);

