function q=Sampling_and_FeiJunyun_15_Quantization(A,fc,fs)
%A为幅值，fc为信号频率，fs为采样频率，M为量化间隔
t=0:1/10000000:0.02;
y=A*cos(2*pi*fc*t);%原始信号

%采样
dt=1/fs;
%采样间隔，采样间隔其实就可以理解为是采样信号的周期，周期=1/频率
N=50;
T=(0:N-1)*dt;        %定义采样的每个时间点
Sampling_y=A*cos(2*pi*fc*T);%采样之后的信号
figure(1);
plot(t,y,T,Sampling_y,'rp');
title('采样结果');

%均匀量化
ymin=min(Sampling_y);
ymax=max(Sampling_y);
M=16;

%a律非均匀量化的16段
delta_v9=ymax;
delta_v8=127*ymax/255;
delta_v7=63*ymax/255;
delta_v6=31*ymax/255;
delta_v5=15*ymax/255;
delta_v4=7*ymax/255;
delta_v3=3*ymax/255;
delta_v2=1*ymax/255;
delta_v1=0;
neg_delta_v8=1*ymin/255;
neg_delta_v7=3*ymin/255;
neg_delta_v6=7*ymin/255;
neg_delta_v5=15*ymin/255;
neg_delta_v4=31*ymin/255;
neg_delta_v3=63*ymin/255;
neg_delta_v2=127*ymin/255;
neg_delta_v1=ymin;

L=length(Sampling_y);

%16段量化区间的端点
m=zeros(L,1);
m(1)=neg_delta_v1;          %负的第1段的端点
m(2)=neg_delta_v2;          %负的第2段的端点
m(3)=neg_delta_v3;          %负的第3段的端点
m(4)=neg_delta_v4;          %负的第4段的端点
m(5)=neg_delta_v5;          %负的第5段的端点
m(6)=neg_delta_v6;          %负的第6段的端点
m(7)=neg_delta_v7;          %负的第7段的端点
m(8)=neg_delta_v8;          %负的第8段的端点
m(9)=delta_v1;              %正的第1段的端点
m(10)=delta_v2;             %正的第2段的端点
m(11)=delta_v3;             %正的第3段的端点
m(12)=delta_v4;             %正的第4段的端点
m(13)=delta_v5;             %正的第5段的端点
m(14)=delta_v6;             %正的第6段的端点
m(15)=delta_v7;             %正的第7段的端点
m(16)=delta_v8;             %正的第8段的端点
m(17)=delta_v9;             %正的第8段的末端

q=zeros(1,L);
for k=1:L
    %外循环是采样信号的幅值数组
    for i=2:M+1
        %内循环是均匀量化区间端点数组
        if Sampling_y(k)<=m(i)&&Sampling_y(k)>=m(i-1)
%             flag(k)=i;
            break;
        end
    end
    q1=m(i-1);
    q2=m(i);
    q(k)=(q1+q2)/2;%量化之后的信号
end
figure(2);
plot(T,q,'b*');
title('量化结果');



