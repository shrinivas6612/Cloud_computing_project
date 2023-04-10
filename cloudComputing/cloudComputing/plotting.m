Time_delay=double.empty(0,3);;
P1=double.empty(0,3);
[Data,P]=Data_generation(30);
%[T_total_r,P1_r,T_total_PAmax,P1_PAmax,T_total_PA,P1_PA]=main(Data,P,k1)

for i=5:30
    Data1=Data(1:i,:);
    P2=P(1:i,:);
    k1=15000;
    [T_total_r,P1_r,T_total_PAmax,P1_PAmax,T_total_PA,P1_PA]=main(Data1,P2,k1)
    Time_delay=[Time_delay;[T_total_r T_total_PAmax T_total_PA]];
    P1=[P1;[P1_r P1_PAmax P1_PA]];
end
x=[5:1:30];
x=transpose(x);

figure(1)
plot(x,Time_delay(:,1),'b')
hold on
plot(x,Time_delay(:,2),'g')
hold on
plot(x,Time_delay(:,3),'r')
hold off 
legend({'Random','PA-Pmax','PA'})
ylabel('Time Delay')
xlabel('NO.of subtasks')
grid

figure(2)
plot(x,P1(:,1),'b')
hold on
plot(x,P1(:,2),'g')
hold on
plot(x,P1(:,3),'r')
hold off
legend({'Random','PA-Pmax','PA'})
ylabel('Objective value of P1')
xlabel('NO.of subtasks')
grid


