%% ������ά�ռ������������յ�������Ƴ�����
%����start_point��             ������꣬��[1��1��1];
%����final_point��             �յ����꣬��[5��6��7];
%�����                        ������
function Func_plot_cuboid(start_point,final_point,color)
%% ���������յ㣬���㳤�����8���Ķ���
vertexIndex=[0 0 0;0 0 1;0 1 0;0 1 1;1 0 0;1 0 1;1 1 0;1 1 1];
cuboidSize=final_point-start_point;             %��������
vertex=repmat(start_point,8,1)+vertexIndex.*repmat(cuboidSize,8,1);
%% ����6��ƽ��ֱ��Ӧ�Ķ���
facet=[1 2 4 3;1 2 6 5;1 3 7 5;2 4 8 6;3 4 8 7;5 6 8 7];
%% ����8���������ɫ�����Ƶ�ƽ����ɫ���ݶ������ɫ���в岹
%color=[0;0;0;0;1;1;1;1];
% color=[1,0,0];
%% ���Ʋ�չʾͼ��
% patch('Vertices',vertex,'Faces',facet,'FaceVertexCData',color,'FaceColor',[1,1,1],'FaceAlpha',0.3);
patch('Vertices',vertex,'Faces',facet,'EdgeColor',color,'FaceColor',color,'FaceAlpha',0.1,'LineWidth',3);
% view([1,1,1]);
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on
%% ����xyz��ʾ��Χ
xmin=min(vertex(:,1))-1;
xmax=max(vertex(:,1))+1;
ymin=min(vertex(:,2))-1;
ymax=max(vertex(:,2))+1;
zmin=min(vertex(:,3))-1;
zmax=max(vertex(:,3))+1;
axis([xmin xmax ymin ymax zmin zmax]) 
end
