

%Assignment-3_VFI_by_Niranjan [2021, Oct] 
%%Question 4 
clear; 
clc

% Given Data 
global beta alpha delta A sigma 
beta = 0.99;                         % Subjective Discouting Factor 
alpha = 0.34;                        % parameter or capital share in production function 
delta = 0.025;                       % depreciation rate
A        = 1;                        % parameter 
sigma = 2 ;                          % 1/sigma  = elasticity of intemporal substitution 
Nk = 100 ;                           % Number of gridpoints 

Ks = ((A.*alpha)./((1/beta)-(1-delta))).^(1/(1-alpha));  % Steady state capital 

kmin = 0.005*Ks;                                %Minimum value of capital to start with effectively zero
kmax = 5*Ks  ;                                  % Maximal or upper bound on K grid 

k = linspace (kmin, kmax, Nk); 

% Convergence tolerance parameters 

prec = 0.0000001;           %precision for which we will apply convergence technique     
dist = 0;                   %distance as  another variable to check the tolerance 
iter =0;                    %defining a variable that we will use in loop 
enditeration = 0;
maxiteration =1000;


%Utility function given 
u= @(c) c^(1-sigma)/(1-sigma); 

% Initialize some vectors to save future calculations 

TV      = zeros(1,Nk);            %An array to store new Value Function or Maximum Value Function
G       = zeros(1,Nk);            %An array to store value of G temprorirly  
TF      = zeros(1,Nk);            %Similarly we create other three arrays 
Vext    = zeros(1,Nk);
V       = zeros(1,Nk);

while(enditeration==0)
    iter=iter+1;
    
    for i=1:Nk
        for j=1:Nk
            %compute consumption 
            c= max(k(i)^(alpha)+(1-delta)*k(i)-k(j),0);
            
            %compute value function 
            [Vext(i,j)]= u(c)+beta*V(j);
        end
    end
    
    for i=1:Nk
        %find the maximum value of Vext at K_j 
        [TV(i),G(i)]=max(Vext(i,:));
    end
    
    dist=max(abs(V-TV)); 
 
   %save TV in V array  
    V=TV;
    
    %print distance V(max) for each value of K_j
    fprintf('convergence of V(max)= %.8f\n',dist)
    if (dist <prec || iter>maxiteration)
        enditeration=1;   
    end
    
end

format long                         % Just to show how precise V(max) we can get 

for i=1:Nk
    policy(i) = k(G(i));
end 


% Question 6 Solution 

% Graph the solutions 

kmin = 0.1*Ks; %given k0
kbar=zeros(1,200); %capital grid
consumt=zeros(1,200); 
kbar(1)=kmin; %
t=linspace(1,200,200); %grid for time

for i=1:200                      %updating ct and kt for every t from 1 to 200
    [val,idx]=min(abs(kt-kbar(i))); %finding closest value in kt to simulated k grid 
    kbar(i+1)=g(idx);                       %storing value of policy function simulated k for next iteration 
    consumt(i)=cons(idx);                         %storing value of consumption for simulated k to be used in next iteration 
end
kbar(201) = []; 
%plotting graph
figure(1)
plot(t,consumt,'g',t,kbar,'b','LineWidth',2)
title('Consumption and Capital Stock Simulation')
xlabel('time') 
ylabel('ct and kt') 
legend("consumption(t)'",'capital k(t)')