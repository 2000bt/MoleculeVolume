% mLine=[2,3;3,1;1,4;4,2];
% vXtemp=[2;0;2;0];
% vYtemp=[2;0;0;2];
% mLine1=[1,4;4,3;3,2;2,1];
% vXtemp1=[1;3;3;1];
% vYtemp1=[1;1;3;3];
tic
len=length(mLine);
mLine(len,2)=mLine(1,1);
len1=length(mLine1);
mLine1(len1,2)=mLine1(1,1);
%�ȰѶ�����е������к��ٸ�ֵ
Len_ALL=len+len1;
segments = repmat(Segment(0, 0, 0, 0),Len_ALL, 1 ); % Ԥ��������
count=1;

for i=1:len
     L1x(1)=vXtemp(mLine(i,1));
     L1x(2)=vXtemp(mLine(i,2));
     L1y(1)=vYtemp(mLine(i,1));
     L1y(2)=vYtemp(mLine(i,2));
     if(isequal([L1x(1),L1y(1)],[L1x(2),L1y(2)]))
         continue;
     end
     if(L1x(2)<L1x(1))
         segments(count)=Segment(L1x(2),L1y(2),L1x(1),L1y(1));
         count=count+1;
     elseif((L1x(2)==L1x(1))&&(L1y(2)<L1y(1)))
         segments(count)=Segment(L1x(2),L1y(2),L1x(1),L1y(1));
         count=count+1;
     else
         segments(count)=Segment(L1x(1),L1y(1),L1x(2),L1y(2));
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
         segments(count)=Segment(L2x(2),L2y(2),L2x(1),L2y(1));
         count=count+1;
     elseif((L2x(2)==L2x(1))&&(L2y(2)<L2y(1)))
         segments(count)=Segment(L2x(2),L2y(2),L2x(1),L2y(1));
         count=count+1;
     else
         segments(count)=Segment(L2x(1),L2y(1),L2x(2),L2y(2));
         count=count+1;
     end
end
segments(count:Len_ALL,:)=[];
% ��ʼ���¼����У�Event Queue����״̬����Sweep Line Status��
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
events = sortrows(events,[1,2,4]);
for k=1:length(events)-1
    if((events(k,4)==events(k+1,4))&&(events(k,1)==events(k+1,1))&&(events(k,2)==events(k+1,2)))
        vIdx=find(events(:,3)==events(k,3));
        vIdx=vIdx(vIdx~=k);
        vIdx1=find(events(:,3)==events(k+1,3));
        vIdx1=vIdx1(vIdx1~=(k+1));
        if(events(vIdx,2)>events(vIdx1,2))
            events([k,k+1],:)=events([k+1,k],:);
        end 
    end
    continue;   
end
% vIdx=find(events(:,3)==events(1,3));
% vIdx1=find(events(:,3)==events(2,3));
% if(events(vIdx(2),2)>events(vIdx1(2),2))
%     events([vIdx(1),vIdx1(1)],:)=events([vIdx1(1),vIdx(1)],:);
% end
% vIdx=find(events(:,3)==events(Len_ALL*2-1,3));
% vIdx1=find(events(:,3)==events(Len_ALL*2,3));
% if(events(vIdx(1),2)>events(vIdx1(1),2))
%     events([vIdx(2),vIdx1(2)],:)=events([vIdx1(2),vIdx(2)],:);
% end

% ��ʼ��ɨ����λ��
current_x = -inf;
% events1=events; 
% ��ʼ��״̬�ṹ��
% status = struct('x', [], 'segment', []);
status=[];
% ��ʼ������洢
intersections = [100,100];

while ~isempty(events)
% for i=1:2
    % ���¼�������ȡ����һ���¼�

    event = events(1, :);
    events(1, :) = [];
    if(event(1)>=(4.5))
        a=1;
    end
    % ����ɨ����λ��
    current_x = event(1);

    if event(4) == -1 % ��˵��¼�
        % ����߶ε�״̬,�˴�Ӧ��������ɨ���߽����y���С����
        status = [status; struct('x',event(1),'y', event(2), 'segment', event(3))];
% 
% ����״̬�ṹ��
        if numel(status) == 1
            continue;
        end
        
        [~, idx] = sort([status.y]);
        status = status(idx);
        % �����ǰһ���߶εĽ���
        if numel(status) == 2
            temp=status(1).segment;
            temp1=status(2).segment;
            intersection=Func_CrossingTest_S([segments(temp).start_x,segments(temp).end_x],[segments(temp).start_y,segments(temp).end_y],[segments(temp1).start_x,segments(temp1).end_x],[segments(temp1).start_y,segments(temp1).end_y]);
            if ~isempty(intersection)
                 if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                        
                        events=[events;intersection(1),intersection(2),temp,temp1];
                        events=sortrows(events,[1,2]);
