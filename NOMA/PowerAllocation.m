function [OMA_rate, RAMA_OMA_rate, RA_NOMA_rate] = PowerAllocation(Pm)
NRF = 3; % Number of RF Chains
NB = 3; % Number of beams 
% Pm = 300 ; % Watt
PL = [ -10, -5, 0;
       -10, -5, 0;
       -10, -5, 0; ];
 
h = 10.^(PL./20);
sigma2 = 1e-1;
%% OMA (TDMA) 
sum_rate = 0.;
for i=1:9
    sum_rate = sum_rate + log2(1 + (Pm.*h(i)^2)/(sigma2));
end

OMA_rate = sum_rate/9; % Since it is TDMA and averaged over nine time slots.

%% RAMA-OMA
sum_rate = 0.;
for i=1:9
    sum_rate = sum_rate + log2(1 + (Pm.*h(i)^2)/(NB*sigma2));
end

RAMA_OMA_rate = sum_rate/3; % Since it is TDMA for each group of RAMA and averaged over three time slots.
%% RA-NOMA

Rb = ones(1,NRF);  % R_bar = minimum requirements
p = zeros(1,NRF);

%%feasibility
f=0.0;
for i=1:NRF
    if i==1
        f = f + (2^Rb(i)-1).* NB .* sigma2/(h(1,i)^2);
    else
        f = f + 2^(sum(Rb(1:i-1))) * (2^Rb(i)-1).* NB .* sigma2/(h(1,i)^2);
    end
end

fprintf('is it feasible? %d\n', f<=Pm);
%%
Pm2 = Pm;
dum=0.0;
for i=1:NRF-1
    dum = dum + (2^Rb(i)-1)*NB* sigma2/(h(1,i)^2 * 2^(sum(Rb(i:NRF-1))));
end
p(NRF) = Pm2/(2^(sum(Rb(1:NRF-1)))) - dum;


for i=1:NRF-1
    
    dum=0.0;
    for j=1:i-1
        dum = dum + (2^Rb(i)-1)*(2^Rb(j)-1)*NB* sigma2/(h(1,i)^2 * 2^(sum(Rb(j:i))));
    end
    
    p(i) = (Pm2*(2^Rb(i)-1))/(2^(sum(Rb(1:i)))) + (NB* sigma2*(2^Rb(i)-1))/(h(1,i)^2 * 2^Rb(i)) - dum;
end

fprintf('Power allocation is correct? %d\n', sum(p)==Pm2);


dum = 0.0;
for i=1:NRF-1
    dum = dum + h(1,NRF)^2 * (2^Rb(i)-1)/(h(1,i)^2 * 2^(sum(Rb(i:NRF-1))));
end

RA_NOMA_rate = 3* (log2(1+ (h(1,NRF)^2 * p(NRF))/(sigma2)) + sum(Rb(1:NRF-1)));

end

