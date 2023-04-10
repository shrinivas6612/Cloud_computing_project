function[sum]=Tmax(K,F,p,d)
    % K is the substask array
    % F is the frequency
    % p is transmission power constant
    % d is the distance(in m)
    Ttran=0;
    TD2D=0;
    n=size(K,1);
    R=Rate_trans(p,d);
    m=size(R,1);
    if m==1
        for i=1:n
            Ttran=Ttran+(K(i,1)/R);
        end
    else
        for i=1:n
            Ttran=Ttran+(K(i,1)/R(i));
        end
    end
    for i=1:n
        TD2D=TD2D+((K(i,1)*K(i,2))/F);
    end
    sum=Ttran+TD2D;
end
