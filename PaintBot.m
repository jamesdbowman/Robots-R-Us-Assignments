function varargout = PaintBot(varargin)
% PAINTBOT MATLAB code for PaintBot.fig
%      PAINTBOT, by itself, creates a new PAINTBOT or raises the existing
%      singleton*.
%
%      H = PAINTBOT returns the handle to a new PAINTBOT or the handle to
%      the existing singleton*.
%
%      PAINTBOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAINTBOT.M with the given input arguments.
%
%      PAINTBOT('Property','Value',...) creates a new PAINTBOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PaintBot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PaintBot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PaintBot

% Last Modified by GUIDE v2.5 23-Mar-2015 16:52:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PaintBot_OpeningFcn, ...
                   'gui_OutputFcn',  @PaintBot_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before PaintBot is made visible.
function PaintBot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PaintBot (see VARARGIN)

handles.j1_theta = 0;
handles.j2_theta = 0;
handles.j3_theta = 0;
handles.ee_x = 0;
handles.ee_y = 0;
handles.points = [];
% Choose default command line output for PaintBot
handles.output = hObject;

updateRobot(hObject, handles);

% UIWAIT makes PaintBot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PaintBot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in j1_minus.
function j1_minus_Callback(hObject, eventdata, handles)
% hObject    handle to j1_minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.j1_theta = handles.j1_theta + 5;
updateRobot(hObject, handles);


% --- Executes on button press in j1_plus.
function j1_plus_Callback(hObject, eventdata, handles)
% hObject    handle to j1_plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.j1_theta = handles.j1_theta - 5;
updateRobot(hObject, handles);


% --- Executes on button press in j2_minus.
function j2_minus_Callback(hObject, eventdata, handles)
% hObject    handle to j2_minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.j2_theta = handles.j2_theta + 5;
updateRobot(hObject, handles);


% --- Executes on button press in j2_plus.
function j2_plus_Callback(hObject, eventdata, handles)
% hObject    handle to j2_plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.j2_theta = handles.j2_theta - 5;
updateRobot(hObject, handles);


% --- Executes on button press in j3_minus.
function j3_minus_Callback(hObject, eventdata, handles)
% hObject    handle to j3_minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.j3_theta = handles.j3_theta + 5;
updateRobot(hObject, handles);


% --- Executes on button press in j3_plus.
function j3_plus_Callback(hObject, eventdata, handles)
% hObject    handle to j3_plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.j3_theta = handles.j3_theta - 5;
updateRobot(hObject, handles);

% --- Executes on button press in x_minus.
function x_minus_Callback(hObject, eventdata, handles)
% hObject    handle to x_minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

r = sqrt((handles.ee_x-1)^2 + (handles.ee_y)^2);
azimuth = atan2((handles.ee_y),(handles.ee_x-1));
inverseKine(r, azimuth, hObject, handles);


% --- Executes on button press in x_plus.
function x_plus_Callback(hObject, eventdata, handles)
% hObject    handle to x_plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
r = sqrt((handles.ee_x+1)^2 + (handles.ee_y)^2);
azimuth = atan2((handles.ee_y),(handles.ee_x+1));
inverseKine(r, azimuth, hObject, handles);


% --- Executes on button press in y_minus.
function y_minus_Callback(hObject, eventdata, handles)
% hObject    handle to y_minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
r = sqrt((handles.ee_x)^2 + (handles.ee_y-1)^2);
azimuth = atan2((handles.ee_y-1),(handles.ee_x));
inverseKine(r, azimuth, hObject, handles);


% --- Executes on button press in y_plus.
function y_plus_Callback(hObject, eventdata, handles)
% hObject    handle to y_plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
r = sqrt((handles.ee_x)^2 + (handles.ee_y+1)^2);
azimuth = atan2((handles.ee_y+1),(handles.ee_x));
inverseKine(r, azimuth, hObject, handles);

% --- Executes on button press in paint.
function paint_Callback(hObject, eventdata, handles)
% hObject    handle to paint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%add ee_x,ee_y to points matrix
handles.points = cat(1,handles.points,[handles.ee_x handles.ee_y]);
updateRobot(hObject,handles);

%draws current state of robot onto plot
function updateRobot(hObject, handles)
%axes uses range [0,1]
%arm lengths:
%   arm 1 = 150px => .15
%   arm 2 = 100px => .10
%   arm 3 = 75px  => .075
%   widths for all arms are .05

arm1_length = .15;
arm2_length = .10;
arm3_length = .075;

