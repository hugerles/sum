clear all
clc

% Parâmetros do sistema
L = [1 2]; % Número de ramos
alpha = [2.5 2.5]; % Comprimento L
mu = [2.5 2.5]; % Comprimento L
ms = [1.7 1.7;3 3;50 50]; % Comprimento L
N = 1e6; % Número de amostras

% SNRs -- Amostragem dos valores observáveis
GBdB = linspace(0,20,15); % SNR em dB
gammaBar = 10.^(0.1*GBdB); % SNR linear

% Limiares
GthdB = 5;
gth = 10^(0.1*GthdB); % Limiar de SNR

% Inicialização dos vetores -- Prealocation
Pout = zeros(length(gammaBar),length(L),3);
gsum = zeros(1,N);

tic

for m = 1:3 % ms
    for l = 1:length(L)
        for i = 1:length(gammaBar)
            [m l i]
            gsum = GS(alpha,mu,ms(m,:),gammaBar(i),L(l),N,0);
            [flagOP,~] = find(gsum <= gth);
            Pout(i,l,m) = sum(flagOP)/N;
            figure(1)
            semilogy(GBdB,Pout(:,l,m),'-x'); hold on
            axis([min(GBdB) max(GBdB) 1e-5 1e0])
        end
    end
end
hold off
toc

%%

% save CoisasQueHugerlesPediu

% L = 1 2 3
% gth = 5dB
% ms = 1.5 10 50 
% mu = 2.5 alpha = 2.5

figure(2)
semilogy(GBdB,Pout(:,1,1),'-x',...
         GBdB,Pout(:,1,2),'-d',...
         GBdB,Pout(:,1,3),'-h',...
         GBdB,Pout(:,2,1),'--x',...
         GBdB,Pout(:,2,2),'--d',...
         GBdB,Pout(:,2,3),'--h')
axis([min(GBdB) max(GBdB) 1e-5 1e0])
grid on




%%
figure(2)
semilogy(GBdB,Cout(:),'-d',...
         GBdB,Cout(:),'-x',...
         GBdB,Cout(:),'-o')

