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

% Last Modified by GUIDE v2.5 20-Apr-2016 01:40:29

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

isGoodImage =CheckImage(imageName);

if (isGoodImage)    
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
    stringOne = sprintf('Targets acquired.\n Row coordinates are:\n');
    stringTwo = sprintf('\nColumn coordinates are:\n');
    stringTargetRows = mat2str(targetRows);
    stringTargetCols = mat2str(targetCols);
    targString = [stringOne, stringTargetRows, stringTwo, stringTargetCols]; 
    set(handles.TargetBox,'String',targString); %Sends targets to listbox
    portName = get(handles.CommPort,'String');
    GameTime_3(targetRows,targetCols,portName); %Runs competition code with the centroids found
else
    fprintf('Bad image file.\n');
    %display error image
    axis image;
    image;
end
   

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
portName = get(handles.CommPort,'String');

%Backup port when my mac is being weird: /dev/tty.usbmodem1411

%test if the serial port is working
try
    Serial = serial(portName,'BAUD',9600);
    fopen(Serial);
    
   %Close the communications
    fclose(Serial); %closes Serial port
    
    portMessage = sprintf('Port ready for communication');  
    set(handles.serial_state_text,'BackgroundColor',[0.2    0.8    0.2]);
    
    set(handles.serial_state_text, 'Visible', 'on');
    set(handles.serial_state_text,'String', portMessage);
    
    set(handles.Clear_Serial,'Visible','off');
    %don't show acquire target button till we have correct port
    set(handles.FindTargButton, 'Visible', 'on');
    set(handles.PlateNumberEnter, 'Visible', 'on');
    set(handles.Target_Image_Text, 'Visible', 'on');
    
%if we can't connect, show error and display button to clear port   
catch
    fprintf('Error connecting to port\n');
    
    set(handles.serial_state_text,'BackgroundColor',[0.96    0.26    0.21]);
    set(handles.serial_state_text, 'Visible', 'on');
    errorMessage = sprintf('Error connecting to port');
    set(handles.serial_state_text,'String', errorMessage);
    
    set(handles.Clear_Serial,'Visible','on');
    
    %hide target system if port is broken
    set(handles.FindTargButton, 'Visible', 'off');
    set(handles.PlateNumberEnter, 'Visible', 'off');
    set(handles.Target_Image_Text, 'Visible', 'off');
    
    
    
    
end


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


% --- Executes on button press in Left_Button.
function Left_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Left_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
leftPort = sprintf('/dev/cu.usbmodem1421');
set(handles.CommPort,'String', leftPort);

% --- Executes on button press in Right_Button.
function Right_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Right_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rightPort = sprintf('/dev/cu.usbmodem1411');
set(handles.CommPort,'String', rightPort);


% --- Executes on button press in Clear_Serial.
function Clear_Serial_Callback(hObject, eventdata, handles)
% hObject    handle to Clear_Serial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Close the communications
portName = get(handles.CommPort,'String');
Serial = serial(portName,'BAUD',9600);
fclose(Serial); %closes Serial port

%Show cleared serial message and hide button
set(handles.serial_state_text,'BackgroundColor',[0.80    0.80    0.80]);
set(handles.serial_state_text, 'Visible', 'on');
clearMessage = sprintf('Serial cleared.\n  Try again.');
set(handles.serial_state_text,'String', clearMessage);
%hide button
set(hObject,'Visible','off');
