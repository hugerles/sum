function [n,g] = NoiseFading(alfa,mu,ms,gammaBar,Beta,var,N)
% Função para geração das variáveis aleatórias da envoltória
% no modelo de desvanecimento Eta-Mu

% Fading
lambda = 1;
preBeta = alfa/(2*beta(mu,ms));
prePow = (((ms-1)*(gammaBar^(alfa/2)))/(mu*lambda^(alfa/2)))^ms;
fading =@(g) preBeta*prePow*g.^(alfa*mu/2 -1).*...
            (g.^(alfa/2)+(((ms-1)*gammaBar^(alfa/2))/...
            (mu*lambda^(alfa/2)))).^-(mu+ms);

fg = fading(0:0.001:10);
mg = real(max(fg));
if mg > 10
    mg = pi;
end

m2 = (((ms-1)*gammaBar^(0.5*alfa)/mu).^(4/alfa))*...
     beta(mu+4/alfa,ms-4/alfa)/beta(mu,ms);

% Noise
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

g = [];
ni = [];
nq = [];
while length(g) < N || length(ni) < N || length(nq) < N
    x1 = random('unif',0,5*m2,[1 N]);
    y1 = random('unif',0,mg,[1 N]);
    [~,xg] = find(y1 <= fading(x1));
        g = cat(2,g,x1(xg));
    x2 = random('unif',-20,20,[1 N]);
    y2 = random('unif',0,mn,[1 N]);
    [~,xn2] = find(y2 <= noise(x2));
        ni = cat(2,ni,x2(xn2));
    x3 = random('unif',-20,20,[1 N]);
    y3 = random('unif',0,mn,[1 N]);
    [~,xn3] = find(y3 <= noise(x3));
        nq = cat(2,nq,x3(xn3));
end

g = g(1:N);
n = ni(1:N)+1j*nq(1:N);

end