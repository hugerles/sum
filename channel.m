function [ber] = channel(M,SNR_dB,N,alpha,mu,ms,Beta,delta,theta,L)

gammaBar = 10.^(0.1*SNR_dB);
var = 1/sqrt(2*gammaBar);

k = log2(M); % Número de bits por símbolo
if mod(N,log2(M)) ~= 0 % Correção no número de bits
    N = N+log2(M)-mod(N,log2(M));
end
coded = randi([0 1],N,1);
dados = coded; % Geração da sequência binária
dados_s2p = reshape(dados,N/k,k); % Conversão Série-Paralelo
dados_dec = bi2de(dados_s2p); % Conversão binario-decimal para futura
                              % correlação coms os símbolos da
                              % constelação

s = qammod(0:1:M-1,M,'gray','UnitAveragePower',true); % Geração dos símbolos da constelação
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

gf = sqrt(g); % Normalização da VA ganho do canal


r = s(dados_dec+1) + n./gf;

demod = qamdemod(r,M,'gray');

dados_demod = de2bi(demod,k);
dados_p2s = dados_demod(:);

[~,ber] = biterr(coded,dados_p2s);

end