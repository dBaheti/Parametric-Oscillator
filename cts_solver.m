format long;
hold on;

f=1;
a=1.944;
b=0.8;

tspan = [2*0*pi/a:0.005:2*2000*pi/a];

y1_sh=ode4(@(t,y) nl_damped_hill_equation(t,y,a,b,f),tspan,[1,0,0.0]);

plot(y1_sh(:,1),y1_sh(:,2),'b');
