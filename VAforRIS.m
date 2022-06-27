clear all
clc


% Number of fading samples per branch
N = 1e5;

% Number analyzed SNRs (dB)
J = 15;

% alpha-F fading assumed to be i.i.d with parameters
alpha = 2.0;
mu = 2;
ms = 3;
gbdB = linspace(0,25,J);
gbar = 10.^(gbdB/10); % SNR Média (adimensional)
rc = sqrt(gbar);

% Treshold SNR
gth = 1; % dB

% Vector of K's - Number of Branches
K = [1 2 3];

% Outage Probability - May be analyzed for different Ls and SNR (dB)
Pout = zeros(J,length(K));
for u = 1:length(K)
    for j = 1:J
        hk = zeros(K(u),N);
        for k = 1:K(u)
            [u j k]
            % Fading per branch (Double alpha-F)
            [hk(k,:)] = gain(alpha,mu,ms,rc(j),N).*...
                        gain(alpha,mu,ms,rc(j),N);
        end
        % Fading - RIS
        H = abs(sum(hk,1));
        Pout(j,u) = sum(H.^2<10^(gth/10))/N;
        % Outage Probability curve
        hold on
        figure(2)
        semilogy(K(1:u),Pout(j,1:u),'r.-',...
                 'linewidth',1.5)
    end
end

% % Outage Probability curve
% figure(3)
% semilogy(K,Pout(1,:),'rx-',...
%          K,Pout(2,:),'gx-',...
%          K,Pout(3,:),'bx-',...
%          'linewidth',1.5)
% % axis([min(10*log10(gbar)) max(10*log10(gbar)) 5e-8 5e0])
% 
% 
% 
%%
% % PDF curve
% [fx,x] = histnorm(H.^2,1.5e2);
% figure(2)
% plot(x,fx,'r.-','linewidth',1.5)
% axis([min(x) max(x) 0 1.15*max(fx)])

OPA =@(L) APou(alpha,mu,ms,gbar,10^(gth/10),L);

% Outage Probability curve
figure(3)
semilogy(10*log10(gbar),Pout(:,1),'r.-',...
         10*log10(gbar),Pout(:,2),'r.-',...
         10*log10(gbar),Pout(:,3),'r.-',...
         10*log10(gbar),OPA(K(1)),...
         10*log10(gbar),OPA(K(2)),...
         10*log10(gbar),OPA(K(3)),...
         'linewidth',1.5)
axis([min(10*log10(gbar)) max(10*log10(gbar)) 5e-8 5e0])


