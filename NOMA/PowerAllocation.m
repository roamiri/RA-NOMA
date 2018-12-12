function [rate, powers] = PowerAllocation(Pm, sigma2, h, test)
NRF = 3; % Number of RF Chains
NB = 3; % Number of beams 
% Pm = 300 ; % Watt 
% sigma2 = 1e-1;
%% RA-NOMA

Rb = 0.2*ones(1,NRF);  % R_bar = minimum requirements
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
alpha = 1/NB;

dum=0.0;
for i=1:NRF-1
    dum = dum + (2^Rb(i)-1)* sigma2/(alpha* h(1,i)^2 * 2^(sum(Rb(i:NRF-1))));
end
p(NRF) = Pm/(2^(sum(Rb(1:NRF-1)))) - dum;


for m=1:NRF-1
    
    dum=0.0;
    for i=1:m-1
        dum = dum + (2^Rb(m)-1)*(2^Rb(i)-1)*sigma2/(alpha* h(1,i)^2 * 2^(sum(Rb(i:m))));
    end
    
    p(m) = (Pm*(2^Rb(m)-1))/(2^(sum(Rb(1:m)))) + (sigma2*(2^Rb(m)-1))/(alpha*h(1,m)^2 * 2^Rb(m)) - dum;
end

fprintf('Power allocation is correct? %d\n', (sum(p)-Pm)<0.01);


dum = 0.0;
for i=1:NRF-1
    dum = dum + h(1,NRF)^2 * (2^Rb(i)-1)/(h(1,i)^2 * 2^(sum(Rb(i:NRF-1))));
end

RA_NOMA_rate = 3* (log2(1+ (h(1,NRF)^2 * alpha* p(NRF))/(sigma2)) + sum(Rb(1:NRF-1)));

if test
    sum_rate = 0.0;
    
    for i=1:NRF
        dum = 0.0;
        for j=i+1:NRF
            dum = dum + alpha*p(j);
        end
        sum_rate = sum_rate + log2(1 + (alpha*p(i)*h(1,i)^2)/(dum * h(1,i)^2 + sigma2));
    end
    fprintf('Is sum rate correct? %d\n', (3*sum_rate-RA_NOMA_rate)<0.01);
end

% rate = [OMA_rate, RAMA_OMA_rate, RA_NOMA_rate];
   rate = RA_NOMA_rate;
   powers = p;
end

