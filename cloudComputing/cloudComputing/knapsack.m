function [gamma]=knapsack(Vl,Vk,data)
    N=size(data,1);
    gamma=2*ones(30,1);    
    %% To calculate L
    F=zeros(N,Vl);
    for i=1:N
        for k=1:Vl
            if(i-1<1)
                F(i,k)=0;
            else
                F(i,k)=F(i-1,k);
            end
            temp=data(i,1)*data(i,2);
            if(k>=temp)
                if(i-1<1 || k-temp<1)
                    F(i,k)=max(F(i,k),temp);
                else
                    F(i,k)=max(F(i,k),F(i-1,k-temp)+temp);
                end
            end
        end
    end
    i=N;
    j=Vl;
    while(i>0 && j>0)
        temp=data(i,1)*data(i,2);
        if(i-1<1 || j-temp<1)
            if(F(i,j)==temp)
                gamma(i)=0;
                j=j-temp;
            end
        else
            if(F(i,j)==F(i-1,j-temp)+temp)
                gamma(i)=0;
                j=j-temp;
            end
        end
        i=i-1;
        
    end

    %% To calcualate K
    F=zeros(N,Vk);
    for i=1:N
        for k=1:Vk
            if(i-1<1)
                F(i,k)=0;
            else
                F(i,k)=F(i-1,k);
            end
            temp=data(i,1)*data(i,2);
            if(k>=temp)
                if(i-1<1 || k-temp<1)
                    F(i,k)=max(F(i,k),temp);
                else
                    F(i,k)=max(F(i,k),F(i-1,k-temp)+temp);
                end
            end
        end
    end
    i=N;
    j=Vk;
    while(i>0 && j>0)
        temp=data(i,1)*data(i,2);
        if(i-1<1 || j-temp<1)
            if(F(i,j)==temp && gamma(i)~=0)
                gamma(i)=1;
                j=j-temp;
            end
        else
            if((F(i,j)==F(i-1,j-temp)+temp) && gamma(i)~=0)
                gamma(i)=1;
                j=j-temp;
            end
        end
        i=i-1;
    end
end