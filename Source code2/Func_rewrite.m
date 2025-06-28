function[mLine,vXTemp,vYTemp]=Func_rewrite(mLine,polyy,vXTemp,vYTemp,vertex,vertex_match)
%构建可能用于补全的四个矩形端点——顺时针
len=length(mLine);
point_1=[vXTemp(mLine(1,1)),vYTemp(mLine(1,1))];
point_2=[vXTemp(mLine(len,1)),vYTemp(mLine(len,1))];
% %判断起终两点距离
% if sqrt((point_1(1) - point_2(1))^2 + (point_1(2) - point_2(2))^2) <0.8
%     mLine(len,2)=mLine(1,1);
%     return;
% end
% coding
code0=Func_Getcode(point_1,vertex);
code1=Func_Getcode(point_2,vertex);

% if point_2(1)<=vertex(1,1)
%     code1=code1+1;
% elseif point_2(1)>=vertex(3,1)
%     code1=code1+2;
% end
% if point_2(2)<=vertex(1,2)
%     code1=code1+4;
% elseif point_2(2)>=vertex(3,2)
%     code1=code1+8;   
% end
if code0+code1==0
    mLine(len,2)=mLine(1,1);
    return;
end

if polyy==1
    vdx=find(vertex_match==4);
else
    vdx=find(vertex_match==2);
end

len_vdx=length(vdx);
len_vv=length(vXTemp); 
if len_vdx==1
    vXTemp(end+1)=vertex(vdx,1);
    vYTemp(end+1)=vertex(vdx,2);
    len_vv=len_vv+1;
    mLine(len,2)=len_vv;
    len=len+1;
    mLine(len,1)=len_vv;
    mLine(len,2)=mLine(1,1);
%     return;
elseif len_vdx==2
    code3=Func_Getcode(vertex(vdx(1),:),vertex);
%     code4=Func_Getcode(vertex(vdx(2),:),vertex);
    if bitand(code1,code3)~=0
        vXTemp(end+1)=vertex(vdx(1),1);
        vYTemp(end+1)=vertex(vdx(1),2);
        len_vv=len_vv+1;
        mLine(len,2)=len_vv;
        len=len+1;
        mLine(len,1)=len_vv;
        
        vXTemp(end+1)=vertex(vdx(2),1);
        vYTemp(end+1)=vertex(vdx(2),2);
        len_vv=len_vv+1;
        mLine(len,2)=len_vv;
        len=len+1;
        mLine(len,2)=mLine(1,1);
    else
        vXTemp(end+1)=vertex(vdx(2),1);
        vYTemp(end+1)=vertex(vdx(2),2);
        len_vv=len_vv+1;
        mLine(len,2)=len_vv;
        len=len+1;
        mLine(len,1)=len_vv;
        
        vXTemp(end+1)=vertex(vdx(1),1);
        vYTemp(end+1)=vertex(vdx(1),2);
        len_vv=len_vv+1;
        mLine(len,2)=len_vv;
        len=len+1;
        mLine(len,1)=len_vv;
        mLine(len,2)=mLine(1,1);
    end
elseif len_vdx==0
    mLine(len,2)=mLine(1,1);
end

% if ~isempty(vdx)
%     for i=1:len_vdx
%         vXTemp(end+1)=vertex(vdx(i),1);
%         vYTemp(end+1)=vertex(vdx(i),2);
%         len_vv=len_vv+1;
%         mLine(len,2)=len_vv;
%         len=len+1;
%         mLine(len,1)=len_vv;
%     end
%     mLine(len,2)=mLine(1,1);
% else
%     mLine(len,2)=mLine(1,1);
% end
% end
