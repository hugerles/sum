function [gammaBar_dB, Pb] = BEP_analit(a, alpha, betaVar, mu, ms, b, bounds, N)
% TODO: doc func
% N - number of points

lambda = 1;

% compute Lambda0
uLambda0 = sqrt( gamma(3/betaVar) / gamma(1/betaVar) );

% generate independent variable vector
L = bounds(1);
U = bounds(2);
gammaBar = linspace(L, U, N);
%gammaBar = gpuArray.linspace(L, U, N);

gammaBar_dB = pow2db(gammaBar);

uPsi = ( mu^(2/alpha)*lambda) ./ ( uLambda0^2 * b * (ms-1)^(2/alpha) * gammaBar );

% precomputations
preGammaCoef = a / (betaVar * gamma(1/betaVar) * gamma(mu) * gamma(ms) );



% m = 1; n = 3; p = 3; q = 2;
an = [1, (betaVar - 1)/betaVar, 1-ms];  An = [2/betaVar, 2/betaVar, 2/alpha];   
ap = [];                                Ap = [];
bm = [mu];                              Bm = [2/alpha];
bq = [0];                               Bq = [2/betaVar];


%fox = zeros(1, N, 'gpuArray');
fox = zeros(1, N);
for i = 1:N
    fox(i) = real(HFox(an, An, ap, Ap, bm, Bm ,bq, Bq, uPsi(i)));
    %fox(i) = real(gpuArray(HFox(an, An, ap, Ap, bm, Bm ,bq, Bq, uPsi(i))));
end

% compute BEP
Pb = preGammaCoef .* fox;

% DEBUG
% semilogy(gammaBar_dB, Pb)
end
