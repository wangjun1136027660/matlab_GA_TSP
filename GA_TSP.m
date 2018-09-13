clear
clc
close all
X =[16.47,96.10
    16.47,94.44
    20.09,92.54
    22.39,93.37
    25.23,97.24
    22.00,96.05
    20.47,97.02
    17.20,96.29
    16.30,97.38
    14.05,98.12
    16.53,97.38
    21.52,95.59
    19.41,97.13
    20.09,92.55];%����������λ��,���Ի���load CityPosition1.mat
NIND=100;       %��Ⱥ��С
MAXGEN=200;
Pc=0.9;         %�������
Pm=0.05;        %�������
GGAP=0.9;      %����(Generation gap)
D=Distanse(X);  %���ɾ������
N=size(D,1);    %(34*34)
%% ��ʼ����Ⱥ
Chrom=InitPop(NIND,N);
%% �ڶ�άͼ�ϻ������������
% figure
% plot(X(:,1),X(:,2),'o');
%% ����������·��ͼ
DrawPath(Chrom(1,:),X)
pause(0.0001)
%% ���������·�ߺ��ܾ���
disp('��ʼ��Ⱥ�е�һ�����ֵ:')
OutputPath(Chrom(1,:));
Rlength=PathLength(D,Chrom(1,:));
disp(['�ܾ��룺',num2str(Rlength)]);
disp('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~')
%% �Ż�
gen=0;
figure;
hold on;box on
xlim([0,MAXGEN])
title('�Ż�����')
xlabel('����')
ylabel('����ֵ')
ObjV=PathLength(D,Chrom);  %����·�߳���
preObjV=min(ObjV);
while gen<MAXGEN
    %% ������Ӧ��
    ObjV=PathLength(D,Chrom);  %����·�߳���
    % fprintf('%d   %1.10f\n',gen,min(ObjV))
    line([gen-1,gen],[preObjV,min(ObjV)]);pause(0.0001)
    preObjV=min(ObjV);
    FitnV=Fitness(ObjV);
    %% ѡ��
    SelCh=Select(Chrom,FitnV,GGAP);
    %% �������
    SelCh=Recombin(SelCh,Pc);
    %% ����
    SelCh=Mutate(SelCh,Pm);
    %% ��ת����
    SelCh=Reverse(SelCh,D);
    %% �ز����Ӵ�������Ⱥ
    Chrom=Reins(Chrom,SelCh,ObjV);
    %% ���µ�������
    gen=gen+1 ;
end
%% �������Ž��·��ͼ
ObjV=PathLength(D,Chrom);  %����·�߳���
[minObjV,minInd]=min(ObjV);
DrawPath(Chrom(minInd(1),:),X)
%% ������Ž��·�ߺ��ܾ���
disp('���Ž�:')
p=OutputPath(Chrom(minInd(1),:));
disp(['�ܾ��룺',num2str(ObjV(minInd(1)))]);
disp('-------------------------------------------------------------')
