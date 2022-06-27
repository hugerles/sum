clc
% clear all

M = 2; % Ordem da constelação M-QAM
N = 1e6; % Número de bits transmitidos
SNR_dB = linspace(0,20,15);
alpha = [2.0 3.0];
mu = [1.0 1.0];
ms = [3.0 10.2];
Beta = 2;
delta = 1;
theta = 1;
L = 2;

tic


ber = zeros(length(SNR_dB),1,1,1); % ALpha -> Mu -> Ms
v = 1;

for s = 1:1 % Ms
    for x = 1:1 % Alpha
        for m = 1:1 % Mu
            for i = 1:length(SNR_dB)
                mi = [s x m i]
                [ber(i,m,x,s)] = channel(M,SNR_dB(i),N,alpha(x,:),mu(m,:),ms(s,:),Beta,delta,theta,L);
                figure(1)
                semilogy(SNR_dB,ber(:,m,x,s),'-'); hold on
                axis([min(SNR_dB) max(SNR_dB) 1e-5 1e-1])
                grid on
            end
        end
    end
end
hold off
toc


%%
% alpha = [2 2];
% mu = [1.0 1.0]; [1.3 1.3]; [1.7 1.7]
% ms = [2.2 2.2];

% alpha = [3.5 3.5];
% mu = [1.0 1.0]; [1.3 1.3]; [1.7 1.7]
% ms = [2.2 2.2];

% alpha = [8.5 8.5];
% mu = [1.0 1.0]; [1.3 1.3]; [1.7 1.7]
% ms = [2.2 2.2];

figure(1)
semilogy(SNR_dB,ber(:,1,1,1),'-',...
         SNR_dB,ber(:,2,1,1),'-',...
         SNR_dB,ber(:,3,1,1),'-',...
         SNR_dB,ber(:,1,2,1),'--',...
         SNR_dB,ber(:,2,2,1),'--',...
         SNR_dB,ber(:,3,2,1),'--',...
         SNR_dB,ber(:,1,3,1),':',...
         SNR_dB,ber(:,2,3,1),':',...
         SNR_dB,ber(:,3,3,1),':')
axis([min(SNR_dB) max(SNR_dB) 1e-5 1e-1])

% save RausleyHighSamples
%%

%BPSK
a = 1;
b = 2;

L = 1;
U = db2pow(max(SNR_dB));
bounds = [L U]; % 0 - 30 dB
N = 1e4;        % Number of points

betaVar = [1];      % AWGN
colorstring = 'bgrm';

[gammaBar_dB, Pb] = BEP_analit(a,alpha(1),betaVar,mu(1),ms(1),b,bounds,N);
[gammaBar_dB, P] = BEP_asymptotic(a,alpha(1),betaVar,mu(1),ms(1),b,bounds,N);
    
%%

figure(2)
semilogy(gammaBar_dB,Pb,'r',...
         gammaBar_dB,P,'r--',...
         SNR_dB,ber(:,1),'b-x','linewidth',1.2)
axis([min(SNR_dB) 20 1e-5 1e0])
grid minor

%%

figure(3)
plot(gamma_var,f_gamma)

