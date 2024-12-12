unit Unit1;

interface

uses
  // Windows API units
  Winapi.Windows,       // Provides access to Windows-specific API functions and types
  Winapi.Messages,      // Defines constants and types used for messages
  // Delphi system libraries
  System.SysUtils,      // Contains basic system functions like exception handling, date and time utilities
  System.Variants,      // Includes variant type support, allowing flexible data handling
  System.Classes,       // Provides access to classes, streams, and file management
  // VCL GUI components
  Vcl.Graphics,         // Contains graphics-related components like bitmaps and drawing functions
  Vcl.Controls,         // Includes controls like buttons, labels, etc.
  Vcl.Forms,            // Manages form-related functionality
  Vcl.Dialogs,          // Provides dialog boxes (e.g., message boxes)
  Vcl.ExtCtrls,         // Contains additional components like panels, timers, etc.
  // Indy (Internet Direct) library for networking
  IdUDPClient,          // Provides functionality for UDP client communication
  IdBaseComponent,      // Base class for Indy components
  IdComponent,          // Base class for all Indy components
  IdUDPBase,            // Base class for UDP components
  IdUDPServer,          // Provides functionality for UDP server communication
  // VCL standard components
  Vcl.StdCtrls,         // Contains standard UI controls like buttons, text fields, etc.
  IdGlobal,             // Defines global constants and utility functions for the Indy library
  IdSocketHandle,      // Handles socket communication for Indy components
  Vcl.ComCtrls,         // Provides controls like status bars and progress bars
  Vcl.Mask;             // Provides mask-edit controls (like formatted text input)

type
  TForm1 = class(TForm)
    // Panel components for layout management
    pnlTop: TPanel;      // Panel at the top of the form
    pnlMain: TPanel;     // Main panel for central content
    pnlBottom: TPanel;   // Panel at the bottom of the form
    Timer1: TTimer;      // Timer for periodic tasks
    IdUDPServer1: TIdUDPServer; // UDP server component
    IdUDPClient1: TIdUDPClient; // UDP client component
    btnStart: TButton;   // Button to start the connection
    btnStop: TButton;    // Button to stop the connection
    btnClear: TButton;   // Button to clear logs
    memLog: TMemo;       // Memo component for logging messages
    edtRemoteHost: TLabeledEdit;  // Labeled edit box for remote host input
    statusBar: TStatusBar;  // Status bar to display connection status
    lblStatus: TLabel;    // Label to show the current status
    rbRole: TRadioGroup;  // Radio group for selecting the role (Your PC / Another PC)
    // Event handlers for user interactions
    procedure Timer1Timer(Sender: TObject);  // Timer event handler
    procedure btnStartClick(Sender: TObject);  // Start button click handler
    procedure btnStopClick(Sender: TObject);  // Stop button click handler
    procedure btnClearClick(Sender: TObject);  // Clear button click handler
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread; const AData: TIdBytes; ABinding: TIdSocketHandle);  // UDP read handler
    procedure FormCreate(Sender: TObject);  // Form creation event handler
    procedure FormDestroy(Sender: TObject);  // Form destroy event handler
    procedure rbRoleClick(Sender: TObject);
    procedure lblStatusClick(Sender: TObject);  // Role selection change event handler
  private
    FIsRunning: Boolean; // Boolean flag to track if the connection is active
    // Private methods for updating the UI and managing connections
    procedure UpdateStatus(const AStatus: string);  // Updates the UI with the current status
    procedure SetupComponents;  // Sets up initial UI components
    procedure ConfigurePorts;  // Configures port settings based on selected role
  public
  end;

var
  Form1: TForm1;  // Global instance of the form

implementation

{$R *.dfm}  // Compiled resource file for the form

{ ================ Form Creation and Initialization ================ }

procedure TForm1.FormCreate(Sender: TObject);
begin
  SetupComponents;  // Initialize UI components
  ConfigurePorts;   // Set initial port configurations
  FIsRunning := False;  // Ensure the connection is initially inactive
  UpdateStatus('Ready');  // Set initial status to "Ready"
end;

{ ================ UI Setup and Layout ================ }

procedure TForm1.SetupComponents;
begin
  Self.Position := poScreenCenter;  // Center the form on the screen
  Self.Caption := 'UDP Hole Punching Tool';  // Set the form's caption

  pnlTop.Height := 120;  // Set top panel height
  pnlTop.Align := alTop;  // Align top panel to the top of the form
  pnlBottom.Height := 40;  // Set bottom panel height
  pnlBottom.Align := alBottom;  // Align bottom panel to the bottom of the form
  pnlMain.Align := alClient;  // Make the main panel fill the client area

  // Set up the role selection radio buttons
  rbRole.Items.Clear;
  rbRole.Items.Add('Your PC');  // Option for "Your PC"
  rbRole.Items.Add('Another PC');  // Option for "Another PC"
  rbRole.ItemIndex := 0;  // Set default selection to "Your PC"

  memLog.Align := alClient;  // Make memo log fill the client area
  memLog.ScrollBars := ssBoth;  // Enable both horizontal and vertical scrollbars

  // Set up the timer for sending periodic messages
  Timer1.Enabled := False;  // Disable timer initially
  Timer1.Interval := 1000;  // Set timer interval to 1000 milliseconds (1 second)
end;

{ ================ Port Configuration Based on Role ================ }

