function[T_total_r,P1_r,T_total_PAmax,P1_PAmax,T_total_PA,P1_PA]=main(Data,P,k1)
    %% Random data generation
    %transmission power is in mW
    pD2Dmax=50;
    pMECmax=50;
    %g0 is in dB
    g0=-40;
    %distance between user and MEC and D2D in metre
    dD2D=50;
    dMEC=50;
    %sigma value(constants)
    sigma=4;
    b=1 * power(10,6);  % MHz
    N0=-174; % dBm/Hz
    % frequecies of base station and D2D device(GHz)
    Fmec=3 * power(10,9);
    Fue=1 * power(10,9);
    %Number of subtasks
    N=size(Data,1);
    %Delta constants of energy consumptions(Watts)
    Dmec=2.8788 * power(10,-8);
    Dd2d=1.6541 * power(10,-9);
    % k1 and k2 value
    %k1=15000;
    k2=k1/250;
    
    %% Using Pmax powerconstant
    Total_res=0;
    for i=1:N
        Total_res=Total_res+(Data(i,1)*Data(i,2));
    end
    
    
    %% Random task allocation
    gamma_rand=[1;2;2;0;2;2;1;1;1;2;1;0;2;1;0;1;2;1;1;2;1;0;1;2;0;1;2;1;2;1]
    %gamma_rand=randi([0,2],N,1);
    [L_r,K_r,M_r]=Fetch_subtasks(Data,gamma_rand);
    [pue_r,pD2D_r,pMEC_r]=P_separation(P,gamma_rand);
    
    Tlsum_r=TLsum(L_r,Fue)
    TD2Dsum_r=Tmax(K_r,Fue,pD2Dmax,dD2D)
    %TD2Dsum_r_vec=Tmax(K,Fue,pD2D_r,dD2D);
    TMECsum_r=Tmax(M_r,Fmec,pMECmax,dMEC)
    %TMECsum_r_vec=Tmax(M,Fmec,pMEC_r,dMEC);
    Energy_tran_r=Etrasum(K_r,M_r,dD2D,dMEC,pD2Dmax,pMECmax)
    %Energy_tran_r_vec=Etrasum(K,M,dD2D,dMEC,pD2D_r,pMEC_r);
    Energy_exe_r=Eexesum(Dd2d,Dmec,L_r,K_r,M_r)
    if(Tlsum_r-TD2Dsum_r>0.0)
        if(Tlsum_r-TMECsum_r>0.0)
            temp=Tlsum_r;
        else
            temp=TMECsum_r;
        end
    else
        if(TD2Dsum_r-TMECsum_r>0.0)
            temp=TD2Dsum_r;
        else
            temp=TMECsum_r;
        end
    end
    %T_total_r=Tlsum_r+TD2Dsum_r+TMECsum_r;
    T_total_r=temp;
    P1_r=temp+k1*(Energy_tran_r)+k2*(Energy_exe_r);

    %% task allocation using knapsack algorithm and one constant pMax value
    
    RD2D=Rate_trans(pD2Dmax,dD2D);
    RMEC=Rate_trans(pMECmax,dMEC);
    VL=floor(Total_res/(1+((1/Fue)/((1/Fue)+(1/(RD2D*mean(Data(:,2))))))+((1/Fue)/((1/Fmec)+(1/(RMEC*mean(Data(:,2))))))));
    VK=floor(VL*(1+(Fue/(RD2D*mean(Data(:,2))))));
    [gamma]=knapsack(VL,VK,Data)
    [L,K,M]=Fetch_subtasks(Data,gamma);
    Tlsum_m=TLsum(L,Fue)
    TD2Dsum_m=Tmax(K,Fue,pD2Dmax,dD2D)
    TMECsum_m=Tmax(M,Fmec,pMECmax,dMEC)
    Energy_tran_m=Etrasum(K,M,dD2D,dMEC,pD2Dmax,pMECmax)
    Energy_exe_m=Eexesum(Dd2d,Dmec,L,K,M)
    if(Tlsum_m-TD2Dsum_m>0.0)
        if(Tlsum_m-TMECsum_m>0.0)
            temp=Tlsum_m;
        else
            temp=TMECsum_m;
        end
    else
        if(TD2Dsum_m-TMECsum_m>0.0)
            temp=TD2Dsum_m;
        else
            temp=TMECsum_m;
        end
    end
    %T_total_PAmax=Tlsum_m+TD2Dsum_m+TMECsum_m;
    T_total_PAmax=temp;
    P1_PAmax=temp+k1*(Energy_tran_m)+k2*(Energy_exe_m);
    
    
    %% task allocation using optimisation algorithm and power transmission vector P
    RD2D_opt=Rate_trans(P,dD2D);
    RMEC_opt=Rate_trans(P,dMEC);
    VL_opt=floor(Total_res/(1+((1/Fue)/((1/Fue)+(1/(mean(RD2D_opt)*mean(Data(:,2))))))+((1/Fue)/((1/Fmec)+(1/(mean(RMEC_opt)*mean(Data(:,2))))))));
    VK_opt=floor(VL_opt*(1+(Fue/(mean(RD2D_opt)*mean(Data(:,2))))));
    [gamma]=knapsack(VL_opt,VK_opt,Data);
    [L,K,M]=Fetch_subtasks(Data,gamma);
    Vold=V_cal(L,K,M,gamma,P,dD2D,dMEC,Fue,Fmec,Dd2d,Dmec,k1,k2);
    Vnew=Vold+10;
    Imax=50;
    i=0;
    u=power(10,-5);
    while Vnew-Vold>u &&  i<25
        i=i+1;
        Vold=Vnew;
        RD2D_opt=Rate_trans(P,dD2D);
        RMEC_opt=Rate_trans(P,dMEC);
        VL_opt=floor(Total_res/(1+((1/Fue)/((1/Fue)+(1/(mean(RD2D_opt)*mean(Data(:,2))))))+((1/Fue)/((1/Fmec)+(1/(mean(RMEC_opt)*mean(Data(:,2))))))));
        VK_opt=floor(VL_opt*(1+(Fue/(mean(RD2D_opt)*mean(Data(:,2))))));
        [gamma]=knapsack(VL_opt,VK_opt,Data);
        [L,K,M]=Fetch_subtasks(Data,gamma);
    
        p2=@(P)Compute_P2(L,K,M,gamma,P,g0,N0,dD2D,dMEC,sigma,Fue,Fmec,Dd2d,Dmec,b,k1,k2);
        A = []; c = []; 
        Aeq = []; 
        beq = [];
        lb = 40*ones(size(P)); % Lower bounds on P
        ub = 50*ones(size(P));  % Upper bounds on P
        options = optimoptions('fmincon','Display','none');
        P = fmincon(p2,P,A,c,Aeq,beq,lb,ub,[],options);
        [pue,pD2D,pMEC]=P_separation(P,gamma);
        Vnew=V_cal(L,K,M,gamma,P,dD2D,dMEC,Fue,Fmec,Dd2d,Dmec,k1,k2);
    end
    RD2D_opt=Rate_trans(P,dD2D);
    RMEC_opt=Rate_trans(P,dMEC);
    VL_opt=floor(Total_res/(1+((1/Fue)/((1/Fue)+(1/(mean(RD2D_opt)*mean(Data(:,2))))))+((1/Fue)/((1/Fmec)+(1/(mean(RMEC_opt)*mean(Data(:,2))))))));
    VK_opt=floor(VL_opt*(1+(Fue/(mean(RD2D_opt)*mean(Data(:,2))))));
    [gamma]=knapsack(VL_opt,VK_opt,Data)
    [L,K,M]=Fetch_subtasks(Data,gamma);
    [pue,pD2D,pMEC]=P_separation(P,gamma);
    Tlsum=TLsum(L,Fue)
    TD2Dsum=Tmax(K,Fue,pD2D,dD2D)
    TMECsum=Tmax(M,Fmec,pMEC,dMEC)
    Energy_tran=Etrasum(K,M,dD2D,dMEC,pD2D,pMEC)
    Energy_exe=Eexesum(Dd2d,Dmec,L,K,M)
    if(Tlsum-TD2Dsum>0.0)
        if(Tlsum-TMECsum>0.0)
            temp=Tlsum;
        else
            temp=TMECsum;
        end
    else
        if(TD2Dsum-TMECsum>0.0)
            temp=TD2Dsum;
        else
            temp=TMECsum;
        end
    end
    %T_total_PA=Tlsum+TD2Dsum+TMECsum;
    T_total_PA=temp;
    P1_PA=temp+k1*(Energy_tran)+k2*(Energy_exe);
end
