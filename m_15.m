function q=Sampling_and_FeiJunyun_15_Quantization(A,fc,fs)
%AΪ��ֵ��fcΪ�ź�Ƶ�ʣ�fsΪ����Ƶ�ʣ�MΪ�������
t=0:1/10000000:0.02;
y=A*cos(2*pi*fc*t);%ԭʼ�ź�

%����
dt=1/fs;
%������������������ʵ�Ϳ������Ϊ�ǲ����źŵ����ڣ�����=1/Ƶ��
N=50;
T=(0:N-1)*dt;        %���������ÿ��ʱ���
Sampling_y=A*cos(2*pi*fc*T);%����֮����ź�
figure(1);
plot(t,y,T,Sampling_y,'rp');
title('�������');

%��������
ymin=min(Sampling_y);
ymax=max(Sampling_y);
M=16;

%a�ɷǾ���������16��
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

%16����������Ķ˵�
m=zeros(L,1);
m(1)=neg_delta_v1;          %���ĵ�1�εĶ˵�
m(2)=neg_delta_v2;          %���ĵ�2�εĶ˵�
m(3)=neg_delta_v3;          %���ĵ�3�εĶ˵�
m(4)=neg_delta_v4;          %���ĵ�4�εĶ˵�
m(5)=neg_delta_v5;          %���ĵ�5�εĶ˵�
m(6)=neg_delta_v6;          %���ĵ�6�εĶ˵�
m(7)=neg_delta_v7;          %���ĵ�7�εĶ˵�
m(8)=neg_delta_v8;          %���ĵ�8�εĶ˵�
m(9)=delta_v1;              %���ĵ�1�εĶ˵�
m(10)=delta_v2;             %���ĵ�2�εĶ˵�
m(11)=delta_v3;             %���ĵ�3�εĶ˵�
m(12)=delta_v4;             %���ĵ�4�εĶ˵�
m(13)=delta_v5;             %���ĵ�5�εĶ˵�
m(14)=delta_v6;             %���ĵ�6�εĶ˵�
m(15)=delta_v7;             %���ĵ�7�εĶ˵�
m(16)=delta_v8;             %���ĵ�8�εĶ˵�
m(17)=delta_v9;             %���ĵ�8�ε�ĩ��

q=zeros(1,L);
for k=1:L
    %��ѭ���ǲ����źŵķ�ֵ����
    for i=2:M+1
        %��ѭ���Ǿ�����������˵�����
        if Sampling_y(k)<=m(i)&&Sampling_y(k)>=m(i-1)
%             flag(k)=i;
            break;
        end
    end
    q1=m(i-1);
    q2=m(i);
    q(k)=(q1+q2)/2;%����֮����ź�
end
figure(2);
plot(T,q,'b*');
title('�������');



