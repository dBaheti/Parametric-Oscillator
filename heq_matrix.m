format long 

hold on;
f = 1;
b = [0.001:0.00:0.5];
a = [0.251*f:0.001*f:2.001*f];
max_h=zeros(1,length(b));
max_sh=zeros(1,length(b));
y_h=zeros(1,length(b));
y_sh=zeros(1,length(b));
i_h=zeros(1,length(b));
i_sh=zeros(1,length(b));

for k=1:50
    B(k,k+1) = 1;
    B(k+1,k) = 1;
end

for c1=1:length(b)
    for i=1:length(a)
        for j=1:51
            A_h(j,j) = 2*(-((j-26)^(2))*((a(i))^(2)) + 2*(b(c1))*1i*(j-26)*a(i) + f^2)/f^2;
            A_sh(j,j) = 2*(-((j-25.5)^(2))*((a(i))^(2)) + 2*(b(c1))*1i*(j-25.5)*a(i) + f^2)/f^2;
        end
        
        C_h = A_h^(-1)*B;
        C_sh = A_sh^(-1)*B;
        
        ev_h=eig(C_h);
        ev_sh=eig(C_sh);
        for l=1:51
            im_h=imag(ev_h(l));
            rm_h=real(ev_h(l));
            im_sh=imag(ev_sh(l));
            rm_sh=real(ev_sh(l));
            
            if rm_h>max_h(1,c1)
                max_h(1,c1) = rm_h;
                i_h(1, c1) = i;
            end
            
            if rm_sh>max_sh(1,c1)
                max_sh(1,c1) = rm_sh;
                i_sh(1, c1) = i;
            end
            
            %if abs(im_h)<0.001 && 1/rm_h>0 && 1/rm_h<10
                %y_h(i,l)=1/rm_h;
                %plot(a(i)/f,y_h(i,l), '.b')
            %end
            %if abs(im_sh)<0.001 && 1/rm_sh>0 && 1/rm_sh<10
                %y_sh(i,l)=1/rm_sh;
                %plot(a(i)/f,y_sh(i,l), '.r')
            %end
        end
    end
end
ylim([0.7 2.1])

for c2=1:length(b)
    y_h(1,c2) = 1/max_h(1,c2);
    y_sh(1,c2) = 1/max_sh(1,c2);
end

%plot(b(:),y_h(1,:),'.b')
%plot(b(:),y_sh(1,:),'.r')
plot(b(:),a(i_h(1,:)),'.b')
plot(b(:),a(i_sh(1,:)),'.r')