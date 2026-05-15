# Mantém suas classes de dados para não quebrar a lógica de Estilos

# Mantém a lib org.json (usada no Estilos.java)
-keep class org.json.** { *; }

# Preserva membros internos de classes estáticas (como as de Valores.java)
-keepattributes InnerClasses

# Mantém os nomes dos métodos das interfaces se houver chamadas dinâmicas

# Tática: Se o R8 falha na compilação, desative as otimizações agressivas
-dontoptimize
-dontobfuscate # Apenas se o erro persistir

# Mantenha suas classes de utilidades (Estilos e Valores)

# Mantenha a org.json completa
-keep class org.json.** { *; }

# Ignore avisos que podem travar o build
-dontwarn **