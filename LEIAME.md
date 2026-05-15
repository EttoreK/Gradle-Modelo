# Gradle-Modelo

Este repositório possui um modelo simples para desenvolvimento de aplicativos nas linguagens C++ (windows e linux), Swift (iOS e macOS) e Java (SpringBoot Web e  Android).

## Nota

Este código não funciona sozinho, ele depende dos submódulos de [gradle-build-logic](https://github.com/EttoreK/Gradle-Build-Logic.git) e [gradle-control](https://github.com/EttoreK/Gradle-Control.git) para completar a lógica de compilação.

# Uso

1. Clone este repositório:

```shell
git clone https://github.com/EttoreK/Gradle-Modelo.git [nome do seu projeto]
```

2. Desvincule da origem

```shell
cd [nome do seu projeto]
```

```shell
git remote rm origin
```

3. Crie um novo repositório a partir do código do modelo

```shell
git init -b main
```

```shell
git add .
```

```shell
git commit -m "Commit inicial"
```

4. Adicione os submodulos de [gradle-build-logic](https://github.com/EttoreK/Gradle-Build-Logic.git) e [gradle-control](https://github.com/EttoreK/Gradle-Control.git)

```shell
git submodule add https://github.com/EttoreK/Gradle-Build-Logic.git build-logic
```

```shell
git submodule add https://github.com/EttoreK/Gradle-Control.git gradle
```

5. Inicie o seu próprio desenvolvimento.