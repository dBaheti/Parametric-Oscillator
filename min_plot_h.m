format long 

hold on;
f = 1;
b = 0.2;
a = [0.251*f:0.001*f:2.001*f];
max_h=0;
max_sh=0;
y_h=0;
y_sh=0;
i_h=0;
i_sh=0;

for k=1:50
    B(k,k+1) = 1;
    B(k+1,k) = 1;
end

for i=1:length(a)
    for j=1:51
        A_h(j,j) = 2*(-((j-26)^(2))*((a(i))^(2)) + 2*b*1i*(j-26)*a(i) + f^2)/f^2;
        A_sh(j,j) = 2*(-((j-25.5)^(2))*((a(i))^(2)) + 2*b*1i*(j-25.5)*a(i) + f^2)/f^2;
    end
        
    C_h = A_h\B;
    C_sh = A_sh\B;
        
    ev_h=eig(C_h);
    ev_sh=eig(C_sh);
        for l=1:51
            im_h=imag(ev_h(l));
            rm_h=real(ev_h(l));
            im_sh=imag(ev_sh(l));
            rm_sh=real(ev_sh(l));
            
            if rm_h>max_h
                max_h = rm_h;
                i_h = i;
                [V_h,D_h]=eig(C_h);
            end
            
            if rm_sh>max_sh
                max_sh = rm_sh;
                i_sh = i;
                [V_sh,D_sh]=eig(C_sh);
            end
        end
end

ar_h=1/max_h;
ar_sh=1/max_sh;

display(a(i_sh));
display(ar_sh);
%display(a(i_h));
%display(ar_h);

tspan_h = 0.0:0.005:2*100*pi/a(i_h);
tspan_sh = [2*0*pi/a(i_sh) 2*2000*pi/a(i_sh)];
[t1_h, y1_h] = ode45(@(t,y) nl_damped_hill_equation(t, y, a(i_h), ar_h, f), tspan_h, [pi/80, 0.0, 0.0]);
[t2_h, y2_h] = ode45(@(t,y) nl_damped_hill_equation(t, y, a(i_h), ar_h, f), tspan_h, [0.0, 0.01, 0.0]);
[t3_h, y3_h] = ode45(@(t,y) nl_damped_hill_equation(t, y, a(i_h), ar_h, f), tspan_h, [0.0, 0.0, 1.0]);
[t1_sh, y1_sh] = ode45(@(t,y) nl_damped_hill_equation(t, y, a(i_sh), ar_h, 1), tspan_sh, [pi/80 , 0.0, 0.0]);
[t2_sh, y2_sh] = ode45(@(t,y) nl_damped_hill_equation(t, y, a(i_sh), ar_sh, 1), tspan_sh, [0.0, 1.0, 0.0]);
[t3_sh, y3_sh] = ode45(@(t,y) nl_damped_hill_equation(t, y, a(i_sh), ar_sh, 1), tspan_sh, [0.0, 0.0, 1.0]);

%plot(t1_h(:),y1_h(:,1),'b');
%plot(t2_h(:),y2_h(:,1),'r');
%plot(y1_sh(:,1),y1_sh(:,2),'b');
%plot(t2_sh(:),y2_sh(:,1),'r');