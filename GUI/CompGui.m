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

% Last Modified by GUIDE v2.5 14-Apr-2016 12:52:23

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
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CompGui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CompGui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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
