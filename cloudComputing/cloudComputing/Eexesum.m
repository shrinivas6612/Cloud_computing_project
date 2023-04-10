function[value]=Eexesum(theta1,theta2,L,K,M)
    l=size(L,1);k=size(K,1);m=size(M,1);
    value=0;
    for i=1:l
        value=value+(theta1*(L(i,1)*L(i,2)));
    end
    for i=1:k
        value=value+(theta1*(K(i,1)*K(i,2)));
    end
    for i=1:m
        value=value+(theta2*(M(i,1)*M(i,2)));
    end
    value=value*power(10,-3);
end