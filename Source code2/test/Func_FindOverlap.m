
% function [point]=Func_FindOverlap_1(mLine,mLine1,vXtemp,vYtemp,vXtemp1,vYtemp1)
%����һ����ϸ��
% mLine=[2,3;3,1;1,2];
% vXtemp=[2;0;0];
% vYtemp=[2;0;2];
% mLine1=[2,1;3,2;1,3];
% vXtemp1=[2;1;0];
% vYtemp1=[2;1;2];
%%�غ�
% mLine=[2,3;3,1;1,4;4,2];
% vXtemp=[2;0;2;0];
% vYtemp=[2;0;0;2];
% mLine1=[2,3;3,1;1,4;4,2];
% vXtemp1=[2;0;2;0];
% vYtemp1=[2;0;0;2];
%%��Ч
% mLine=[2,3;3,1;1,4;4,2];
% vXtemp=[2;0;2;0];
% vYtemp=[2;0;0;2];
% mLine1=[3,4;1,2;2,3;4,1];
% vXtemp1=[2;2;3;3];
% vYtemp1=[1;0;0;1];
%%����
% mLine1=[2,3;3,1;1,4;4,2];
% vXtemp1=[3;0;3;0];
% vYtemp1=[2;0;0;2];
% mLine=[3,4;1,2;2,3;4,1];
% vXtemp=[1;1;2;2];
% vYtemp=[1;0;0;1];
%%�м��غ�
mLine1=[2,3;3,1;1,4;4,2];
vXtemp1=[2;0;2;0];
vYtemp1=[2;0;0;2];
mLine=[3,4;1,2;2,3;4,1];
vXtemp=[1;1;3;3];
vYtemp=[2;0;0;2];
% ����
% mLine=[2,3;3,1;1,4;4,2];
% vXtemp=[2;0;2;0];
% vYtemp=[2;0;0;2];
% mLine1=[2,3;3,4;1,4;1,2];
% vXtemp1=[1;0;0;1];
% vYtemp1=[0;0;1;1];
%����
% mLine=[2,3;3,1;1,4;4,2];
% vXtemp=[2;0;2;0];
% vYtemp=[2;0;0;2];
% mLine1=[2,3;3,4;1,4;1,2];
% vXtemp1=[1;0;0;1];
% vYtemp1=[1;1;2;2];
% % ����
% mLine=[2,3;3,1;1,4;4,2];
% vXtemp=[2;0;2;0];
% vYtemp=[2;0;0;2];
% mLine1=[2,3;3,4;1,4;1,2];
% vXtemp1=[1;2;2;1];
% vYtemp1=[0;0;1;1];
%%����
% mLine=[2,3;3,1;1,4;4,2];
% vXtemp=[2;0;2;0];
% vYtemp=[2;0;0;2];
% mLine1=[2,3;3,4;1,4;1,2];
% vXtemp1=[1;2;2;1];
% vYtemp1=[1;1;2;2];
%%��ȫ����
% mLine=[2,3;3,1;1,4;4,2];
% vXtemp=[2;-2;2;-2];
% vYtemp=[2;-2;-2;2];
% mLine1=[2,3;3,4;1,4;1,2];
% vXtemp1=[-1;1;1;-1];
% vYtemp1=[-1;-1;1;1];

point=[];

%%
%�߶θ�ֵ��Segment
len=length(mLine);
% mLine(len,2)=mLine(1,1);
len1=length(mLine1);
% mLine1(len1,2)=mLine1(1,1);
%�ȰѶ�����е������к��ٸ�ֵ
Len_ALL=len+len1;

segments = repmat(Segment(0, 0, 0, 0, 0,false,false,-1),Len_ALL, 1 ); % Ԥ��������

count=1;
idx_other=[];
% idx_other1=[];
% idx_other2=[];
for i=1:len
     L1x(1)=vXtemp(mLine(i,1));
     L1x(2)=vXtemp(mLine(i,2));
     L1y(1)=vYtemp(mLine(i,1));
     L1y(2)=vYtemp(mLine(i,2));
     if(isequal([L1x(1),L1y(1)],[L1x(2),L1y(2)]))
         continue;
     end
     if(L1x(2)<L1x(1))
         segments(count)=Segment(L1x(2),L1y(2),L1x(1),L1y(1),1,false,false,-1);
         count=count+1;
     elseif((L1x(2)==L1x(1))&&(L1y(2)<L1y(1)))
         segments(count)=Segment(L1x(2),L1y(2),L1x(1),L1y(1),1,false,false,-1);
         count=count+1;
     else
         segments(count)=Segment(L1x(1),L1y(1),L1x(2),L1y(2),1,false,false,-1);
         count=count+1;
     end
