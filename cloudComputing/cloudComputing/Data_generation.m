function [data,P]=Data_generation(N)
    D=randi([1,100],N,1);
    C=randi([600,1000],N,1);
    P=50*ones(N,1);
    data=cat(2,D,C);
end
    