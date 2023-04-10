function[value]=Etrasum(K,M,dD2D,dMEC,pD2D,pMEC)
     value=0;
     k=size(K,1);m=size(M,1);
     RD2D=Rate_trans(pD2D,dD2D);
     RMEC=Rate_trans(pMEC,dMEC);
     if size(RD2D,1)==1
         for i=1:k
            value=value+((K(i,1)/RD2D)*pD2D);
         end
     else
         for i=1:k
            value=value+((K(i,1)/RD2D(i))*pD2D(i));
         end
     end

     if size(RMEC,1)==1
         for i=1:m
            value=value+((M(i,1)/RMEC)*pMEC);
         end
     else
         for i=1:m
            value=value+((M(i,1)/RMEC(i))*pMEC(i));
         end
     end
     %since p is in mW, mulitply by 10^-3
     value=value*power(10,-3);
end