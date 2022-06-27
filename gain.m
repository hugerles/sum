function [g] = gain(x,mu,ms,rc,N)

mn = 0;
mx = 5;

% Fading - Envelope gain
O = (ms-1)/mu;
C = x*(O)^ms*rc^(x*ms)/beta(mu,ms);
f =@(g) C*g.^(x*mu-1).*(g.^x+O*rc^x).^(-mu-ms);

vec = linspace(mn,mx,1e5);
while trapz(vec,f(vec)) < 0.995 %|| real(f(vec(end))) > 5e-4 || real(f(vec(end))) > real(f(vec(length(vec))-1))
    vec = linspace(mn,mx,1e3);
    mx = 5 + mx;
end
vec = linspace(mn,mx,1e3);

mg = real(max(f(vec)));
if mg > 10
    mg = pi;
end


g = [];
while length(g) < N
    x1 = random('unif',mn,mx,[1 N]);
    y1 = random('unif',0,mg,[1 N]);
    [~,xg] = find(y1 <= f(x1));
        g = cat(2,g,x1(xg));
end

g = g(1:N);

% [fx,x] = histnorm(g,1.5e2);
% figure(1)
% plot(x,fx,'rx',...
%      vec,f(vec),'b',...
%      'linewidth',1.5)
end