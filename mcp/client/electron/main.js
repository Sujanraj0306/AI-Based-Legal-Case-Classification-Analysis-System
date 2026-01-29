const { app, BrowserWindow, ipcMain, shell } = require('electron');
const path = require('path');

let mainWindow;

function createWindow() {
     mainWindow = new BrowserWindow({
          width: 1200,
          height: 800,
          webPreferences: {
               nodeIntegration: false,
               contextIsolation: true,
               preload: path.join(__dirname, 'preload.js')
          },
          title: 'Legal Case Analysis System',
          backgroundColor: '#ffffff'
     });

     // Load the app
     if (process.env.NODE_ENV === 'development' || !app.isPackaged) {
          mainWindow.loadURL('http://localhost:5173');
          mainWindow.webContents.openDevTools();
     } else {
          mainWindow.loadFile(path.join(__dirname, '../dist/index.html'));
     }

     mainWindow.on('closed', () => {
          mainWindow = null;
     });
}

// IPC handlers
ipcMain.handle('open-pdf', async (event, pdfPath) => {
     try {
          await shell.openPath(pdfPath);
          return { success: true };
     } catch (error) {
          return { success: false, error: error.message };
     }
});

ipcMain.handle('open-folder', async (event, folderPath) => {
     try {
          await shell.openPath(folderPath);
          return { success: true };
     } catch (error) {
          return { success: false, error: error.message };
     }
});

app.whenReady().then(createWindow);

app.on('window-all-closed', () => {
     if (process.platform !== 'darwin') {
          app.quit();
     }
});

app.on('activate', () => {
     if (mainWindow === null) {
          createWindow();
     }
});
