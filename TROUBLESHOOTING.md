# Guia de Troubleshooting - Flutter App

## 🔧 Problemas Comuns

### 1. Erro: "Failed to resolve: com.android.support:appcompat-v7"

**Causa:** Conflito de dependências no Android

**Solução:**
```bash
flutter clean
flutter pub get
flutter pub upgrade
flutter run
```

### 2. Erro: "Gradle build failed"

**Solução:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

### 3. Erro de Conexão com API: "Connection refused"

**Problema:** Não consegue conectar ao servidor local

**Solução (Android Emulator):**
```dart
// Altere em app_config.dart
static const String apiBaseUrl = 'http://10.0.2.2:8000';
// Em vez de localhost
```

**Solução (iOS Simulator):**
```dart
static const String apiBaseUrl = 'http://localhost:8000';
```

**Solução (Dispositivo Físico):**
```dart
// Use o IP da máquina
static const String apiBaseUrl = 'http://192.168.1.100:8000';
// Substitua 192.168.1.100 pelo seu IP real
```

### 4. Erro: "No connected devices"

**Solução:**
```bash
# Listar dispositivos
flutter devices

# Iniciar emulador Android
flutter emulators
flutter emulators launch <emulator_name>

# Ou verificar dispositivos iOS
open -a Simulator
```

### 5. Erro: "Permission denied" ao escrever arquivos

**Causa:** Permissões de armazenamento não configuradas

**Android:** Adicione em `android/app/src/main/AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
```

### 6. Erro: "Token inválido ou expirado"

**Solução:**
```dart
// Fazer logout
await authProvider.logout();
// Fazer login novamente
await authProvider.login(email: email, password: password);
```

### 7. Erro: "CORS error" ao chamar API

**Causa:** API não permite requisições do app

**Solução (no Backend):**
```python
# Em FastAPI, configure CORS
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Em produção, especifique os domínios
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

### 8. Erro: "Hot reload não funciona"

**Solução:**
```bash
# Reinicie a sessão de debug
flutter run
```

### 9. Erro ao fazer Build para Android

**Solução:**
```bash
# Atualize dependências
flutter pub upgrade

# Limpe tudo
flutter clean
rm -rf build/

# Reconfigure
flutter pub get

# Tente novamente
flutter build apk --release
```

### 10. App fecha ao abrir (Crash)

**Solução:**
```bash
# Ver logs detalhados
flutter logs

# Executar com verbose
flutter run -v
```

## 📊 Verificação de Saúde

### Diagnostic Completo

```bash
flutter doctor -v
```

Procure por ❌ em qualquer linha - indica problema.

### Instalar Componentes Faltantes

```bash
flutter doctor --android-licenses
y  # Aceite todos os termos
```

## 🔍 Debug

### Ativar Logging Detalhado

```dart
// No início de main.dart
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 5,
    lineLength: 120,
    colors: true,
    printEmojis: true,
  ),
);
```

### Usar DevTools

```bash
# Terminal 1
flutter run

# Terminal 2
devtools
# Acesse http://localhost:6100
```

### Debugger no Android Studio

1. Abra o projeto em Android Studio
2. Defina breakpoints
3. Clique em Debug (ao invés de Run)
4. Inspecione variáveis

## 📱 Testes no Dispositivo Físico

### Android

1. Ative Developer Mode no dispositivo
2. Ative USB Debugging
3. Conecte via USB
4. Execute:
```bash
flutter devices
flutter run -d <device_id>
```

### iOS

1. Conecte o dispositivo via USB
2. Confie no computador
3. Execute:
```bash
flutter devices
flutter run -d <device_id>
```

## 🌐 Problemas de Rede

### Checar Conectividade

```dart
import 'package:connectivity_plus/connectivity_plus.dart';

final connectivity = Connectivity();
final result = await connectivity.checkConnectivity();
print(result); // WiFi, mobile, none
```

### Testar Endpoint da API

```bash
# Verificar se API está rodando
curl http://localhost:8000/health

# Testar login
curl -X POST http://localhost:8000/users/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"password"}'
```

## 🎯 Otimização de Performance

### Verificar FPS

```bash
flutter run -d <device_id>
# Press 'L' para listar os dispositivos
# Procure por Frame info
```

### Usar DevTools para Profiling

```bash
# Executar com flag de profiling
flutter run --profile -d <device_id>

# Abrir DevTools
devtools
```

## 📝 Criando Issues/Reportando Problemas

Quando reportar um problema, inclua:

1. **Informações do Sistema:**
```bash
flutter doctor -v
```

2. **Logs:**
```bash
flutter logs > log.txt
```

3. **Stack Trace:**
```
Copie o erro completo do terminal
```

4. **Passos para Reproduzir:**
```
1. ...
2. ...
3. ...
```

5. **Comportamento Esperado:**
```
...
```

## 🚀 Recursos de Ajuda

- [Flutter Issues](https://github.com/flutter/flutter/issues)
- [Stack Overflow - Flutter](https://stackoverflow.com/questions/tagged/flutter)
- [Flutter Community Discord](https://discord.com/invite/N7Yshp4)
- [Official Flutter Documentation](https://flutter.dev/docs)

## ✅ Checklist de Troubleshooting

- [ ] Executei `flutter clean`
- [ ] Executei `flutter pub get`
- [ ] Reiniciei o IDE
- [ ] Verifiquei `flutter doctor`
- [ ] Verifiquei logs com `flutter logs`
- [ ] Testei em outro dispositivo/emulador
- [ ] Resetei os dados do app
- [ ] Atualizei o Flutter: `flutter upgrade`

---

**Ainda com problemas?** Crie uma issue com todas as informações acima.