procedure TForm1.ConfigurePorts;
begin
  if rbRole.ItemIndex = 0 then  // Your PC role selected
  begin
    IdUDPServer1.DefaultPort := 7777;  // Set server port to 7777
    IdUDPClient1.BoundPort := 7777;  // Set client bound port to 7777
    IdUDPClient1.Port := 8888;  // Set client target port to 8888
    memLog.Lines.Add('Mode: Your PC');  // Log role selection
    memLog.Lines.Add('Server Port: 7777');  // Log server port
    memLog.Lines.Add('Client Bound Port: 7777');  // Log client bound port
    memLog.Lines.Add('Client Target Port: 8888');  // Log client target port
  end
  else  // Another PC role selected
  begin
    IdUDPServer1.DefaultPort := 8888;  // Set server port to 8888
    IdUDPClient1.BoundPort := 8888;  // Set client bound port to 8888
    IdUDPClient1.Port := 7777;  // Set client target port to 7777
    memLog.Lines.Add('Mode: Another PC');  // Log role selection
    memLog.Lines.Add('Server Port: 8888');  // Log server port
    memLog.Lines.Add('Client Bound Port: 8888');  // Log client bound port
    memLog.Lines.Add('Client Target Port: 7777');  // Log client target port
  end;
end;

{ ================ Role Change Handler ================ }

procedure TForm1.rbRoleClick(Sender: TObject);
begin
  if not FIsRunning then  // If the connection is not running
    ConfigurePorts;  // Reconfigure ports based on new role selection
end;

{ ================ Update Status Method ================ }

procedure TForm1.UpdateStatus(const AStatus: string);
begin
  statusBar.SimpleText := AStatus;  // Update status on the status bar
  lblStatus.Caption := AStatus;  // Update status on the label
  Application.ProcessMessages;  // Force the UI to update
end;

{ ================ Start Button Click Handler ================ }

procedure TForm1.btnStartClick(Sender: TObject);
begin
  try
    if trim(edtRemoteHost.Text) = '' then  // Check if remote host is empty
      raise Exception.Create('Remote host cannot be empty');  // Raise exception if empty

    IdUDPClient1.Host := edtRemoteHost.Text;  // Set the remote host for the client

    // Start communication and enable relevant controls
    Timer1.Enabled := True;  // Enable timer for periodic message sending
    btnStart.Enabled := False;  // Disable the start button
    btnStop.Enabled := True;   // Enable the stop button
    rbRole.Enabled := False;   // Disable the role selection
    FIsRunning := True;        // Mark the connection as running

    UpdateStatus('Connection started');  // Update status
    memLog.Lines.Add('=== Session Started ===');  // Log session start
  except
    on E: Exception do
    begin
      UpdateStatus('Error: ' + E.Message);  // Update status on error
      memLog.Lines.Add('ERROR: ' + E.Message);  // Log error message
    end;
  end;
end;

{ ================ Stop Button Click Handler ================ }

procedure TForm1.btnStopClick(Sender: TObject);
begin
  Timer1.Enabled := False;  // Disable the timer
  IdUDPServer1.Active := False;  // Deactivate the UDP server
  IdUDPClient1.Active := False;  // Deactivate the UDP client
  btnStart.Enabled := True;  // Enable the start button
  btnStop.Enabled := False;  // Disable the stop button
  rbRole.Enabled := True;   // Enable the role selection
  FIsRunning := False;      // Mark the connection as stopped
  UpdateStatus('Connection stopped');  // Update status
  memLog.Lines.Add('=== Session Stopped ===');  // Log session stop
end;

{ ================ Clear Log Button Handler ================ }

procedure TForm1.btnClearClick(Sender: TObject);
begin
  memLog.Clear;  // Clear the log
  ConfigurePorts;  // Reset port configuration based on role
  UpdateStatus('Log cleared');  // Update status to indicate log was cleared
end;

{ ================ UDP Server Read Handler ================ }

procedure TForm1.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
begin
  // Log received UDP message
  memLog.Lines.Add(Format('[%s] From %s:%d - %s',
    [FormatDateTime('hh:nn:ss', Now),
     ABinding.PeerIP,
     ABinding.PeerPort,
     BytesToString(AData)]));  // Format and log received message

  // Update window caption with received message details
  Caption := Format('Last message from port: %d', [ABinding.PeerPort]);
end;

procedure TForm1.lblStatusClick(Sender: TObject);
begin

end;

{ ================ Timer Event for Sending Messages ================ }

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  try
    if not FIsRunning then  // If the connection is not running, exit
      Exit;

    UpdateStatus('Sending message...');  // Update status to indicate message is being sent

    IdUDPServer1.Active := False;  // Temporarily deactivate the server
    IdUDPClient1.Active := True;   // Activate the UDP client and send message
    IdUDPClient1.Send('HELLO');    // Send the "HELLO" message
    memLog.Lines.Add(Format('[%s] Sent HELLO to %s:%d',
      [FormatDateTime('hh:nn:ss', Now),
       IdUDPClient1.Host,
       IdUDPClient1.Port]));  // Log message sent

    IdUDPClient1.Active := False;  // Deactivate the client after sending
    IdUDPServer1.Active := True;   // Reactivate the UDP server for listening

    UpdateStatus('Listening...');  // Update status to indicate listening mode
  except
    on E: Exception do
    begin
      UpdateStatus('Error: ' + E.Message);  // Update status on error
      memLog.Lines.Add('ERROR: ' + E.Message);  // Log error message
    end;
  end;
end;

{ ================ Cleanup on Form Destruction ================ }

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Timer1.Enabled := False;  // Disable the timer on form destruction
  if IdUDPServer1.Active then  // Deactivate the UDP server if active
    IdUDPServer1.Active := False;
  if IdUDPClient1.Active then  // Deactivate the UDP client if active
    IdUDPClient1.Active := False;
end;

end.