end
for j=1:len1
     L2x(1)=vXtemp1(mLine1(j,1));
     L2x(2)=vXtemp1(mLine1(j,2));
     L2y(1)=vYtemp1(mLine1(j,1));
     L2y(2)=vYtemp1(mLine1(j,2));
     %���һ���˵�ı�
     if(isequal([L2x(1),L2y(1)],[L2x(2),L2y(2)]))
         continue;
     end
     if(L2x(2)<L2x(1))
         segments(count)=Segment(L2x(2),L2y(2),L2x(1),L2y(1),2,false,false,-1);
         count=count+1;
     elseif((L2x(2)==L2x(1))&&(L2y(2)<L2y(1)))
         segments(count)=Segment(L2x(2),L2y(2),L2x(1),L2y(1),2,false,false,-1);
         count=count+1;
     else
         segments(count)=Segment(L2x(1),L2y(1),L2x(2),L2y(2),2,false,false,-1);
         count=count+1;
     end
end
segments(count:Len_ALL,:)=[];
% ��ʼ���¼����У�Event Queue����״̬����Sweep Line Status��
%%
%ÿ����Ž��¼�����
events =zeros((count-1)*2,4);
% events=[];
% ʹ��ѭ�������¼���������ӵ�������
for i = 1:count-1
% for i=1:1
    start_x = segments(i).start_x;
    start_y = segments(i).start_y;
    end_x = segments(i).end_x;
    end_y = segments(i).end_y;
    
   % ��ӽ�����¼�
    events(2*i-1,:) = [start_x, start_y, i, -1];
%     events(end+1, :) = [start_x, start_y, i, 1];
    % ����뿪���¼�
    events(2*i, :) = [end_x, end_y, i, -2];
%      events(end+1, :) = [end_x, end_y, i, -1];
end

% % ��X���������¼����У�x-y-����-�߶�����
events=Func_SortEvents(events);
%%
%��ʼɨ��
%��ʼ��ɨ����λ��
current_x = -inf;
status=[];
% ��ʼ������洢
% intersections = [10000,10000,10000,10000];
% intersections=[];
% num_inter=1;%���ڼ�¼�������Ŀ��ϸ���߶�ʱ����
while ~isempty(events)
    event = events(1, :);
    events(1, :) = [];
    % ����ɨ����λ��
    current_x = event(1);
%     if(current_x>4.84)
%         a=1;
%     end
    if event(4) == -1 % ��˵��¼�
        % ����߶ε�״̬,�˴�Ӧ��������ɨ���߽����y���С����
        status = [status; struct('x',event(1),'y', event(2), 'segment', event(3),'inte_y',event(2) )];
% 
% ����״̬�ṹ��
        if numel(status) == 1
            %ֻҪ������ֻ����һ���˵㣬�ͱ���ԭ���ԣ���Ϊ�϶�����������
            continue;
        end
        %%%����
        for ss=1:numel(status)
            %�����ɨ���߽���������
            line=status(ss).segment;
            if(segments(line).end_x==segments(line).start_x)
                status(ss).inte_y=segments(line).start_y;
                continue;
            end
            slope =(segments(line).end_y-segments(line).start_y)/(segments(line).end_x-segments(line).start_x);
            status(ss).inte_y= segments(line).start_y + slope * (current_x - segments(line).start_x);
        end
        
        [~, idx] = sort([status.inte_y]);
        status = status(idx);%����״̬����
        idx_new=find(idx==max(idx));
        
        % �����ǰһ���߶εĽ���
        if numel(status) == 2
            temp=status(1).segment;
            temp1=status(2).segment;
            if(idx_new~=1)
                %�����־λ
                if(segments(temp).non_con>=0)
                    segments(temp1).inOut=false;
                    segments(temp1).otherInOut=true;  
                elseif(segments(temp1).poly==segments(temp).poly)
                    segments(temp1).inOut=~(segments(temp).inOut);
                    segments(temp1).otherInOut=segments(temp).otherInOut;
                else
                     segments(temp1).inOut=segments(temp).otherInOut;
                    segments(temp1).otherInOut=~(segments(temp).inOut);
                end
                
            end   
            [segments,events,count]=Func_CrossingTest_S2(temp,temp1,segments,events,count);
        end
