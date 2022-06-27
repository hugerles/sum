function [n] = noise(Beta,var,N)

%Noise
N0 = 2*var;
lambda0 = sqrt(gamma(3/Beta)/gamma(1/Beta));
lambda = 2*lambda0/N0;
preComp = Beta*lambda/(2*gamma(1/Beta));
noise =@(n) preComp*exp(-lambda^Beta.* abs(n).^Beta);
fn = noise(0:0.001:10);
mn = real(max(fn));
if mn > inf
    mn = 100;
end

ni = [];
nq = [];
while length(ni) < N || length(nq) < N
    x2 = random('unif',-20,20,[1 N]);
    y2 = random('unif',0,mn,[1 N]);
    [~,xn2] = find(y2 <= noise(x2));
        ni = cat(2,ni,x2(xn2));
    x3 = random('unif',-20,20,[1 N]);
    y3 = random('unif',0,mn,[1 N]);
    [~,xn3] = find(y3 <= noise(x3));
        nq = cat(2,nq,x3(xn3));
end

n = ni(1:N)+1j*nq(1:N);

end