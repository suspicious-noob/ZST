# ZST - ZPAQ Smart Toolkit ![GitHub Repo stars](https://img.shields.io/github/stars/suspicious-noob/zst?style=social) ![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

> A powerful, intelligent, and user-friendly batch archiving utility powered by ZPAQ. Designed for efficiency, safety, and flexibility.

---

[![GitHub latest release](https://img.shields.io/github/v/release/suspicious-noob/zst)](https://github.com/suspicious-noob/zst/releases)
![Release Date](https://img.shields.io/badge/Released-June_21,_2025-brightgreen)
<!--![Download Size](https://img.shields.io/badge/Download%20Size-1.3MB-blue)-->
### 🛠 Topics:
`zpaq` • `windows` • `batch-script` • `compression` • `archiving`



## 📦 Overview

**ZST (ZPAQ Smart Toolkit)** is a command-line batch tool designed to simplify and enhance the usage of [ZPAQ](http://mattmahoney.net/dc/zpaq.html), a high-efficiency journaling archiver. ZST adds an intelligent interface, drag-and-drop support, hardware-aware optimization, and safety features to ensure smooth compression and archiving workflows.

---

## 🚀 Features

- ✅ Drag-and-drop support for files and folders
- ✅ Smart detection of already-compressed file types (JPG, MP4, etc.)
- ✅ Hardware detection (CPU, threads, RAM)
- ✅ Auto-optimized compression method and thread count
- ✅ Manual override for power users
- ✅ Safe archive creation with overwrite protection
- ✅ Full archive listing and extraction
- ✅ Menu-driven interface with numbered hotkeys

---

## 📂 Folder Structure

```
ZST/
├── ZST.bat                # Main batch script
├── zpaq.exe               # Renamed ZPAQ 64bit binary (GPLv3)
├── LICENSE                # MIT license (for ZST)
├── LICENSE.zpaq           # GPLv3 license (for ZPAQ)
├── README.md              # This file
```

---

## 🛠 Requirements

- Windows 10 or 11
- PowerShell (for system hardware detection)
-`zpaq.exe` (ZPAQ binary, renamed from zpaq64.exe)

---
### ⚠️ Windows Defender Warning

ZST is a batch file that automates compression using ZPAQ. Because `.bat` files can run system commands, Windows Defender or SmartScreen might flag it as unsafe.

✅ This tool is open-source and can be inspected before use  
🛡 If you're comfortable, you can right-click the `.bat` file → **Properties** → **Unblock**  
🔐 Alternatively, view the source code in `ZST.bat` before running

## 📋 How to Use

1. Go to: https://github.com/suspicious-noob/ZST/releases/latest
2. Download the .zip file under "Assets"
3. Extract it somewhere safe (not Program Files)
4. Run ZST.bat (double-click or drag a file/folder onto it)

### 🖱 Drag and Drop

1. Drag any file or folder onto `ZST.bat`
2. The script will auto-analyze and recommend compression settings
3. Choose whether to proceed, cancel, or archive without compression

### 📜 Manual Menu

Double-click `ZST.bat` to access the main menu:

- `[1]` Compress file or folder
- `[2]` List archive contents
- `[3]` Extract full archive
- `[4]` Extract a single file
- `[5]` Exit

During compression:

- System hardware is detected
- Optimal settings are recommended
- You can override method and thread count

Archive files are saved with a `.zpaq` extension.

---
<!--![Repo size](https://img.shields.io/github/repo-size/suspicious-noob/zst)-->
## 🔐 Safety Notice

ZST uses system resources heavily for compression. Systems with low RAM or CPUs may experience slowdowns or crashes. The script includes:

- Clear warnings
- Safe default settings
- Overwrite confirmation prompts

Use at your own risk. The author assumes no responsibility for data loss or hardware issues.

---

## 📄 Licensing

### ZST (ZPAQ Smart Toolkit)

This batch script and toolkit are licensed under the [MIT License](LICENSE). You are free to use, modify, and distribute with attribution.

### ZPAQ

This toolkit includes `zpaq.exe` (renamed from zpaq64.exe), developed by **Matt Mahoney**, and licensed under the [GNU General Public License v3.0 (GPLv3)](https://www.gnu.org/licenses/gpl-3.0.html).

Source and original documentation: [http://mattmahoney.net/dc/zpaq.html](http://mattmahoney.net/dc/zpaq.html)

---

## 🙏 Acknowledgements

- [Matt Mahoney](http://mattmahoney.net) for ZPAQ
- Contributors to Batch and PowerShell scripting forums
- Testers and users who helped refine this tool

---

## 📬 Feedback & Contributions

Feel free to open an issue, fork the project, or submit pull requests to improve ZST. Let's make compression smarter together!

---

## 🧠 Fun Fact

If 70% or more of the files you selected are already compressed formats, ZST will let you skip compression entirely to save time. Efficiency matters!

---

**ZST - Smart Compression. Safe Archiving. Built for Power.**

