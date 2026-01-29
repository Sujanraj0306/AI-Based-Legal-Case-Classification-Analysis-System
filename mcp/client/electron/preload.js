const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('electron', {
     openPDF: (pdfPath) => ipcRenderer.invoke('open-pdf', pdfPath),
     openFolder: (folderPath) => ipcRenderer.invoke('open-folder', folderPath)
});
