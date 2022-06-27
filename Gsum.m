clear all
clc

alpha = 2.0;
mu = 2;
ms = 5.0;
N = 1e7;
Beta = 1;
var = 1;
gammaBar = 10;

L = 2;

g = zeros(L,N);
for l = 1:L
    [g(l,:)] = fading(alpha,mu,ms,gammaBar,Beta,var,N).*...
               fading(alpha,mu,ms,gammaBar,Beta,var,N);
end

G = sum(g,1);

size(G);
%%
clc

delta = 1;
theta = 120;

gsum = delta*sum((g.^theta),1).^(1/theta);

sum(isinf(gsum))

% find(isinf(gsum))
% 
% g(:,79587)
% vpa(g(:,79587).^theta)


gsum(isinf(gsum)) = [];

gsum = double(gsum);

[fx,x] = histnorm(gsum,1.5e3);
figure(2)
plot(x,fx,'r-','linewidth',1.5)


%%


% load('SNR_PDF.mat')

[fx,x] = histnorm(gsum,1.5e3);
figure(1)
plot(gamma_var,f_gamma,'b',...
     x,fx,'r.-','linewidth',1.5)
axis([0 100 0 1.15*max(fx)])



