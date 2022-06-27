function [OPA] = APou(x,mu,ms,ga,gth,L)
% Função Implementada Assumindo TODAS as VAs i.i.d.
% Parâmetros
% x = Alpha
% mu = mu
% ms = ms
% ga = SNR média

C = mu*x/2;

mui = x*mu/2;

Zeta = gamma(L*mui)/(gamma(1+L*mui)*gamma(2*L*mui));

Chi = (ga*((ms-1)/mu)^(2/x)).^-2;

Termo = gamma(2*mui)*gamma(ms+2*mui/x)*gamma(ms+2*mui/x)*(gth*Chi).^mui;


OPA = 0.5*Zeta*(Termo*x*C).^L/(gamma(mu)*gamma(ms))^(2*L);



% p = x.*mu/2;
% 
% Chi = gth*(ga*((ms-1)/mu)^(2/x)).^-2;
% 
% Zeta = gamma(L*p)/(gamma(2*L*p)*gamma(1+L*p));
% 
% Termo = Chi.^p*gamma(2*p)*gamma(ms+2*p/x)^2/(gamma(mu)*gamma(ms))^2;
% 
% OPA = 0.5*Zeta*(2*Termo).^L;

end