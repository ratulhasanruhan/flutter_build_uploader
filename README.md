![flutter_build_uploader](https://github.com/user-attachments/assets/f8aedfe4-81b5-4c5f-b7a1-7fbff94e7ee2)

> A simple, powerful Flutter CLI tool to automate post-build tasks: rename APKs, upload to GoFile.io, and optionally share via WhatsApp.

---

## ✨ Features

* ✅ Automatically rename APK with version & timestamp
* ☁️ Upload to [gofile.io](https://gofile.io) and get a shareable link
* 💬 Optionally open WhatsApp Web with the download link
* ⚙️ Fully configurable via `pubspec.yaml`
* 🖥️ Auto-generates `flutterapk.bat` for Windows one-click builds

---

## 📦 Installation

### Option 1: Project-level

```yaml
dev_dependencies:
  flutter_build_uploader: ^0.0.4
```

### Option 2: Global CLI

```bash
dart pub global activate flutter_build_uploader
```

---

## 🔧 Configuration (optional)

In your `pubspec.yaml`:

```yaml
flutter_build_uploader:
  release: true      # true = release (default), false = debug
  whatsapp: true     # true = open WhatsApp Web (default)
```

---

## 🛠️ Usage

### 🔁 In-project (manual)

```bash
flutter build apk
dart run flutter_build_uploader
```

### ⚡ Global (after activating)

```bash
flutter build apk
flutter_build_uploader
```

### 🪟 For Windows users:

On first run, a `flutterapk.bat` file is created:

```bat
flutter build apk --release
dart run flutter_build_uploader
```

Just double-click it next time ✅

---

## 🧪 Example Output

```
✅ APK found. Renaming...
📦 APK renamed to: build/exports/myapp-v1.0.2-20250701_2100.apk
☁️ Uploading to GoFile.io...
✅ Uploaded! Link: https://gofile.io/d/abc123XYZ
💬 Opening WhatsApp Web...
```

---

## 🧠 Coming Soon

* Google Drive and Telegram upload support
* `.aab` format support
* QR code link page
* GitHub release automation
* Rename pattern customization
* GUI version (Flutter Desktop)

---

## 📄 License

MIT © [Ratul Hasan Ruhan](https://ratulhasanruhan.github.io)

