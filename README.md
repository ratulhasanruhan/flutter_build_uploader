![flutter_build_uploader](https://github.com/user-attachments/assets/f8aedfe4-81b5-4c5f-b7a1-7fbff94e7ee2)

> A Flutter CLI tool to simplify your post-build workflow: auto-rename APKs, upload to File.io, and share via WhatsApp.

---

## ✨ Features

* ✅ Rename APK after build with version and timestamp
* ☁️ Upload to [gofile.io](https://www.gofile.io) and get a shareable link
* 💬 Optionally open WhatsApp Web with the APK link
* ⚙️ Configurable using `pubspec.yaml`
* 🖥️ Auto-generates `flutterapk.bat` on Windows for one-click build & upload

---

## 📦 Installation

Add this to your Flutter project:

```yaml
dev_dependencies:
  flutter_build_uploader: ^0.0.4
```

---

## 🔧 Configuration

Add the following to your `pubspec.yaml`:

```yaml
flutter_build_uploader:
  release: true      # true = release, false = debug
  whatsapp: true     # open WhatsApp Web with the link (optional)
```

If not set, defaults are:

* `release: true`
* `whatsapp: true`

---

## 🛠️ Usage

### 🔁 Run manually:

```bash
flutter build apk
dart run flutter_build_uploader
```

### ⚡ Windows users:

On first run, it auto-creates a `flutterapk.bat` file:

```bat
flutter build apk --release
dart run flutter_build_uploader
```

Just double-click this file next time!

---

## 🧪 Example Output

```
✅ APK found. Renaming...
📦 APK renamed to: build/exports/myapp-v1.0.2-20250701_2100.apk
☁️ Uploading to GoFile.io...
✅ Uploaded! Link: https://gofile.io/examplelink
💬 Opening WhatsApp Web...
```

---

## 🧠 Coming Soon

* Google Drive and Telegram uploads
* `.aab` support
* QR code download page
* GitHub release automation
* GUI version (with Flutter Desktop)

---

## 📄 License

MIT © Ratul Hasan Ruhan
