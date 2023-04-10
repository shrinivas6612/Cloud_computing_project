function[sum]=TLsum(L,Fue)
    n=size(L,1);
    sum=0.0;
    for i=1:n
        sum=sum+L(i,1)*L(i,2);
    end
    sum=sum/Fue;
end