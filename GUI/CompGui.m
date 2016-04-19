function varargout = CompGui(varargin)
% COMPGUI MATLAB code for CompGui.fig
%      COMPGUI, by itself, creates a new COMPGUI or raises the existing
%      singleton*.
%
%      H = COMPGUI returns the handle to a new COMPGUI or the handle to
%      the existing singleton*.
%
%      COMPGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPGUI.M with the given input arguments.
%
%      COMPGUI('Property','Value',...) creates a new COMPGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CompGui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CompGui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CompGui

% Last Modified by GUIDE v2.5 19-Apr-2016 13:18:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CompGui_OpeningFcn, ...
                   'gui_OutputFcn',  @CompGui_OutputFcn, ...
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


% --- Executes just before CompGui is made visible.
function CompGui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CompGui (see VARARGIN)
% Choose default command line output for CompGui
axes(handles.TargetingComputer); %sets current axes to TargetingComputer
TargetingCompIm = imread('XwingTargetingComp.png');
axis image;
image(TargetingCompIm);
handles.output = hObject;
axes(handles.Porkins); %sets current axes to Porkins
porkinsIm = imread('Porkins.jpg');
axis image;
image(porkinsIm);
axes(handles.RebelSymbol); %sets current axes to RebelSymbol
RebelSymbolIm = imread('RebelSymbol2.jpg');
axis image;
image(RebelSymbolIm);
% Choose default command line output for CompGui
handles.output = hObject;

% Update handles structure
% UIWAIT makes CompGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CompGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure

function PlateNumberEnter_Callback(hObject, eventdata, handles)
% hObject    handle to PlateNumberEnter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PlateNumberEnter as text
%        str2double(get(hObject,'String')) returns contents of PlateNumberEnter as a double



% --- Executes during object creation, after setting all properties.
function PlateNumberEnter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlateNumberEnter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in FindTargButton.
function FindTargButton_Callback(hObject, eventdata, handles)
% hObject    handle to FindTargButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.TargetImage); %sets current axes to TargetImage
imageName = get(handles.PlateNumberEnter,'String');
targImage = imread(imageName);
axis image;
image(targImage);
choice = round(ginput(1));
RGB = impixel(targImage,choice(1),choice(2)); %RGB values of pixel
[ targetRows, targetCols, blackoutIMG ] = FindAllTargetCentroids(targImage,RGB);
axis image;
image(blackoutIMG); %Displays blackout image
hold on
plot(targetCols,targetRows,'wx');
hold off
stringOne = sprintf('Targets aquired. Row coordinates are:\n');
stringTwo = sprintf('\nColumn coordinates are:\n');
stringTargetRows = mat2str(targetRows);
stringTargetCols = mat2str(targetCols);
targString = [stringOne, stringTargetRows, stringTwo, stringTargetCols]; 
set(handles.TargetBox,'String',targString); %Sends targets to listbox
portName = get(handles.CommPort,'String');
GameTime_3(targetRows,targetCols,portName); %Runs competition code with the centroids found




% --- Executes on selection change in TargetBox.
function TargetBox_Callback(hObject, eventdata, handles)
% hObject    handle to TargetBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns TargetBox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from TargetBox


% --- Executes during object creation, after setting all properties.
function TargetBox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TargetBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in StartCommButton.
function StartCommButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartCommButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
portName = get(handles.CommPort,'String'); %Use this to check if serial is avalible somehow?
%Write code to check comm port somehow




function CommPort_Callback(hObject, eventdata, handles)
% hObject    handle to CommPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CommPort as text
%        str2double(get(hObject,'String')) returns contents of CommPort as a double


% --- Executes during object creation, after setting all properties.
function CommPort_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CommPort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
