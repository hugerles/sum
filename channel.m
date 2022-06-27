function [ber] = channel(M,SNR_dB,N,alpha,mu,ms,Beta,delta,theta,L)

gammaBar = 10.^(0.1*SNR_dB);
var = 1/sqrt(2*gammaBar);

k = log2(M); % N�mero de bits por s�mbolo
if mod(N,log2(M)) ~= 0 % Corre��o no n�mero de bits
    N = N+log2(M)-mod(N,log2(M));
end
coded = randi([0 1],N,1);
dados = coded; % Gera��o da sequ�ncia bin�ria
dados_s2p = reshape(dados,N/k,k); % Convers�o S�rie-Paralelo
dados_dec = bi2de(dados_s2p); % Convers�o binario-decimal para futura
                              % correla��o coms os s�mbolos da
                              % constela��o

s = qammod(0:1:M-1,M,'gray','UnitAveragePower',true); % Gera��o dos s�mbolos da constela��o
                                                      % utilizando mapeamento Gray

Nc = length(dados_dec);
if Beta == 2
    n =    normrnd(0,var,[1 Nc])+...
        1j*normrnd(0,var,[1 Nc]);
elseif Beta == 1
    n =    randraw('laplace', [0, var*sqrt(1/2)], [1 Nc])+...
        1j*randraw('laplace', [0, var*sqrt(1/2)], [1 Nc]);
else
    [n,~] = noise(Beta,var,Nc);
end

g = GS(alpha,mu,ms,1,L,Nc,0);

gf = sqrt(g); % Normaliza��o da VA ganho do canal


r = s(dados_dec+1) + n./gf;

demod = qamdemod(r,M,'gray');

dados_demod = de2bi(demod,k);
dados_p2s = dados_demod(:);

[~,ber] = biterr(coded,dados_p2s);

end