const {app, Menu, BrowserWindow, Tray, Notification} = require('electron');
const path = require('path');
const isDev = require('electron-is-dev');

let mainWindow = null;
let tray = null;

app.dock.hide();

function showWindow() {
  const trayPos = tray.getBounds();
  const windowPos = mainWindow.getBounds();
  let x,
    y = 0;

  x = Math.round(trayPos.x + trayPos.width / 2 - windowPos.width / 2);

  if (process.platform == 'darwin') {
    y = Math.round(trayPos.y + trayPos.height);
  } else {
    y = Math.round(trayPos.y + trayPos.height * 10);
  }

  mainWindow.setPosition(x, y, false);
  mainWindow.show();
  mainWindow.focus();
}

function createWindow() {
  mainWindow = new BrowserWindow({
    webPreferences: {
      nodeIntegration: true,
    },
    width: 300,
    height: 220,
    show: false,
    frame: false,
    resizable: false,
    transparent: true,
  });

  mainWindow.on('blur', () => mainWindow.hide());

  if (isDev) {
    mainWindow.loadURL('http://localhost:1234/');
  } else {
    mainWindow.loadURL(`file://${path.join(__dirname, '../build/index.html')}`)
  }
}

app.whenReady().then(() => {
  tray = new Tray(`${__dirname}/assets/tray-icon.png`);

  tray.on('click', () => {
    if (mainWindow.isVisible()) {
      mainWindow.hide();
    } else {
      showWindow();
    }
  });

  createWindow();
});

// Quit when all windows are closed.
app.on('window-all-closed', function() {
  // On macOS it is common for applications and their menu bar
  // to stay active until the user quits explicitly with Cmd + Q
  if (process.platform !== 'darwin') app.quit();
});

app.on('activate', function() {
  if (BrowserWindow.getAllWindows().length === 0) createWindow();
});
