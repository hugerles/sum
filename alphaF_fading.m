function [gamma, f] = alphaF_fading(alpha, mu, ms, gammaBar, N,U)
% Function to implement the PDF of the SNR for the alpha-F fading distribution.
%
% INPUTS:
% alpha - positive power parameter
% mu - number of multipath clusters
% ms - shadowing parameter
% gammaBar - mean SNR
%
% OUTPUTS:
% gamma - vector containing independent variable
% f - PDF's points

L = 0;
% U = 2;
gamma = linspace(L, U, N);

% compute lambda
% lambda = ( (ms-1)/mu)^(2/alpha) * ...
%         ( (gamma(mu + 2/alpha)*gamma(ms-2/alpha)) / (gamma(mu)*gamma(ms)) )
lambda = 1;

% precomputation
preBeta = alpha / ( 2*beta(mu,ms) );
prePow = ( ( (ms-1)*(gammaBar^(alpha/2) ) ) / ( mu*lambda^(alpha/2) ) )^ms;

% alpha-F PDF
f = preBeta * prePow * gamma.^(alpha*mu/2 -1) .*...
    ( gamma.^(alpha/2) + ( ((ms-1)*gammaBar^(alpha/2)) / (mu*lambda^(alpha/2)) ) ).^-(mu+ms);

end
