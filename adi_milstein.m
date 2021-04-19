function [V,lossline,time] = SinglePath_MC_Err(lx,ly,lt,epsilon,alpha,psi,mu,X0,Y0,nu,rhox,Zx,Zy)
    
    epstar = 1e-3;

    Xmin = -10; Xmax = 10;  %X0 = 2;
    Ymin = -10;  Ymax = 10;  %Y0 = 2;

    T = 1.2;
    %mu = 0.0809;
    kappa = 0.2;
    %nu = 0.5;
    %rhox = 0.2;
    rhoy = 0.2;
    rhoxy = 0.45;
    %psi = 0.1;

    hx0 = 2; hy0 = 2;
    hx = hx0*2^-lx;
    hy = hy0*2^-ly;
    Jx = (Xmax-Xmin)/hx+1;
    Jy = (Ymax-Ymin)/hy+1;


    %k0 = 0.25*epstar;
    k0 = 0.25;
    k = k0*4^-lt;
    N = round(T/k);
    time=linspace(0,T,N);
    loss=zeros(1,numel(time));

    [~,Y,Ini] = initial_stovol(Xmin,Xmax,Ymin,Ymax,hx,hy,X0,Y0);

    [D1X,D2X,D2X2,D1Y,D2Y,D2Y2,DXY,D1X_2,D2X_2,D2X2_2] = matrixcoef_stovol(hx,hy,Xmin,Xmax,Ymin,Ymax);

    Y1 = kron(speye(Jx),diag(Y(:,1))); % expand in dim y
    Y2 = kron(diag(Y(:,1)),speye(Jx)); % expand in dim x
    
    x01 = ceil(-Xmin/hx)+1;    y01 = ceil(-Ymin/hy)+1;

%     randn('state',0)
%     ZX = randn(4^7*(T/k0),1);   ZY = randn(4^7*(T/k0),1);
%     ZY = rhoxy*ZX + sqrt(1-rhoxy^2)*ZY;
% 
%     Zx = reshape(ZX,4^(7-lt),N);  Zy = reshape(ZY,4^(7-lt),N);
%     Zx = sum(Zx,1)*2^(lt-7);    Zy = sum(Zy,1)*2^(lt-7);

%     randn('state',0)
%     ZX = randn(4^5*(T/k0)*10^4*epsilon,1);   ZY = randn(4^5*(T/k0)*10^4*epsilon,1);
%     ZY = rhoxy*ZX + sqrt(1-rhoxy^2)*ZY;
%     
%     Zx = reshape(ZX,4^(5-lt)*10^4*epsilon,N);   
%     Zy = reshape(ZY,4^(5-lt)*10^4*epsilon,N);
%     Zx = sum(Zx,1)*2^(lt-5)*0.01/sqrt(epsilon);    
%     Zy = sum(Zy,1)*2^(lt-5)*0.01/sqrt(epsilon);   

%     randn('state',0)
%     Zx = randn(1,N);   ZY = randn(1,N);
%     Zy = rhoxy*Zx + sqrt(1-rhoxy^2)*ZY;
    
    
    ZZZ = zeros(N+1,1);
    scalar1 = exp(-kappa/epsilon*k);
    scalar2 = nu*sqrt(2/epsilon*k)*rhoy;

    % tic
    for i = 1:N
        ZZZ(i+1) = scalar1*(ZZZ(i) + scalar2*Zy(i));
    end
    % toc

    ZZZ = ZZZ(1:end-1);

    V = Ini;
    U = Ini;

    t = 0;
    x_tick = Xmin:2:Xmax;
    y_tick = Ymin:2:Ymax;
    x_label = ((Xmin:2:Xmax)-Xmin)/hx;
    y_label = ((Ymin:2:Ymax)-Ymin)/hy;

%     figure;
%     surf(V,'edgecolor','none');
%     colormap parula;
%     rotate3d on;
%     plt = surf(V,'edgecolor','none');
%     colormap parula;
%     rotate3d on;
%     set(gca,'xtick',x_label,'xticklabel',x_tick,'ytick',y_label,'yticklabel',y_tick)
%     xlabel('$y$','fontsize',12,'Interpreter','latex')
%     ylabel('$x$','fontsize',12,'Interpreter','latex')
%     zlabel('$V(t,x,y)$','fontsize',12,'Interpreter','latex')
%     title('Initial density','fontsize',12,'Interpreter','latex')


    sigbar = exp(0.5*psi^2*nu^2/kappa);


    Ax0 = speye(Jx*Jy) + mu*k*D1X_2/hx/2;
    % Ay2 = (1-kappa/epsilon*k)*speye(Jx*Jy)-nu^2*(1-rhoy^2)/epsilon*k*D2Y/hy^2 - kappa/epsilon*k*Y1*D1Y/hy/2;
    Ay = speye(Jx*Jy)-nu^2*(1-rhoy^2)/epsilon*k*D2Y/hy^2 - kappa/epsilon*k*D1Y*Y1/hy/2;
    Ay_newk = speye(Jx*Jy) - nu^2*(1-rhoy^2)*k*D2Y/hy^2 - kappa*k*D1Y*Y1/hy/2;
    I = speye(Jx*Jy);
    Bx = -0.5*rhox*sqrt(k)*D1X_2/hx;
    Cx = 0.5*rhox^2*k*D2X2_2/hx^2;

    sigY = kron(diag(exp(psi*(Y(:,1)))),speye(Jx)); 
    % sigY = kron(diag(sigbar*ones(Jy,1)),speye(Jx)); 
