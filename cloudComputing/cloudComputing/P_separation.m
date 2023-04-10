function[pue,pD2D,pMEC]=P_separation(P,gamma)
    N=size(P,1);
    pue=double.empty(0,1);
    pD2D=double.empty(0,1);
    pMEC=double.empty(0,1);
    for i=1:N
        if(gamma(i)==0)
            pue=[pue;P(i)];
        elseif(gamma(i)==1)
            pD2D=[pD2D;P(i)];
        else
            pMEC=[pMEC;P(i)];
        end
    end
end
     