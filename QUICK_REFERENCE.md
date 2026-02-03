# Referência Rápida - Flutter App

## 🚀 Comandos Essenciais

### Iniciar Aplicação

```bash
# Limpeza completa e execução
flutter clean && flutter pub get && flutter run

# Ou execute o script
./start.sh          # Linux/macOS
start.bat          # Windows
```

### Gerenciamento de Dependências

```bash
# Obter dependências
flutter pub get

# Atualizar dependências
flutter pub upgrade

# Verificar dependências desatualizadas
flutter pub outdated
```

### Build

```bash
# APK Android (Release)
flutter build apk --release

# App Bundle Android (para Play Store)
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

### Debug

```bash
# Executar com logs detalhados
flutter run -v

# Executar em modo profile (performance)
flutter run --profile

# Ver logs em tempo real
flutter logs

# Debugar em dispositivo específico
flutter run -d <device_id>
```

### Limpeza e Cache

```bash
# Limpar build
flutter clean

# Limpar cache pub
flutter pub cache clean

# Limpar cache do Android
rm -rf android/build
rm -rf build/
```

### Análise de Código

```bash
# Analisar código
flutter analyze

# Com mais detalhes
flutter analyze --pedantic
```

### Testes

```bash
# Executar testes
flutter test

# Com cobertura
flutter test --coverage

# Teste específico
flutter test test/models/user_test.dart
```

## 📱 Gerenciamento de Dispositivos

```bash
# Listar dispositivos conectados
flutter devices

# Emuladores disponíveis
flutter emulators

# Iniciar emulador
flutter emulators launch <emulator_name>

# Executar em dispositivo específico
flutter run -d <device_id>

# Executar em todos os dispositivos
flutter run -d all
```

## 🛠️ Troubleshooting Rápido

```bash
# Verificação completa
flutter doctor -v

# Aceitar licenças Android
flutter doctor --android-licenses

# Reset completo (cuidado!)
flutter clean
rm -rf pubspec.lock
flutter pub get
flutter run
```

## 📁 Estrutura de Pastas Rápida

```
lib/
├── config/         # Configurações
├── models/         # Modelos de dados
├── providers/      # State management
├── routes/         # Navegação
├── screens/        # Telas da app
├── services/       # Serviços API
├── theme/          # Tema e estilos
├── utils/          # Utilitários
├── widgets/        # Widgets reutilizáveis
└── main.dart       # Entry point
```

## 🔌 Configuração de API

**Arquivo**: `lib/config/app_config.dart`

```dart
// Alterar URL da API
static const String apiBaseUrl = 'http://seu-servidor:8000';

// Alterar timeout
static const Duration apiTimeout = Duration(seconds: 30);
```

## 🎨 Customização Rápida

**Cores**: `lib/theme/app_theme.dart`
```dart
static const Color primaryColor = Color(0xFF6366F1);
static const Color accentColor = Color(0xFF10B981);
```

**Fontes**: `pubspec.yaml`
```yaml
fonts:
  - family: NomeFonte
    fonts:
      - asset: assets/fonts/NomeFonte-Regular.ttf
```

## 📦 Adicionar Dependências

```bash
# Instalar novo package
flutter pub add nome_package

# Instalar versão específica
flutter pub add nome_package:1.0.0

# Remover package
flutter pub remove nome_package
```

## 🔐 Gerar Keystore (Android)

```bash
keytool -genkey -v -keystore ~/my-release-key.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 -alias my-key-alias
```

## 📋 Checklist Pré-Desenvolvimento

- [ ] Flutter instalado? `flutter --version`
- [ ] Dependências obtidas? `flutter pub get`
- [ ] Emulador/dispositivo? `flutter devices`
- [ ] API rodando? `curl http://localhost:8000/health`
- [ ] Código analisado? `flutter analyze`
- [ ] Testes passando? `flutter test`

## 🚀 Deploy Rápido

### Android
```bash
flutter build apk --release
# APK em: build/app/outputs/flutter-app-release.apk
```

### iOS
```bash
flutter build ios --release
# Build em: build/ios/iphoneos/Runner.app
```

### Web
```bash
flutter build web --release
# Build em: build/web/
```

## 💡 Dicas de Produtividade

```bash
# Hot reload automático
flutter run

# Recarregar hot durante execução
press 'r' in terminal

# Full restart
press 'R' in terminal

# Listar hot reload opções
press 'h' in terminal
```

## 📞 Contatos Úteis

- Documentação: https://flutter.dev/docs
- Pub.dev: https://pub.dev
- Stack Overflow: https://stackoverflow.com/questions/tagged/flutter
- GitHub Issues: https://github.com/flutter/flutter/issues

## 🎯 Workflow Típico

```bash
# 1. Iniciar
flutter run

# 2. Editar código
# ... faça mudanças ...

# 3. Hot reload (durante desenvolvimento)
# Press 'r'

# 4. Testar
flutter test

# 5. Analisar
flutter analyze

# 6. Build para produção
flutter build apk --release
```

---

**Última atualização**: Fevereiro de 2026  
**Versão**: 1.0.0
