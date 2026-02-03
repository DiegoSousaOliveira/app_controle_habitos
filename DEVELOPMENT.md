# Instruções de Desenvolvimento

Este arquivo contém instruções adicionais para desenvolvimento da aplicação Flutter.

## 🔧 Configuração do Ambiente

### 1. Instalar Flutter

**Windows:**
```powershell
# Usando Chocolatey
choco install flutter

# Ou fazer download manualmente
# https://flutter.dev/docs/get-started/install
```

**macOS:**
```bash
# Usando Homebrew
brew install flutter

# Ou fazer download manualmente
```

**Linux:**
```bash
# Clone o repositório
git clone https://github.com/flutter/flutter.git -b stable ~/flutter

# Adicione ao PATH
export PATH="$PATH:$HOME/flutter/bin"
```

### 2. Verificar Instalação

```bash
flutter --version
flutter doctor
```

### 3. Configurar Emuladores

**Android:**
```bash
flutter emulators
flutter emulators launch <emulator_name>
```

**iOS (macOS apenas):**
```bash
open -a Simulator
```

## 📂 Estrutura de Pastas Explicada

### `/config`
Configurações globais da aplicação:
- `app_config.dart` - URLs, constantes, timeouts

### `/models`
Classes de dados (Data Models):
- `user.dart` - Modelo de usuário
- `habit.dart` - Modelo de hábito
- `habit_log.dart` - Log de conclusão
- `user_stats.dart` - Estatísticas

### `/providers`
Gerenciamento de estado com Provider:
- `auth_provider.dart` - Autenticação e usuário
- `habit_provider.dart` - Gerenciamento de hábitos
- `stats_provider.dart` - Estatísticas

### `/routes`
Navegação com GoRouter:
- `app_router.dart` - Definição de rotas

### `/screens`
Telas da aplicação:
- `/auth` - Login e Registro
- `/home` - Dashboard principal
- `/habits` - Listagem e criação de hábitos
- `/stats` - Visualização de estatísticas
- `/profile` - Perfil do usuário

### `/services`
Serviços de API:
- `auth_service.dart` - Endpoints de autenticação
- `habit_service.dart` - Endpoints de hábitos
- `stats_service.dart` - Endpoints de estatísticas
- `storage_service.dart` - Armazenamento local

### `/theme`
Configuração visual:
- `app_theme.dart` - Cores, tipografia, estilos

### `/utils`
Utilitários:
- `api_exceptions.dart` - Exceções personalizadas

### `/widgets`
Widgets reutilizáveis:
- `common_widgets.dart` - Loading, Error, EmptyState
- `habit_card.dart` - Card de hábito

## 🔄 Fluxo de Dados

```
UI (Screens)
    ↓
Providers (State Management)
    ↓
Services (API Calls)
    ↓
Models (Data Classes)
    ↓
API (FastAPI Backend)
```

## 📱 Estrutura de Telas

### Splash Screen
- Inicializa a aplicação
- Verifica autenticação
- Redireciona para Login ou Home

### Auth Screens
- **LoginScreen** - Fazer login
- **RegisterScreen** - Criar nova conta

### Home Screen
- Dashboard principal
- Resumo de hábitos
- Acesso rápido às funcionalidades
- Bottom navigation para Perfil

### Habits Screens
- **HabitsListScreen** - Listar todos os hábitos
- **CreateHabitScreen** - Criar novo hábito

### Stats Screen
- Visualizar estatísticas
- Total de pontos
- Nível e streak

### Profile Screen
- Editar informações do usuário
- Visualizar data de cadastro
- Logout

## 🎨 Customização de Tema

### Alterar Cores Primárias

Em `theme/app_theme.dart`:

```dart
static const Color primaryColor = Color(0xFF6366F1); // Mude isso
static const Color accentColor = Color(0xFF10B981);   // E isso
```

### Alterar Fontes

1. Adicione as fontes em `pubspec.yaml`:
```yaml
fonts:
  - family: MinhaFonte
    fonts:
      - asset: assets/fonts/MinhaFonte-Regular.ttf
```

2. Use em `app_theme.dart`:
```dart
fontFamily: 'MinhaFonte',
```

## 🔗 Conexão com API

### Mudar URL da API

Em `config/app_config.dart`:

```dart
static const String apiBaseUrl = 'http://seu-servidor:8000';
```

### Adicionar Novos Endpoints

1. Crie um novo método em `services/novo_service.dart`
2. Implemente em um novo `providers/novo_provider.dart`
3. Use nas telas

Exemplo:
```dart
// Service
Future<List<Dados>> obterDados(String token) async {
  // Chamar API
}

// Provider
Future<void> loadDados(String token) async {
  final dados = await _service.obterDados(token);
  _dados = dados;
  notifyListeners();
}

// Screen
Consumer<NovoProv>(
  builder: (context, provider, child) {
    return ListView(
      children: provider.dados.map((d) => Card(child: ...)).toList(),
    );
  },
)
```

## 🧹 Boas Práticas

### Nomenclatura
- `_privateVariable` - Variáveis privadas
- `publicVariable` - Variáveis públicas
- `methodName()` - Métodos em camelCase
- `ClassName` - Classes em PascalCase
- `file_name.dart` - Arquivos em snake_case

### State Management
- Use `Consumer` para ler valores
- Use `Provider.of()` para ler fora de build
- Use `context.read()` para modificar estado
- Use `context.watch()` para ler e reagir

### Gerenciamento de Recursos
```dart
@override
void dispose() {
  _controller.dispose();  // Sempre limpe
  super.dispose();
}
```

### Tratamento de Erros
```dart
try {
  // Operação
} on ApiException catch (e) {
  // Erro da API
  print(e.message);
} catch (e) {
  // Erro genérico
  print(e);
}
```

## 🚀 Deploy

### Android

1. **Criar Keystore:**
```bash
keytool -genkey -v -keystore ~/my-release-key.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias my-key-alias
```

2. **Build APK:**
```bash
flutter build apk --release
```

3. **Upload em Store:**
   - Google Play Console
   - Configurar dados do app
   - Upload do APK

### iOS

1. **Gerar Certificados:**
   - Apple Developer Account
   - Certificates, Identifiers & Profiles

2. **Build para App Store:**
```bash
flutter build ios --release
```

3. **Upload com Transporter:**
   - Usar Xcode ou Transporter
   - Enviar para App Store

### Web

1. **Build:**
```bash
flutter build web --release
```

2. **Deploy:**
   - Firebase Hosting
   - Vercel
   - GitHub Pages
   - Seu servidor

## 📊 Monitoramento

### Ver Logs

```bash
flutter logs
```

### Debug em Tempo Real

```bash
flutter run -v
```

### Profiling

```bash
flutter run --profile
```

## 🔍 Debugging

### Usar DevTools

```bash
flutter pub global activate devtools
devtools
```

### Breakpoints no Código

```dart
debugPrint('Variável: $variavel');
assert(condicao);
```

## 📚 Recursos Úteis

- [Flutter Docs](https://flutter.dev/docs)
- [Dart Docs](https://dart.dev/guides)
- [Provider Package](https://pub.dev/packages/provider)
- [GoRouter Package](https://pub.dev/packages/go_router)
- [Dio Package](https://pub.dev/packages/dio)

## 🤖 CI/CD (Opcional)

### GitHub Actions

Crie `.github/workflows/flutter.yml`:

```yaml
name: Flutter CI

on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
      - run: flutter build apk --release
```

---

**Dúvidas?** Consulte a documentação oficial ou abra uma issue.
