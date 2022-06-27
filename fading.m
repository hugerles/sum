function [g] = fading(alfa,mu,ms,gammaBar,N)

range = 5;
% Fading
lambda = 1;
preBeta = alfa/(2*beta(mu,ms));
prePow = (((ms-1)*(gammaBar^(alfa/2)))/(mu*lambda^(alfa/2)))^ms;
f =@(g) preBeta*prePow*g.^(alfa*mu/2 -1).*...
            (g.^(alfa/2)+(((ms-1)*gammaBar^(alfa/2))/...
            (mu*lambda^(alfa/2)))).^-(mu+ms);

fg = f(0:1e-3:range);
mg = real(max(fg));
[~,id] = find(mg*ones(size(fg)) == real(fg));
if mg > 10
    mg = pi;
end
while min(real(fg(id+1:end))) > 1e-3
    fg = f(range:1e-3:5*range);
    range = 2*range;
end

g = [];
while length(g) < N
    x1 = random('unif',0,range,[1 N]);
    y1 = random('unif',0,mg,[1 N]);
    [~,xg] = find(y1 <= f(x1));
        g = cat(2,g,x1(xg));
end


g = g(1:N);

[fx,x] = histnorm(g,1.5e2);


figure(2)
plot(x,fx,'rx',...
     0:1e-3:range,f(0:1e-3:range),'b',...
     'linewidth',1.5)
end