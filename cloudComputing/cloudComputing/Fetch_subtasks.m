function[L,K,M]=Fetch_subtasks(data,gamma,P)
    L=double.empty(0,2);
    K=double.empty(0,2);
    M=double.empty(0,2);
    N=size(data,1);
    for i=1:N
        if(gamma(i)==0)
            L=[L; [data(i,1) data(i,2)]];
        elseif(gamma(i)==1)
            K=[K; [data(i,1) data(i,2)]];
        else
            M=[M; [data(i,1) data(i,2)]];
        end
    end
end