axes(handles.axes1);
hold off
%draw all painted points
for i = 1:size(handles.points,1)
    %draw circle diameter 10px (.01) at i,j
    generate_Circle(handles.points(i,1),handles.points(i,2),.01,'black');
    hold on
end
arm1 = generate_Arm(.05,arm1_length,'r');
hold on
generate_Circle(.5,0,.025,'c'); %joint circle
arm2 = generate_Arm(.05,arm2_length,'b');
arm3 = generate_Arm(.05,arm3_length,'g');

%Set positions and Rotations
%arm 1 base always gets set to X=.5, Y=0
set(arm1,'XData',get(arm1,'XData')+.5);
set(arm1,'YData',get(arm1,'YData')+arm1_length);
rotate(arm1,[0 0 1],handles.j1_theta,[.5 0 0]);
%arm 2
a2_x = -sind(handles.j1_theta) * (arm1_length*2) + .5;
a2_y = cosd(handles.j1_theta) * (arm1_length*2);
generate_Circle(a2_x,a2_y,.02,'c'); %joint circle
set(arm2,'XData',get(arm2,'XData')+a2_x);
set(arm2,'YData',get(arm2,'Ydata')+a2_y + arm2_length);
rotate(arm2,[0 0 1],handles.j1_theta + handles.j2_theta,[a2_x a2_y 0]);
%arm 3
a3_x = a2_x - sind(handles.j1_theta + handles.j2_theta) * (arm2_length*2);
a3_y = a2_y + cosd(handles.j1_theta + handles.j2_theta) * (arm2_length*2);
generate_Circle(a3_x,a3_y,.015,'c'); %joint circle
set(arm3,'XData',get(arm3,'XData')+a3_x);
set(arm3,'YData',get(arm3,'Ydata')+a3_y + arm3_length);
rotate(arm3,[0 0 1],handles.j1_theta + handles.j2_theta + handles.j3_theta,[a3_x a3_y 0]);

%set handle for end effector position (for painting)
handles.ee_x = a3_x - sind(handles.j1_theta + handles.j2_theta + handles.j3_theta) * (arm3_length*2);
handles.ee_y = a3_y + cosd(handles.j1_theta + handles.j2_theta + handles.j3_theta) * (arm3_length*2);


%clean up axes
set(handles.axes1,'XTick',[],'YTick',[])
axis equal
set(handles.axes1,'Xlim',[0,1]);
set(handles.axes1,'Ylim',[0,1]);
% Update handles structure
guidata(hObject, handles);

% Link angle calculation
function inverseKine(r, azimuth,hObject, handles)
% Input is the polar coordinates of end effector's position.
%
% In order to use this function, you'll need to convert the end
% effector's position to spherical coordinates. All you'll need
% is r (distance from origin to point and azimuth (angular direction).
% These can be calculated as such: r = sqrt(x^2+y^2) and azimuth = atan2(y,x).
%

l1 = .15;
l2 = .10;
l3 = .075;

sinA = sqrt((3*l3-l1) / (8*l3) + sqrt(((3*l3-l1) / (8*l3))^2 - (l3^2 - r^2) / (16*l1*l3)));
a = asin(sinA);
d = 2 * l1 * sinA;
b = acos((r^2+d^2-l3^2) / (2*r*d));
s = sign(psi - pi / 2);

handles.j1_theta =(psi-pi/2-s * (pi/2-a+b)) * 180/pi;
handles.j2_theta = s * (pi-2*a) * 180/pi;
handles.j3_theta = s * (pi-2*a) * 180/pi;
updateRobot(hObject,handles);

%builds ellipse, must use Set and Rotate to position and rotate afterwards.
function h = generate_Arm(a,b,c)
%a = horizontal radius
%b = vertical radius
%c = color
beta = 0 * (pi/180);
sinbeta = sin(beta);
cosbeta = cos(beta);
alpha = linspace(0,360,50)' .* (pi/180); %linspace 3rd arg = #steps = smoothness
sinalpha = sin(alpha);
cosalpha = cos(alpha);
X = (a*cosalpha*cosbeta-b*sinalpha*sinbeta);
Y = (a*cosalpha*sinbeta+b*sinalpha*cosbeta);
h = fill(X,Y,c);
set(h,'FaceAlpha',0.75')

function h = generate_Circle(x,y,r,c)
%x = x loc
%y = y loc
%r = radius
%c = color
angle = 0:0.01:2*pi;
xp = r * cos(angle);
yp = r * sin(angle);
h = fill(x + xp, y + yp, c);
