function [gammaBar_dB, P] = BEP_asymptotic(a,alpha, betaVar, mu, ms, b, bounds, N)
% Function to implement the asymptotic expression 
% for the alpha-F fading and AWGGN distributions.
%
% INPUTS:
% alpha - positive power parameter
% beta - 
% mu - number of multipath clusters
% ms - shadowing parameter
% b -
% N - number of points
%
% OUTPUTS:
% P - points that form the asymptote

lambda = 1;

% generate independent variable vector
L = bounds(1);
U = bounds(2);
%gammaBar = gpuArray.linspace(L, U, N);
gammaBar = linspace(L, U, N);

gammaBar_dB = pow2db(gammaBar);

% compute Lambda0
uLambda0 = sqrt( gamma(3/betaVar) / gamma(1/betaVar) );

% precomputations
preBeta = a * gamma( (1+alpha*mu)/betaVar) / 2 / mu / beta(mu, ms) / gamma(1/betaVar);

%preBeta = alpha * a * gamma( (alpha*mu)/betaVar) * gamma( (1+alpha*mu)/betaVar) / 2 / betaVar / beta(mu, ms) / gamma(1/betaVar);

prePow = ( (mu*lambda^(alpha/2)) / ( (uLambda0*sqrt(b))^alpha * (ms-1)) )^mu;

% asymptotic BEP
P = preBeta * prePow .* gammaBar.^-(alpha*mu/2);

% debug
% semilogy(gammaBar_dB, P)

end
