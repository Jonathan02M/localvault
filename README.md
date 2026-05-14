LocalVault

Aplicativo Flutter desenvolvido para demonstrar persistência de dados locais utilizando:

SharedPreferences
Hive
flutter_secure_storage

O projeto aplica conceitos de privacidade e LGPD, incluindo armazenamento seguro e direito ao esquecimento.

Tecnologias Utilizadas
Flutter
Dart
Provider
SharedPreferences
Hive
Hive Flutter
flutter_secure_storage
Funcionalidades
1. Configurações (SharedPreferences)

Persistência automática das preferências do usuário:

Modo escuro / claro
Idioma
Notificações

As configurações permanecem salvas mesmo após fechar o aplicativo.

2. Perfil do Usuário (Hive)

Cadastro e persistência local de perfil contendo:

Nome
E-mail
Data de cadastro
Pontuação

Também possui:

Salvamento local com Hive
Exibição dos dados
Exclusão completa do perfil
LGPD — Direito ao Esquecimento

O botão “Limpar Perfil” remove completamente os dados armazenados do usuário.

3. Armazenamento Seguro (flutter_secure_storage)

Funcionalidades:

Salvar token fictício
Recuperar token
Excluir token

Os dados são armazenados de forma segura utilizando criptografia nativa do dispositivo.

4. Migração de Dados (Bônus)

O projeto contém um MigrationService responsável por:

Detectar versão antiga dos dados
Migrar dados para nova estrutura
Salvar a versão atual no SharedPreferences
Estrutura do Projeto
lib/
├── main.dart
├── models/
│   └── user_profile.dart
├── services/
│   ├── settings_service.dart
│   ├── storage_service.dart
│   └── migration_service.dart
├── screens/
│   ├── home_screen.dart
│   ├── settings_screen.dart
│   └── profile_screen.dart
└── adapters/
    └── user_profile_adapter.dart
Dependências
dependencies:
  flutter:
    sdk: flutter

  shared_preferences: ^2.2.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_secure_storage: ^9.0.0
  provider: ^6.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  hive_generator: ^2.0.1
  build_runner: ^2.4.0
Como Executar
1. Baixar dependências
flutter pub get
2. Gerar plataformas Flutter

Caso necessário:

flutter create .
3. Executar o aplicativo
Web
flutter run -d chrome
Windows
flutter run -d windows
Android
flutter run
Objetivos do Projeto

Este aplicativo foi desenvolvido para praticar:

Persistência local
Gerenciamento de estado
Armazenamento seguro
Organização em camadas
Boas práticas Flutter
Conceitos de LGPD
Melhorias Futuras
Integração com Firebase
Login real
Criptografia avançada
Multiusuário
Backup em nuvem
Internacionalização completa
Autor

Jonathan Machado