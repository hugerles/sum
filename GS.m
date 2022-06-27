function [gsum] = GS(alpha,mu,ms,gammaBar,L,N,Flag)
% Flag == 1 -> Envelope gain
% Flag ~= 1 -> Envelope SNR

g = zeros(L,N);
for l = 1:L
    if Flag == 1
        [g(l,:)] = gain(alpha(l),mu(l),ms(l),gammaBar,N);
    else
        [g(l,:)] = SNRSamples(alpha(l),mu(l),ms(l),gammaBar,N);
    end
end

gsum = sum(g,1);

end