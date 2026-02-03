# Controle de Hábitos - Flutter App

Aplicação Flutter profissional para controle e acompanhamento de hábitos, integrando-se com a API FastAPI "Habits API".

## 📱 Funcionalidades

✨ **Recursos Principais:**
- ✅ Autenticação com JWT
- ✅ Gerenciamento completo de usuários
- ✅ Criação e rastreamento de hábitos
- ✅ Visualização de estatísticas
- ✅ Interface intuitiva e responsiva
- ✅ Suporte a tema claro/escuro
- ✅ Sincronização em tempo real com API
- ✅ Offline persistence (com SharedPreferences)

## 🏗️ Arquitetura

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

## 🚀 Instalação e Execução

### Pré-requisitos

- Flutter 3.0+
- Dart 3.0+
- A API FastAPI rodando localmente (http://localhost:8000)

### 1. Clonar/Extrair o Projeto

```bash
cd flutter_app
```

### 2. Instalar Dependências

```bash
flutter pub get
```

### 3. Configurar API

Edite [lib/config/app_config.dart](lib/config/app_config.dart) e configure a URL da API:

```dart
static const String apiBaseUrl = 'http://localhost:8000'; // Seu servidor
```

### 4. Executar a Aplicação

**No Android:**
```bash
flutter run -d android
```

**No iOS:**
```bash
flutter run -d ios
```

**Em Web:**
```bash
flutter run -d web
```

## 📚 Documentação

### Fluxo de Uso

#### 1. **Registro de Novo Usuário**
- Acesse a tela de registro
- Preencha: Nome, Email e Senha
- Sistema cria a conta e faz login automático

#### 2. **Login**
- Insira email e senha
- Receba token JWT
- Acesso ao dashboard de hábitos

#### 3. **Criar Hábito**
- Clique em "+" na tela inicial
- Preencha:
  - Título do hábito
  - Descrição (opcional)
  - Frequência (Diário/Semanal/Mensal/Anual)
  - Pontos (1-1000)
  - Ativar/Desativar

#### 4. **Acompanhar Hábitos**
- Visualize todos os hábitos na aba "Hábitos"
- Registre conclusão diária
- Acompanhe seu progresso

#### 5. **Visualizar Estatísticas**
- Navegue para "Estatísticas"
- Veja:
  - Total de pontos acumulados
  - Nível atual
  - Maior sequência (streak)

## 🔌 Integração com API

### Endpoints Utilizados

```
POST   /users/register           Registrar novo usuário
POST   /users/login              Realizar login
GET    /users/me                 Dados do usuário autenticado
PUT    /users/me                 Atualizar perfil

POST   /habits                   Criar hábito
GET    /habits                   Listar hábitos
GET    /habits/{id}              Detalhes do hábito
PUT    /habits/{id}              Atualizar hábito
DELETE /habits/{id}              Deletar hábito

POST   /habits/{id}/logs         Registrar conclusão
GET    /habits/{id}/logs         Listar logs

GET    /stats/me                 Estatísticas do usuário
```

## 🎨 Tema

### Cores

- **Primária**: `#6366F1` (Roxo/Indigo)
- **Primária Clara**: `#818CF8`
- **Primária Escura**: `#4F46E5`
- **Acento**: `#10B981` (Verde)
- **Perigo**: `#EF4444` (Vermelho)
- **Aviso**: `#FB923C` (Laranja)

### Fontes

- **Principal**: Poppins (Regular, SemiBold, Bold)
- **Fallback**: Sistema

## 📦 Dependências Principais

```yaml
# HTTP & API
dio: ^5.3.0                 # Cliente HTTP robusto
http: ^1.1.0               # HTTP alternativo

# State Management
provider: ^6.0.0           # Gerenciamento de estado

# Storage
shared_preferences: ^2.2.0 # Armazenamento local

# Navegação
go_router: ^12.0.0         # Roteamento declarativo

# UI/UX
intl: ^0.19.0              # Internacionalização
cupertino_icons: ^1.0.2    # Ícones iOS

# Logging
logger: ^2.0.0             # Logging estruturado
```

## 🔐 Segurança

- ✅ Tokens JWT armazenados com segurança
- ✅ Senhas criptografadas na API
- ✅ HTTPS recomendado em produção
- ✅ Validação de entrada
- ✅ Tratamento de erros robusto

## 🧪 Testes

### Executar Testes

```bash
flutter test
```

### Cobertura de Testes

```bash
flutter test --coverage
```

## 🐛 Troubleshooting

### Erro de conexão com API

**Problema**: "Erro de conexão. Verifique sua internet."

**Solução**:
1. Verifique se a API está rodando
2. Confirme a URL em `app_config.dart`
3. Em emulador Android, use `10.0.2.2` em vez de `localhost`

### Token expirado

**Problema**: Recebe erro 401 Unauthorized

**Solução**:
1. Faça login novamente
2. O token será atualizado automaticamente

### Dados não carregam

**Problema**: Tela em branco ou de erro

**Solução**:
1. Verifique sua conexão de internet
2. Tente atualizar (swipe para baixo)
3. Reinicie a aplicação

## 📝 Logs e Debug

Ative logs detalhados:

```dart
// Em main.dart
ApiLogger.logDebug('Mensagem de debug');
```

Os logs são exibidos no console do Flutter durante desenvolvimento.

## 🚀 Build para Produção

### Android APK

```bash
flutter build apk --release
```

**Output**: `build/app/outputs/flutter-app-release.apk`

### Android App Bundle

```bash
flutter build appbundle --release
```

### iOS

```bash
flutter build ios --release
```

### Web

```bash
flutter build web --release
```

## 📱 Compatibilidade

- **Android**: 6.0+ (API 21+)
- **iOS**: 11.0+
- **Web**: Chrome, Firefox, Safari, Edge

## 🤝 Contribuindo

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -m 'Add nova-feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT.

## 👨‍💻 Desenvolvido com

- Flutter 🚀
- Dart 💙
- FastAPI ⚡
- PostgreSQL 🐘

## 📞 Suporte

Para dúvidas ou problemas:
1. Consulte a [documentação da API](../README.md)
2. Verifique issues similares
3. Abra uma nova issue

---

**Última atualização**: Fevereiro de 2026

**Versão**: 1.0.0
