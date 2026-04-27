# Controle de Combustível - Flutter

Versão Flutter do app **Controle de Combustível**, convertido do React Native (Expo).

## Funcionalidades

- **Calculadora de combustível**: calcula o custo da viagem com base na distância, consumo e preço por litro
- **Seletor de combustível**: Gasolina ou Etanol
- **Rota no Google Maps**: abre o Google Maps com origem e destino configurados
- **Aviso de pedágios**: alerta sobre possíveis pedágios na rota

## Como executar

### Pré-requisitos
- [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado
- Android Studio ou VS Code com extensão Flutter
- Dispositivo Android/iOS ou emulador

### Passos

```bash
# 1. Entrar na pasta do projeto
cd combustivel-app-flutter

# 2. Instalar dependências
flutter pub get

# 3. Rodar o app
flutter run
```

## Estrutura do Projeto

```
lib/
├── main.dart                  # Entrada do app
└── screens/
    ├── home_screen.dart       # Tela principal (calculadora)
    └── rota_screen.dart       # Tela de rota (Google Maps)
```

## Dependências

| Pacote | Versão | Uso |
|--------|--------|-----|
| `url_launcher` | ^6.2.5 | Abrir Google Maps |
| `cupertino_icons` | ^1.0.6 | Ícones iOS |

## Conversão do React Native para Flutter

| React Native | Flutter |
|---|---|
| `useState` hook | `StatefulWidget` + `setState` |
| `StyleSheet` | `ThemeData` + estilos inline |
| `TextInput` | `TextField` |
| `TouchableOpacity` | `GestureDetector` / `ElevatedButton` |
| `View` / `Text` | `Container` / `Column` / `Text` |
| `Linking.openURL` | `url_launcher` package |
| `AsyncStorage` | `shared_preferences` (pronto para adicionar) |
| `Alert.alert` | `AlertDialog` |
| Estado booleano de tela | `Navigator.push` |
