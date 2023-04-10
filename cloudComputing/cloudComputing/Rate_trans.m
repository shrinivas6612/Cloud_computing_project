function[value]=Rate_trans(p,d)
    %p is in mW and d is the distance between nodes(in m)
    %g0 is in dB
    g0=-40;
    value=double.empty(0,1);
    %sigma value(constants)
    sigma=4;
    b=1 * power(10,6);  % Hz
    N0=-174; % dBm/Hz
    N=size(p,1);
    for i=1:N
      value=[value; b*(log2(1+((g0*p(i)*power(d,sigma))/(N0*b))))];
    end
end