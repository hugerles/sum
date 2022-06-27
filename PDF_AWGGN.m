function [eta, f] = PDF_AWGGN(beta, var, N,ETA_MAX_VAL)
% Function to implement the PDF of AWGGN noise distribution with zero mean
% and variance N0/2.
% 
% INPUTS:
% beta - shaping parameter (2 -> Gaussian, 1 -> Laplacian, 1/3 -> impulsive)
% var - distribution's variance
% N - Number of points
%
% OUTPUTS:
% f - PDF's points

N0 = 2*var;
lambda0 = sqrt( gamma(3/beta) / gamma(1/beta) );
lambda = 2*lambda0 / N0;

% Generate eta vector
% ETA_MAX_VAL = 10;
eta = linspace(-ETA_MAX_VAL, ETA_MAX_VAL, N);

% precomputation
preComp = beta * lambda / ( 2*gamma(1/beta) );

% alpha-F PDF
f = preComp * exp( - lambda^beta .* abs(eta).^beta );

% DEBUG
% area = trapz(eta, f)
% figure() 
% plot(eta, f)

end