%                 inter=[intersection,temp,temp1];
%                 if(~(ismember(inter, intersections))||~(ismember(inter()
%                         intersections = [intersections; inter];
%                         events=[events;inter];
%                         events=sortrows(events,[1,2]);
                end
            end
            %for i = 1:numel(status)-1
%                 if doIntersect(status(i).segment, event(1:2))
%                     intersections = [intersections; event(1:2)];
%                 end
%                 Func_CrossingTest
%             end
        end
% 
%         % �����ǰ���߶εĽ���
        if numel(status) > 2
            idx_new=find(idx==max(idx));
            if(idx_new==1)
                tmp=status(1).segment;
                tmp1=status(2).segment;
                intersection=Func_CrossingTest_S([segments(tmp).start_x,segments(tmp).end_x],[segments(tmp).start_y,segments(tmp).end_y],[segments(tmp1).start_x,segments(tmp1).end_x],[segments(tmp1).start_y,segments(tmp1).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                        tmp
                        tmp1
                         events=[events;intersection(1),intersection(2),tmp,tmp1];
                        events=sortrows(events,[1,2]);
                    end
                end
            elseif(idx_new==numel(status))
                tmp=status(idx_new-1).segment;
                tmp1=status(idx_new).segment;
                intersection=Func_CrossingTest_S([segments(tmp).start_x,segments(tmp).end_x],[segments(tmp).start_y,segments(tmp).end_y],[segments(tmp1).start_x,segments(tmp1).end_x],[segments(tmp1).start_y,segments(tmp1).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                         tmp
                        tmp1
                        events=[events;intersection(1),intersection(2),tmp,tmp1];
                        events=sortrows(events,[1,2]);
                    end
                    
                end
            else
                tmp=status(idx_new).segment;
                tmp1=status(idx_new-1).segment;
                tmp2=status(idx_new+1).segment;
                intersection=Func_CrossingTest_S([segments(tmp1).start_x,segments(tmp1).end_x],[segments(tmp1).start_y,segments(tmp1).end_y],[segments(tmp).start_x,segments(tmp).end_x],[segments(tmp).start_y,segments(tmp).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                         tmp
                        tmp1
                        events=[events;intersection(1),intersection(2),tmp,tmp1];
                        events=sortrows(events,[1,2]);
                    end
                end
                intersection=Func_CrossingTest_S([segments(tmp).start_x,segments(tmp).end_x],[segments(tmp).start_y,segments(tmp).end_y],[segments(tmp2).start_x,segments(tmp2).end_x],[segments(tmp2).start_y,segments(tmp2).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                         tmp
                        tmp2
                        events=[events;intersection(1),intersection(2),tmp,tmp2];
                        events=sortrows(events,[1,2]);
                    end
                end
            end
            
           
        end
% 
%         
    elseif event(4) == -2 % �Ҷ˵��¼�
        % ��״̬��ɾ����Ӧ�߶�
        for i = 1:numel(status)
            if isequal(status(i).segment, event(3))
                if(i==1||i==numel(status))
                    status(i) = [];
                    break;
                else
                    tmp=status(i-1).segment;
                    tmp1=status(i+1).segment;
                    intersection=Func_CrossingTest_S([segments(tmp).start_x,segments(tmp).end_x],[segments(tmp).start_y,segments(tmp).end_y],[segments(tmp1).start_x,segments(tmp1).end_x],[segments(tmp1).start_y,segments(tmp1).end_y]);
                    if ~isempty(intersection)
                        if(~(ismembertol(intersection, intersections)))
                            intersections = [intersections; intersection];
                             tmp
                            tmp1
                            events=[events;intersection(1),intersection(2),tmp,tmp1];
                            events=sortrows(events,[1,2]);
                        end
                    end
                    status(i) = [];
                    break;
                end
                
            end
        end 
    else%ɨ�赽���㣬�����ཻ�߶ε�λ��
        
        tmp=event(3);
        tmp1=event(4);
        len_s=numel(status);
        %���������߶���״̬����λ��
        for i = 1:numel(status)
            if isequal(status(i).segment, tmp)
                ex_num1=i;
            end
            if isequal(status(i).segment, tmp1)
                ex_num2=i;
                break;
            end
        end
        a=max(ex_num1,ex_num2);
        b=min(ex_num1,ex_num2);
         %�ж��߶���״̬����λ���߶��Ƿ��ཻ
        line1=status(a).segment;
        line2=status(b).segment;
        status([ex_num1,ex_num2],:)=status([ex_num2,ex_num1],:);
        
        if( (b==1) && (a~=len_s))
                line3=status(b+1).segment;
                intersection=Func_CrossingTest_S([segments(line1).start_x,segments(line1).end_x],[segments(line1).start_y,segments(line1).end_y],[segments( line3).start_x,segments(line3).end_x],[segments(line3).start_y,segments(line3).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                        line1
                        line3
                        events=[events;intersection(1),intersection(2),line1,line3];
                        events=sortrows(events,[1,2]);
                    end
                end
                line4=status(a-1).segment;
                line5=status(a+1).segment;
                intersection=Func_CrossingTest_S([segments( line4).start_x,segments( line4).end_x],[segments(line4).start_y,segments( line4).end_y],[segments( line2).start_x,segments(line2).end_x],[segments(line2).start_y,segments(line2).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                            line4
                            line2
                        events=[events;intersection(1),intersection(2),line4,line2];
                        events=sortrows(events,[1,2]);
                    end
                end
                intersection=Func_CrossingTest_S([segments(line2).start_x,segments(line2).end_x],[segments(line2).start_y,segments(line2).end_y],[segments( line5).start_x,segments(line5).end_x],[segments(line5).start_y,segments(line5).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                        line2
                        line5
                         events=[events;intersection(1),intersection(2),line2,line5];
                        events=sortrows(events,[1,2]);
                    end
                end
                
        elseif((b~=1) && (a==len_s))
               line3=status(a-1).segment;
                intersection=Func_CrossingTest_S([segments( line3).start_x,segments( line3).end_x],[segments( line3).start_y,segments( line3).end_y],[segments(line2).start_x,segments(line2).end_x],[segments(line2).start_y,segments(line2).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                        line3
                        line2
                         events=[events;intersection(1),intersection(2),line3,line2];
                        events=sortrows(events,[1,2]);
                    end
                end
                line4=status( b-1).segment;
                line5=status( b+1).segment;
                intersection=Func_CrossingTest_S([segments( line4).start_x,segments( line4).end_x],[segments(line4).start_y,segments( line4).end_y],[segments(line1).start_x,segments(line1).end_x],[segments(line1).start_y,segments(line1).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                        line4
                        line1
                         events=[events;intersection(1),intersection(2),line4,line1];
                        events=sortrows(events,[1,2]);
                    end
                end
                intersection=Func_CrossingTest_S([segments(line1).start_x,segments(line1).end_x],[segments(line1).start_y,segments(line1).end_y],[segments( line5).start_x,segments(line5).end_x],[segments(line5).start_y,segments(line5).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                        line1
                        line5
                        events=[events;intersection(1),intersection(2),line1,line5];
                        events=sortrows(events,[1,2]);
                    end
                end
            
        elseif(( b==1) && (a==len_s))
            line3=status(b+1).segment;
                intersection=Func_CrossingTest_S([segments(line1).start_x,segments(line1).end_x],[segments(line1).start_y,segments(line1).end_y],[segments( line3).start_x,segments(line3).end_x],[segments(line3).start_y,segments(line3).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                        line1
                        line3
                         events=[events;intersection(1),intersection(2),line1,line3];
                        events=sortrows(events,[1,2]);
                    end
                end
                line4=status(a-1).segment;
                intersection=Func_CrossingTest_S([segments( line4).start_x,segments( line4).end_x],[segments( line4).start_y,segments( line4).end_y],[segments(line2).start_x,segments(line2).end_x],[segments(line2).start_y,segments(line2).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                        line4
                        line2
                         events=[events;intersection(1),intersection(2),line4,line2];
                        events=sortrows(events,[1,2]);
                    end
                end
        else
                line3=status(a-1).segment;
                line4=status(a+1).segment;
                intersection=Func_CrossingTest_S([segments(line3).start_x,segments(line3).end_x],[segments(line3).start_y,segments(line3).end_y],[segments(line2).start_x,segments(line2).end_x],[segments(line2).start_y,segments(line2).end_y]);
%                 intersection=Func_CrossingTest_S([segments( line2).start_x,segments( line2).end_x],[segments(line2).start_y,segments( line2).end_y],[segments(line3).start_x,segments(line3).end_x],[segments(line3).start_y,segments(line3).end_y]);
                if ~isempty(intersection)
%                     if(Func_already(intersection,intersections))
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                        line3
                        line2
                        events=[events;intersection(1),intersection(2),line3,line2];
                        events=sortrows(events,[1,2]);
                    end
                end
                intersection=Func_CrossingTest_S([segments(line2).start_x,segments(line2).end_x],[segments(line2).start_y,segments(line2).end_y],[segments( line4).start_x,segments(line4).end_x],[segments(line4).start_y,segments(line4).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                        line2
                        line4
                         events=[events;intersection(1),intersection(2),line2,line4];
                        events=sortrows(events,[1,2]);
                    end
                end
                
                line5=status( b-1).segment;
                line6=status( b+1).segment;
                intersection=Func_CrossingTest_S([segments( line5).start_x,segments( line5).end_x],[segments(line5).start_y,segments( line5).end_y],[segments(line1).start_x,segments(line1).end_x],[segments(line1).start_y,segments(line1).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                        line5
                        line1
                         events=[events;intersection(1),intersection(2),line5,line1];
                        events=sortrows(events,[1,2]);
                    end
                end
                intersection=Func_CrossingTest_S([segments(line1).start_x,segments(line1).end_x],[segments(line1).start_y,segments(line1).end_y],[segments( line6).start_x,segments(line6).end_x],[segments(line6).start_y,segments(line6).end_y]);
                if ~isempty(intersection)
                    if(~(ismembertol(intersection, intersections)))
                        intersections = [intersections; intersection];
                        line1
                        line6
                         events=[events;intersection(1),intersection(2),line1,line6];
                        events=sortrows(events,[1,2]);
                    end
                end
        end
          
    end
end
toc