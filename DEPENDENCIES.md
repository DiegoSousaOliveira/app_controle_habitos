# Dependências do Projeto

## 📦 Dependências Principais

### HTTP & Networking

**dio: ^5.3.0**
- Cliente HTTP profissional para Flutter
- Suporte a interceptadores
- Tratamento robusto de erros
- Timeout configurável
- [Documentação](https://pub.dev/packages/dio)

```dart
final dio = Dio();
final response = await dio.get('/api/endpoint');
```

**http: ^1.1.0**
- HTTP client leve como alternativa
- [Documentação](https://pub.dev/packages/http)

---

### State Management

**provider: ^6.0.0**
- Gerenciamento de estado com Consumer
- Lifecycle automático
- Otimizado para performance
- Fácil de aprender
- [Documentação](https://pub.dev/packages/provider)

```dart
Consumer<MeuProvider>(
  builder: (context, provider, child) {
    return Text(provider.valor);
  },
)
```

---

### Storage & Persistência

**shared_preferences: ^2.2.0**
- Armazenamento local de dados simples
- Key-value storage
- Acesso rápido
- Ideal para tokens e preferências
- [Documentação](https://pub.dev/packages/shared_preferences)

```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setString('token', 'seu_token');
final token = prefs.getString('token');
```

---

### Navegação

**go_router: ^12.0.0**
- Roteamento declarativo e moderno
- Suporte a deep linking
- Navegação baseada em URL
- Melhor que Navigator.push()
- [Documentação](https://pub.dev/packages/go_router)

```dart
context.go('/habits');
context.pushNamed('habit_detail', pathParameters: {'id': '123'});
```

---

### UI & Design

**cupertino_icons: ^1.0.2**
- Ícones do iOS (Cupertino)
- Integrado com Flutter
- [Documentação](https://pub.dev/packages/cupertino_icons)

**intl: ^0.19.0**
- Internacionalização e formatação
- Suporte a múltiplos idiomas
- Formatação de datas e moedas
- [Documentação](https://pub.dev/packages/intl)

```dart
import 'package:intl/intl.dart';
final formatted = DateFormat('dd/MM/yyyy').format(DateTime.now());
```

**cached_network_image: ^3.3.0**
- Cache de imagens de rede
- Otimização de performance
- [Documentação](https://pub.dev/packages/cached_network_image)

```dart
CachedNetworkImage(
  imageUrl: 'https://exemplo.com/imagem.jpg',
  placeholder: (context, url) => CircularProgressIndicator(),
)
```

---

### Logging

**logger: ^2.0.0**
- Logging estruturado e bonito
- Colorização automática
- Stack trace detalhado
- [Documentação](https://pub.dev/packages/logger)

```dart
logger.i('Informação');
logger.e('Erro', error, stackTrace);
logger.d('Debug');
```

---

## 🔧 Dependências de Desenvolvimento

### Build & Code Generation

**build_runner: ^2.4.0**
- Ferramenta para geração de código
- Necessária para json_serializable
- [Documentação](https://pub.dev/packages/build_runner)

```bash
flutter pub run build_runner build
flutter pub run build_runner watch
```

**json_serializable: ^6.7.0**
- Geração de código para serialização JSON
- Evita código repetitivo
- [Documentação](https://pub.dev/packages/json_serializable)

```dart
@JsonSerializable()
class User {
  final String name;
  
  User({required this.name});
  
  factory User.fromJson(Map<String, dynamic> json) => 
    _$UserFromJson(json);
  
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

### Testing

**flutter_test**
- Framework de testes do Flutter
- Já incluído com Flutter SDK

```dart
test('Descrição do teste', () {
  expect(resultado, esperado);
});
```

**flutter_lints: ^3.0.0**
- Linting rules recomendadas pelo time Flutter
- [Documentação](https://pub.dev/packages/flutter_lints)

---

## 📊 Dependências por Categoria

| Categoria | Packages |
|-----------|----------|
| **HTTP** | dio, http |
| **State** | provider |
| **Storage** | shared_preferences |
| **Navigation** | go_router |
| **UI** | cupertino_icons, intl, cached_network_image |
| **Logging** | logger |
| **Dev** | build_runner, json_serializable, flutter_lints |

---

## 🚀 Adicionar Novas Dependências

### Instalar

```bash
# Versão latest
flutter pub add novo_package

# Versão específica
flutter pub add novo_package:1.2.3

# Dev dependency
flutter pub add --dev novo_package
```

### Remover

```bash
flutter pub remove velho_package
```

### Atualizar

```bash
# Uma específica
flutter pub upgrade novo_package

# Todas
flutter pub upgrade
```

---

## 💡 Recomendações de Packages Adicionais

### Para Melhorias

```bash
# Notificações
flutter pub add firebase_messaging

# Persistência offline
flutter pub add hive

# Gráficos
flutter pub add fl_chart

# Animations
flutter pub add flutter_animate

# UI Components
flutter pub add badges
flutter pub add shimmer
```

### Exemplos de Uso

**Firebase Messaging**
```dart
final messaging = FirebaseMessaging.instance;
final token = await messaging.getToken();
```

**Hive**
```dart
final box = await Hive.openBox('usuarios');
box.put('user', userData);
```

**FL Chart**
```dart
LineChart(
  LineChartData(
    lineBarsData: [LineChartBarData(spots: [...])],
  ),
)
```

---

## 🔄 Versão das Dependências

Verifique versões com:

```bash
flutter pub outdated
```

Atualize para versões compatíveis:

```bash
flutter pub upgrade --prereleases
```

---

## 📝 Pubspec.yaml Explicado

```yaml
name: controle_habitos                    # Nome do projeto
description: App Flutter de controle...   # Descrição
publish_to: 'none'                        # Não publicar em pub.dev
version: 1.0.0+1                          # Versão + build number

environment:
  sdk: '>=3.0.0 <4.0.0'                   # Versão do Dart/Flutter

dependencies:
  flutter:
    sdk: flutter                          # SDK do Flutter
  
  http: ^1.1.0                            # Package externo

dev_dependencies:
  flutter_test:
    sdk: flutter                          # Testing framework

flutter:
  uses-material-design: true              # Design system Material

  assets:                                 # Assets estáticos
    - assets/images/
    
  fonts:                                  # Fontes customizadas
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Regular.ttf
```

---

## ⚠️ Compatibilidade

### Versões Suportadas

- **Flutter**: 3.0+
- **Dart**: 3.0+
- **Android**: API 21+ (Android 5.0)
- **iOS**: 11.0+

### Checklist de Compatibilidade

```bash
# Verificar versão do Flutter
flutter --version

# Verificar compatibilidade
flutter pub get --dry-run

# Análise completa
flutter analyze
```

---

## 🛡️ Segurança

### Packages Seguros

Todos os packages principais são:
- ✅ Mantidos ativamente
- ✅ Têm bom número de stars no pub.dev
- ✅ Usados em apps de produção
- ✅ Sem dependências suspeitas

### Verificar Segurança

```bash
# Verificar para vulnerabilidades
flutter pub outdated --vulnerable-only

# Audit de packages
flutter pub audit
```

---

## 📚 Recursos Adicionais

- **Pub.dev**: https://pub.dev (explore packages)
- **Awesome Flutter**: https://github.com/Solido/awesome-flutter
- **Flutter Packages**: https://flutter.dev/docs/development/packages-and-plugins/using-packages

---

**Última atualização**: Fevereiro de 2026
