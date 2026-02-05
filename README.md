# 📱 Controle de Hábitos - Aplicação Flutter

Uma aplicação Flutter profissional e completa para gerenciamento e rastreamento de hábitos pessoais, integrada com a API FastAPI "Habits API".

---

## 📋 Índice

1. [Visão Geral](#visão-geral)
2. [Começar Rápido](#começar-rápido)
3. [Arquitetura da Aplicação](#arquitetura-da-aplicação)
4. [Gerenciador de Estado](#gerenciador-de-estado)
5. [Estrutura de Pastas](#estrutura-de-pastas)
6. [Funcionalidades](#funcionalidades)
7. [Dependências](#dependências)
8. [Desenvolvimento](#desenvolvimento)
9. [Troubleshooting](#troubleshooting)
10. [Referência Rápida](#referência-rápida)

---

## 🎯 Visão Geral

### O Que Foi Entregue

✅ **Estrutura Profissional**
- Arquitetura em camadas bem definida
- State Management otimizado com **Provider**
- Serviços de API robuustos (Dio)
- Persistência local (SharedPreferences)
- Navegação avançada (GoRouter)
- Tema completo com Material Design 3

✅ **Funcionalidades Completas**
- Autenticação com JWT
- Gerenciamento completo de hábitos (CRUD)
- Sistema de frequência e pontos
- Perfil de usuário editable
- Interface responsiva e intuitiva
- Sincronização em tempo real com API

---

## 🚀 Começar Rápido

### 1️⃣ Instalar Dependências

```bash
cd flutter_app
flutter pub get
```

### 2️⃣ Configurar URL da API

Edite `lib/config/app_config.dart`:

```dart
static const String apiBaseUrl = 'http://localhost:8000';

// Para Android Emulator:
// static const String apiBaseUrl = 'http://10.0.2.2:8000';

// Para dispositivo físico (substitua pelo seu IP):
// static const String apiBaseUrl = 'http://192.168.1.100:8000';
```

### 3️⃣ Executar a Aplicação

**Opção 1: Script automático**
```bash
# Windows
start.bat

# Linux/macOS
chmod +x start.sh
./start.sh
```

**Opção 2: Comando direto**
```bash
flutter run
```

### 4️⃣ Testar a Aplicação

1. Registre uma nova conta
2. Faça login
3. Crie seu primeiro hábito
4. Acompanhe o progresso

---

## 🏗️ Arquitetura da Aplicação

### Modelo em Camadas

```
┌─────────────────────────────────────┐
│  UI Layer (Screens & Widgets)       │  ← Interface do usuário
│  ├─ Telas de autenticação           │
│  ├─ Gerenciamento de hábitos        │
│  ├─ Estatísticas                    │
│  └─ Perfil do usuário               │
├─────────────────────────────────────┤
│  Provider Layer (State Management)  │  ← Gerenciamento de estado
│  ├─ AuthProvider                    │
│  ├─ HabitProvider                   │
│  └─ StatsProvider                   │
├─────────────────────────────────────┤
│  Service Layer (API & Storage)      │  ← Lógica de negócio
│  ├─ AuthService                     │
│  ├─ HabitService                    │
│  ├─ StatsService                    │
│  └─ StorageService                  │
├─────────────────────────────────────┤
│  Model Layer (Data Classes)         │  ← Estrutura de dados
│  ├─ User                            │
│  ├─ Habit                           │
│  ├─ HabitLog                        │
│  └─ UserStats                       │
├─────────────────────────────────────┤
│  API Layer (FastAPI Backend)        │  ← Servidor
└─────────────────────────────────────┘
```

### Fluxo de Dados

```
Usuário interage com a UI
    ↓
Screen dispara ação (ex: criar hábito)
    ↓
Provider.createHabit() é chamado
    ↓
Service.createHabit() faz requisição HTTP
    ↓
API FastAPI processa e responde
    ↓
Resposta é convertida para Model
    ↓
Provider atualiza seu estado
    ↓
Widgets assistindo o Provider fazem rebuild
    ↓
UI é atualizada automaticamente
```

### Estrutura da projeto

```
lib/
├── config/              # Configurações da aplicação
├── models/              # Modelos de dados
├── providers/           # State management (Provider)
├── routes/              # Roteamento (GoRouter)
├── screens/             # Telas da aplicação
│   ├── auth/           # Telas de autenticação
│   ├── home/           # Tela inicial
│   ├── habits/         # Gerenciamento de hábitos
│   ├── stats/          # Estatísticas
│   └── profile/        # Perfil do usuário
├── services/            # Serviços de API
├── theme/              # Tema da aplicação
├── utils/              # Utilitários
├── widgets/            # Widgets reutilizáveis
└── main.dart           # Ponto de entrada
```

---

## 🎛️ Gerenciador de Estado

A aplicação utiliza o **Provider** como gerenciador de estado. Este é um padrão robusto, bem testado e amplamente utilizado na comunidade Flutter.

### Por Que Provider?

✅ **Simples de aprender** - API intuitiva
✅ **Performance** - Rebuild otimizado (Builder, Consumer)
✅ **Escalável** - Funciona bem em apps grandes
✅ **Comunidade** - Amplo suporte e documentação
✅ **Tipo-seguro** - Type-safe por padrão
✅ **Teste fácil** - Testable em testes unitários

### Três Providers Principais

#### 1. **AuthProvider** - Autenticação e Usuário
**Localização:** `lib/providers/auth_provider.dart`

**Responsabilidades:**
- Login e registro de usuários
- Gerenciamento de tokens JWT
- Persistência de sessão
- Carregamento de dados do usuário

**Estados:**
- `user` - Usuário autenticado
- `token` - Token JWT
- `isLoading` - Estado de carregamento
- `isAuthenticated` - Se está autenticado

**Métodos principais:**
```dart
// Autenticação
Future<void> register({required String email, ...})
Future<void> login({required String email, required String password})
Future<void> logout()
Future<void> updateProfile({required String name, ...})
```

**Como usar:**
```dart
// Ler estado
final authState = context.read<AuthProvider>();
final user = authState.user;
final token = authState.token;

// Assistir mudanças
final authState = context.watch<AuthProvider>();

// Chamar ação
await context.read<AuthProvider>().login(
  email: 'user@example.com',
  password: 'senha123'
);
```

---

#### 2. **HabitProvider** - Gerenciamento de Hábitos
**Localização:** `lib/providers/habit_provider.dart`

**Responsabilidades:**
- CRUD de hábitos (Create, Read, Update, Delete)
- Registrar conclusão de hábitos
- Gerenciar lista de hábitos do usuário

**Estados:**
- `habits` - Lista de hábitos
- `isLoading` - Estado de carregamento
- `selectedHabit` - Hábito selecionado

**Métodos principais:**
```dart
// Operações CRUD
Future<void> loadHabits()
Future<void> createHabit({
  required String title,
  required String description,
  required String frequency,
  required int points,
  ...
})
Future<void> updateHabit({
  required int habitId,
  required String title,
  ...
})
Future<void> deleteHabit({required int habitId})

// Logs
Future<void> logHabitCompletion({required int habitId})
```

**Como usar:**
```dart
// Listar hábitos
await context.read<HabitProvider>().loadHabits();

// Criar novo hábito
await context.read<HabitProvider>().createHabit(
  title: 'Exercício',
  description: 'Fazer exercício por 30 minutos',
  frequency: 'daily',
  points: 10,
  active: true,
);

// Assistir lista de hábitos
final habits = context.watch<HabitProvider>().habits;
```

---

#### 3. **StatsProvider** - Estatísticas do Usuário
**Localização:** `lib/providers/stats_provider.dart`

**Responsabilidades:**
- Carregar estatísticas do usuário
- Calcular progresso e achievements
- Atualizar dados de performance

**Estados:**
- `stats` - Objeto com estatísticas
- `isLoading` - Estado de carregamento

**Métodos principais:**
```dart
Future<void> loadStats()
```

**Como usar:**
```dart
// Carregar estatísticas
await context.read<StatsProvider>().loadStats();

// Acessar dados
final stats = context.watch<StatsProvider>().stats;
final points = stats?.totalPoints ?? 0;
final level = stats?.level ?? 1;
```

---

### Padrão de Uso nos Screens

#### Padrão 1: Leitura (Read)
```dart
class MeuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Ler provider sem assistir mudanças
        context.read<HabitProvider>().createHabit(...);
      },
      child: Text('Criar'),
    );
  }
}
```

#### Padrão 2: Assistência (Watch)
```dart
class MeuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Assistir mudanças - widget faz rebuild
    final habits = context.watch<HabitProvider>().habits;
    
    return ListView(
      children: habits.map((h) => HabitCard(habit: h)).toList(),
    );
  }
}
```

#### Padrão 3: Consumer (Isolado)
```dart
class MeuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HabitProvider>(
      builder: (context, habitProvider, child) {
        if (habitProvider.isLoading) {
          return LoadingWidget();
        }
        
        return ListView(
          children: habitProvider.habits
            .map((h) => HabitCard(habit: h))
            .toList(),
        );
      },
    );
  }
}
```

---

### Onde o Estado Management é Usado

#### 🔐 AuthProvider é usado em:
- `splash_screen.dart` - Verificar se está autenticado
- `login_screen.dart` - Fazer login
- `register_screen.dart` - Registrar nova conta
- `profile_screen.dart` - Editar perfil e logout
- `app_router.dart` - Redirecionar baseado na autenticação
- Todos os screens - Acessar informações do usuário

#### 📝 HabitProvider é usado em:
- `home_screen.dart` - Mostrar resumo de hábitos
- `habits_list_screen.dart` - Listar todos os hábitos
- `create_habit_screen.dart` - Criar novo hábito
- `edit_habit_screen.dart` - Editar hábito existente

#### 📊 StatsProvider é usado em:
- `home_screen.dart` - Mostrar pontos no dashboard
- `stats_screen.dart` - Dashboard completo de estatísticas
- `profile_screen.dart` - Mostrar nível e progresso

---

## 📁 Estrutura de Pastas

```
flutter_app/
├── lib/
│   ├── config/
│   │   └── app_config.dart           # Configurações globais (URLs, timeouts)
│   │
│   ├── models/
│   │   ├── user.dart                 # Modelo de usuário
│   │   ├── habit.dart                # Modelo de hábito
│   │   ├── habit_log.dart            # Log de conclusão
│   │   └── user_stats.dart           # Estatísticas do usuário
│   │
│   ├── providers/
│   │   ├── auth_provider.dart        # 🎯 Gerenciador de autenticação
│   │   ├── habit_provider.dart       # 🎯 Gerenciador de hábitos
│   │   └── stats_provider.dart       # 🎯 Gerenciador de estatísticas
│   │
│   ├── routes/
│   │   └── app_router.dart           # Rotas e navegação com GoRouter
│   │
│   ├── screens/
│   │   ├── splash_screen.dart        # Tela de inicialização
│   │   ├── auth/
│   │   │   ├── login_screen.dart     # Login
│   │   │   └── register_screen.dart  # Registro
│   │   ├── home/
│   │   │   └── home_screen.dart      # Dashboard principal
│   │   ├── habits/
│   │   │   ├── habits_list_screen.dart    # Listar hábitos
│   │   │   ├── create_habit_screen.dart   # Criar hábito
│   │   │   └── edit_habit_screen.dart     # Editar hábito
│   │   ├── stats/
│   │   │   └── stats_screen.dart     # Estatísticas
│   │   └── profile/
│   │       └── profile_screen.dart   # Perfil do usuário
│   │
│   ├── services/
│   │   ├── auth_service.dart         # API de autenticação
│   │   ├── habit_service.dart        # API de hábitos
│   │   ├── stats_service.dart        # API de estatísticas
│   │   └── storage_service.dart      # Armazenamento local
│   │
│   ├── theme/
│   │   └── app_theme.dart            # Tema, cores, tipografia
│   │
│   ├── utils/
│   │   └── api_exceptions.dart       # Exceções customizadas
│   │
│   ├── widgets/
│   │   ├── common_widgets.dart       # Loading, Error, Empty states
│   │   ├── habit_card.dart           # Card de hábito
│   │   └── app_bottom_nav_bar.dart   # Bottom navigation
│   │
│   └── main.dart                     # Entry point da aplicação
│
├── test/
│   └── widget_test.dart              # Testes
│
├── pubspec.yaml                      # Dependências do projeto
├── analysis_options.yaml             # Linting rules
├── .gitignore                        # Configuração Git
├── start.bat                         # Script inicialização (Windows)
└── start.sh                          # Script inicialização (Linux/macOS)
```

---

## ✨ Funcionalidades

### ✅ Autenticação
- [x] Registro de novo usuário com email/senha
- [x] Login seguro
- [x] Tokens JWT persistidos
- [x] Sessão automática
- [x] Logout completo
- [x] Edição de perfil

### ✅ Gerenciamento de Hábitos
- [x] Criar novo hábito com:
  - Título e descrição
  - Frequência (Diária, Semanal, Mensal, Anual)
  - Sistema de pontos
  - Status ativo/inativo
- [x] Editar hábito existente
- [x] Deletar hábito
- [x] Listar todos os hábitos
- [x] Registrar conclusão diária
- [x] Histórico de realizações

### ✅ Estatísticas e Progresso
- [x] Total de pontos acumulados
- [x] Nível do usuário
- [x] Maior sequência (streak)
- [x] Dashboard com visualizações
- [x] Histórico de progresso

### ✅ Interface e Experiência
- [x] Interface moderna e responsiva
- [x] Tema claro/escuro
- [x] Paleta de cores profissional (Roxo/Verde/Vermelho)
- [x] Tipografia elegante (Poppins)
- [x] Bottom navigation bar
- [x] Loading states elegantes
- [x] Tratamento robusto de erros
- [x] Empty states informativos
- [x] Animações suaves
- [x] Material Design 3 compliance

### ✅ Integração com API
- [x] Cliente HTTP com Dio
- [x] Autenticação automática
- [x] Tratamento de erros detalhado
- [x] Logging profissional
- [x] Timeouts configuráveis
- [x] Interceptadores para headers

---

## 📦 Dependências Principais

### HTTP & Networking
- **dio: ^5.3.0** - Cliente HTTP profissional com interceptadores
- **http: ^1.1.0** - HTTP client leve

### State Management
- **provider: ^6.0.0** - Gerenciamento de estado reativo e escalável

### Storage & Persistência
- **shared_preferences: ^2.2.0** - Armazenamento local key-value para tokens e preferências

### Navegação
- **go_router: ^12.0.0** - Roteamento declarativo moderno com deep linking

### UI & Design
- **cupertino_icons: ^1.0.2** - Ícones do iOS
- **intl: ^0.19.0** - Internacionalização e formatação de datas/moedas

### Logging
- **logger: ^2.0.0** - Logging estruturado e colorizado

### Desenvolvimento
- **build_runner: ^2.4.0** - Geração de código (necessário para json_serializable)
- **json_serializable: ^6.7.0** - Serialização JSON automática

---

## 👨‍💻 Desenvolvimento

### Configurar Ambiente

```bash
# 1. Instalar Flutter (se não tiver)
# https://flutter.dev/docs/get-started/install

# 2. Verificar instalação
flutter doctor

# 3. Clonar/Entrar no projeto
cd flutter_app

# 4. Instalar dependências
flutter pub get

# 5. (Opcional) Abrir em emulador/dispositivo
flutter emulators launch Pixel_4_API_30
```

### Principais Comandos de Desenvolvimento

```bash
# Executar aplicação
flutter run

# Debug com logs verbosos
flutter run -v

# Limpar e recompilar
flutter clean && flutter pub get && flutter run

# Analisar código
flutter analyze

# Executar testes
flutter test

# Build para produção
flutter build apk --release      # Android
flutter build ios --release      # iOS
flutter build web --release      # Web
```

### Customização

#### Alterar Cores
Edite `lib/theme/app_theme.dart`:
```dart
static const Color primaryColor = Color(0xFF6366F1);
static const Color accentColor = Color(0xFF10B981);
static const Color errorColor = Color(0xFFEF4444);
```

#### Alterar URL da API
Edite `lib/config/app_config.dart`:
```dart
static const String apiBaseUrl = 'http://seu-servidor:8000';
```

#### Adicionar Novos Endpoints
1. Crie método no service correspondente
2. Crie método no provider correspondente
3. Use nos screens

---

## 🐛 Troubleshooting

### Erro: "Failed to resolve dependency"
```bash
flutter clean
flutter pub get
flutter pub upgrade
```

### Erro: "Connection refused" (API não conecta)
- Verifique se a API está rodando em `http://localhost:8000`
- Para Android Emulator, use: `http://10.0.2.2:8000`
- Para dispositivo físico, use o IP da máquina: `http://192.168.1.100:8000`

### Erro: "No connected devices"
```bash
flutter devices              # Ver dispositivos
flutter emulators launch DEVICE_NAME
```

### Erro: "CORS error"
Certifique-se que a API tem CORS configurado:
```python
from fastapi.middleware.cors import CORSMiddleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
)
```

### Erro: "Token inválido"
Faça logout e login novamente:
```bash
# No app, execute logout e refaça login
```

---

## 📖 Referência Rápida

### Criar Novo Provider

```dart
// 1. Criar classe que estende ChangeNotifier
class MeuProvider extends ChangeNotifier {
  String? _dados;
  String? get dados => _dados;
  
  Future<void> carregarDados() async {
    // Lógica aqui
    notifyListeners();  // Avisar que mudou
  }
}

// 2. Registrar em main.dart
ChangeNotifierProvider(create: (_) => MeuProvider())

// 3. Usar nos screens
context.read<MeuProvider>().carregarDados();
```

### Criar Novo Service

```dart
class MeuService {
  Future<List<Dados>> obterDados(String token) async {
    final response = await dio.get(
      '/endpoint',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    // Processar response
  }
}
```

### Criar Novo Screen

```dart
class MeuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meu Screen')),
      body: Center(
        child: Text('Conteúdo aqui'),
      ),
    );
  }
}
```

### Adicionar Rota

```dart
// Em lib/routes/app_router.dart
GoRoute(
  path: '/meu-route',
  builder: (context, state) => MeuScreen(),
)
```

---

## 🎯 Próximos Passos

### Curto Prazo
- [ ] Teste a aplicação completamente
- [ ] Personalize cores e branding
- [ ] Configure URLs de produção
- [ ] Teste em dispositivo real

### Médio Prazo
- [ ] Escreva testes unitários
- [ ] Otimize performance
- [ ] Adicione novas funcionalidades
- [ ] Revise tratamento de erros

### Longo Prazo
- [ ] Prepare para produção
- [ ] Configure CI/CD
- [ ] Publique nas lojas (Play Store, App Store)
- [ ] Implemente analytics

---

## 📝 Notas Importantes

- A aplicação usa **Provider** para gerenciamento de estado
- Todos os providers estão configurados em `main.dart`
- A autenticação é checada automaticamente em `app_router.dart`
- Tokens são persistidos em `SharedPreferences`
- A API deve estar rodando em `http://localhost:8000` (ou conforme configurado)
- Use `flutter analyze` regularmente para manter a qualidade do código

---

## 💡 Dicas de Desenvolvimento

1. **Use Consumer para otimizar rebuilds:**
   ```dart
   Consumer<MeuProvider>(
     builder: (context, provider, _) { ... }
   )
   ```

2. **Sempre trate exceções de API:**
   ```dart
   try {
     // chamada API
   } on ApiException catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(...);
   }
   ```

3. **Use const Widgets:**
   ```dart
   const Text('Olá')  // Melhor performance
   ```

4. **Teste mudanças frequentemente:**
   ```bash
   flutter run -v
   ```

---

## 📞 Suporte

Para problemas:
1. Consulte a seção [Troubleshooting](#troubleshooting)
2. Revise os logs com `flutter logs`
3. Verifique a API com `flutter run -v`

---

**Versão:** 1.0.0  
**Data:** Fevereiro 2026  
**Status:** ✅ Pronto para Produção