%     sigY = sigbar;
    sigY2 = sigY.^2;
    sigYnew = sigY;
    sigYnew2 = sigY2;

    % Ax = Ax0 - 0.5*k*sigYnew2*D2X_2/hx^2;

    N2 = round(1/epsilon);
    for i = 1:N
        sigYnew = kron(diag(exp(psi*(Y(:,1) + ZZZ(i)))),speye(Jx)); 
        sigYnew2 = sigYnew.^2;

        B = I + sigY*Zx(i)*Bx + sigY2*(Zx(i)^2-1)*Cx;
        %B=I;
        
        if i==1
            Ax = Ax0 - 0.5*k*sigYnew2*D2X_2/hx^2; 
            %Ax = Ax0 - 0.5*k*sigYnew2*D2X_2/hx^2 + sigYnew*Zx(i)*Bx + sigYnew2*(Zx(i)^2-1)*Cx;
        else
            Ax = Ax0 - 0.5*k*sigYnew2*D2X_2/hx^2 - alpha*D1X_2*dL/hx/2;
            %Ax = Ax0 - 0.5*k*sigYnew2*D2X_2/hx^2 + sigYnew*Zx(i)*Bx + sigYnew2*(Zx(i)^2-1)*Cx - alpha*D1X_2*dL/hx/2;
        end
        
        V = V';
        V = V(:);
        V = B*V;
        V = Ax\V;
        V = reshape(V,Jx,Jy)';
        V = V(:);
        V = Ay\V; 
        V = reshape(V,Jy,Jx); 
        
        V(:,1:(x01-1)) = 0;
        V(:,x01) = V(:,x01)/2;
        V(1:(y01-1),:) = 0;
        V(y01,:) = V(y01,:)/2;
        
        % new
        L = 1-(sum(sum(V)))*hx*hy;
        loss(1,i)=L;
        if i == 1
            dL=loss(1,i);
        else
            dL=loss(1,i)-loss(1,i-1);
        end

    % 
        sigY = sigYnew;
        sigY2 = sigYnew2;

        t = t+k;
%         set(plt,'zdata',V')
%         title(['ADI: $l_x = ' num2str(lx) ', l_y = ' num2str(ly) ', t = $' num2str(t)],...
%             'fontsize',12,'Interpreter','latex')
%         drawnow

    end
    
    V=sum(sum(V))*hx*hy;
    lossline=loss(1,:);
%     fprintf('lx=%d,ly=%d,lt=%d,eps = %.4f,V=%8f\n',lx,ly,lt,epsilon,V)

    
%     
%     set(plt,'zdata',V')
%     title(['ADI: $l_x = ' num2str(lx) ', l_y = ' num2str(ly) ', \alpha = $' num2str(alpha)],...
%         'fontsize',12,'Interpreter','latex')
%     drawnow
% 
%     figure;
%     surf(V-U);
% 
%     Xgrid = linspace(Xmin,Xmax,Jx)';
%     Ygrid = linspace(Ymin,Ymax,Jy)';
%     xx = Xgrid - rhox*sigbar*sum(Zx)*sqrt(k);
%     fx = exp(-(xx-X0-mu*T).^2/(2*T*(sigbar^2-rhox^2)*sigbar^2))/(sigbar*sqrt(2*pi*(sigbar^2-rhox^2)*T));
% 
%     muy = Y0*exp(-kappa*T/epsilon);
%     sig2y = nu^2/kappa*(1-rhoy^2)*(1-exp(-2*kappa*T/epsilon));
%     % muy = 0;
%     fy = exp(-0.5*(Ygrid-muy).^2/sig2y)/sqrt(2*pi*sig2y);
% 
%     [fxx,fyy] = meshgrid(fx,fy); 
%     uu = (fxx.*fyy);
% 
%     % figure;
%     % surf(uu)
%     figure;
%     surf(uu-V);
%     set(gca,'xtick',x_label,'xticklabel',x_tick,'ytick',y_label,'yticklabel',y_tick)
%     xlabel('$y$','fontsize',20,'Interpreter','latex')
%     ylabel('$x$','fontsize',20,'Interpreter','latex')
%     zlabel('$v(T,x,y)-V(T,x,y)$','fontsize',20,'Interpreter','latex')
%     title(['$v(T,x,y)-V(T,x,y): \epsilon = ' num2str(epsilon) ' $'],'fontsize',20,'Interpreter','latex')
% 
%     L2_Err = sqrt(sum(sum((uu-V).^2))*hx*hy);
%     fprintf('lx=%d,ly=%d,lt=%d,eps = %.4f,err=%8f\n',lx,ly,lt,epsilon,L2_Err)

end


