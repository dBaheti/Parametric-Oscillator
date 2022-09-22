format long 

f = 10;

a = [0.01*f:0.01*f:3*f];
b = [0:0.01:2];

for i=1:length(a)
    for j=1:length(b)
        tspan = [0.0 2*pi*(a(i))^(-1)];
        [t1, y1] = ode45(@(t,y) hill_equation(t, y, a(i), b(j), f), tspan, [1.0, 0.0]);
        [t2, y2] = ode45(@(t,y) hill_equation(t, y, a(i), b(j), f), tspan, [0.0, 1.0]);
        
        [nrows1, ncols1] = size(y1);
        [nrows2, ncols2] = size(y2);
        
        M = [y1(nrows1,:)' , y2(nrows2,:)'];
        trM(j) = trace(M);
        eigv(j,:) = eig(M);
        
    end
    
    TrM(1+(i-1)*length(b):i*length(b)) = trM;
    Eigv(1+(i-1)*length(b):i*length(b),:)=eigv ;
    
    %this command makes A' = {a(i), a(i), ..........} and B' = {b(1), b(2),.......}
    [A,B] = meshgrid(a(i),b);
    
    %this command makes c = {a(i), a(i), a(i), ..........., b(1), b(2), b(3)......}
    c = cat(2,A',B');
    
    %this commmaand makes it a 2 column matrix which then becomes {{a(i), a(i), a(i),.....}',{b(1), b(2), b(3),.....}'}
    d = reshape(c,[],2);
    
    %this command iteratively keeps adding columns to itself 
    abcol(1+(i-1)*length(b):i*length(b),:)=d;
end

%final abcol = {{a(1), a(1), a(1)...... a(2), a(2), a(2),.......}',{b(1), b(2), b(3),....... b(1), b(2), b(3)......}'}

%acol = {a(1), a(1), a(1)......, a(2), a(2), a(2).....}'
acol=abcol(:,1);

%bcol = {b(1), b(2), b(3)......, b(1), b(2), b(3).....}'
bcol=abcol(:,2);

%for all values of a(i), b(j) that satisfy the stability condition, the
%Stab variable gets stored the values of [a(i) b(j)]
%Stab looks something like [{a(1) a(1) 0.... a(2) 0 0.....} {b(1) b(2) 0.... b(330) 0 0.....}]
for k=1:length(TrM)
    if abs(TrM(k))<2
        Stab(k,1:2) = [acol(k)*(f)^(-1) bcol(k)];
    else 
        Stab(k,1:2) = [0 0]; %the else statement is redundant but added for logical understanding
    end 
end 

%individual points are plotted. Every non 0 value is then plotted as a .
plot(Stab(:,1), Stab(:,2), '.')

