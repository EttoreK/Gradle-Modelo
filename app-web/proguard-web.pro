 #-dontobfuscate
-ignorewarnings
-optimizationpasses 5
-allowaccessmodification
-keepdirectories
-dontnote
-dontwarn

# Mantém os entry points e anotações de injeção
-keep @org.springframework.stereotype.* class * { *; }
-keep @org.springframework.web.bind.annotation.* class * { *; }

# Protege suas classes de dados e utilidades (bib-fulcro e bib-lista)
-keep class org.json.** { *; }


#-keepattributes *Annotation*,Signature,InnerClasses,EnclosingMethod 
-keepattributes SourceFile,LineNumberTable
-keepattributes *Annotation*,Signature
-keepattributes RuntimeInvisibleAnnotations,
                RuntimeInvisibleParameterAnnotations,
                RuntimeInvisibleTypeAnnotations
-keepparameternames
-renamesourcefileattribute SourceFile