% 
%         % �����ǰ���߶εĽ���
        if numel(status) > 2    
            if(idx_new==1)
                temp=status(1).segment;
                temp1=status(2).segment;
                [segments,events,count]=Func_CrossingTest_S2(temp,temp1,segments,events,count);
            elseif(idx_new==numel(status))
                %�����־λ
                temp=status(idx_new-1).segment;
                temp1=status(idx_new).segment;
                temp2=status(idx_new-2).segment;
                if(segments(temp).non_con>=0)
                    if(segments(temp).poly==segments(temp1).poly)
                          segments(temp1).inOut=~(segments(temp).inOut);
                          segments(temp1).otherInOut=~(segments(temp2).inOut);   
                    else
                         segments(temp1).inOut=~(segments(temp2).inOut);
                         segments(temp1).otherInOut=~(segments(temp).inOut);
                    end
                elseif(segments(temp1).poly==segments(temp).poly)
                    segments(temp1).inOut=~(segments(temp).inOut);
                    segments(temp1).otherInOut=segments(temp).otherInOut;
                else
                     segments(temp1).inOut=segments(temp).otherInOut;
                    segments(temp1).otherInOut=~(segments(temp).inOut);
                end

               [segments,events,count]=Func_CrossingTest_S2(temp,temp1,segments,events,count); 
            else
                %�����־λ
                temp=status(idx_new).segment;
                temp1=status(idx_new-1).segment;
                temp2=status(idx_new+1).segment;
                if(segments(temp1).non_con>=0)
                    if (idx_new-1)==1
                        segments(temp).inOut=false;
                        segments(temp).otherInOut=true; 
                    else
                        temp3=status(idx_new-2).segment;
                        if(segments(temp).poly==segments(temp1).poly)
                              segments(temp).inOut=~(segments(temp1).inOut);
                              segments(temp).otherInOut=~(segments(temp3).inOut);   
                        else
                             segments(temp).inOut=~(segments(temp3).inOut);
                             segments(temp).otherInOut=~(segments(temp1).inOut);
                        end
                    end
                elseif(segments(temp1).poly==segments(temp).poly)
                    segments(temp).inOut=~(segments(temp1).inOut);
                    segments(temp).otherInOut=segments(temp1).otherInOut;
                else
                    segments(temp).inOut=segments(temp1).otherInOut;
                    segments(temp).otherInOut=~(segments(temp1).inOut);
                end
               [segments,events,count]=Func_CrossingTest_S2(temp1,temp,segments,events,count);
               [segments,events,count]=Func_CrossingTest_S2(temp,temp2,segments,events,count);
               
           
            end
        end

    else
        if (segments(event(3)).otherInOut==1 && segments(event(3)).non_con<0) || (segments(event(3)).non_con>0)
           idx_other(end+1)=event(3); 
        end
        for i = 1:numel(status)
       
            if isequal(status(i).segment, event(3))
                
                if(i==1||i==numel(status))
                    status(i) = [];
                    break;
                else
                    temp=status(i-1).segment;
                    temp1=status(i+1).segment;
                    [segments,events,count]=Func_CrossingTest_S2(temp,temp1,segments,events,count);
                    status(i) = [];
                    break;
                end
                
            end
        end 

          
    end
end

%%
if ~isempty(idx_other)
    figure;
    hold on;
    len=length(idx_other);
    for i=1:len
%         if segments(idx_other(i)).non_con~=0
            x=[segments(idx_other(i)).start_x,segments(idx_other(i)).end_x];
            y=[segments(idx_other(i)).start_y,segments(idx_other(i)).end_y]; 
            plot(x,y,'b');
            point(end+1,:)=[x(1),y(1)];
            point(end+1,:)=[x(2),y(2)];
%         end
    end
end
hold off;
% end
%
%% 
