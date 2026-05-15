// swift-tools-version: 6.1
import PackageDescription
import Foundation
// Função genérica e reaproveitável para ler Regex
func pegaValor(pattern: String, from texto: String) -> String {
    if let regex = try? NSRegularExpression(pattern: pattern, options: []),
        let match = regex.firstMatch(
            in: texto, options: [], range: NSRange(location: 0, length: texto.utf16.count)
        ),
        let range = Range(match.range(at: 1), in: texto) {
        // Retorna a string limpa de quebras de linha ou espaços vazios (útil para Windows/Mac)
        return String(texto[range]).trimmingCharacters(in: .whitespacesAndNewlines)
    }
    return ""
}
// Navega para a raiz
let umbrellaDir: URL = URL(fileURLWithPath: #file)
    .deletingLastPathComponent() // sai de Package.swift
    .deletingLastPathComponent() // sai da pasta
// Lê o gradle.properties
let propArq: URL = umbrellaDir.appendingPathComponent("gradle.properties")
var propTexto: String = ""

if let data = try? Data(contentsOf: propArq), let texto = String(data: data, encoding: .utf8) {
    propTexto = texto
} else {
    print("AVISO: Não foi possível ler gradle.properties em \(propArq.path)")
}
// Pega o nome do App e o caminho do TOML (formato properties: chave=valor sem aspas)
let nomeApp: String = pegaValor(pattern: "projNome\\s*=\\s*(.*)", from: propTexto)
let nome: String = nomeApp.isEmpty ? "Modelo" : nomeApp

let libsDirRelativo: String = pegaValor(pattern: "libsDir\\s*=\\s*(.*)", from: propTexto)
// Se não achar, usa o caminho padrão do submódulo que definimos
let caminhoToml: String = libsDirRelativo.isEmpty ? "../gradle/libs.versions.toml" : libsDirRelativo
// Lê o libs.versions.toml a partir do caminho descoberto
let tomlArq: URL = umbrellaDir.appendingPathComponent(caminhoToml)
var tomlTexto: String = ""

if let data = try? Data(contentsOf: tomlArq), let texto = String(data: data, encoding: .utf8) {
    tomlTexto = texto
} else {
    print("AVISO: Não foi possível ler libs.versions.toml em \(tomlArq.path)")
}
// Pega as versões do TOML (formato toml: chave = "valor" com aspas)
let macVersion: String = pegaValor(pattern: "minMacosVer\\s*=\\s*\"(.*?)\"", from: tomlTexto)
let iosVersion: String = pegaValor(pattern: "minIosVer\\s*=\\s*\"(.*?)\"", from: tomlTexto)

let macVer: SupportedPlatform.MacOSVersion = SupportedPlatform.MacOSVersion(
    stringLiteral: macVersion.isEmpty ? "13.0" : macVersion
)
let iosVer: SupportedPlatform.IOSVersion = SupportedPlatform.IOSVersion(
    stringLiteral: iosVersion.isEmpty ? "15.0" : iosVersion
)

let plataformas: [SupportedPlatform]
#if os(macOS)
    plataformas = [ // se estiver no Mac, define as versões mínimas necessárias
        .macOS(macVer),
        .iOS(iosVer)
    ]
#else
    plataformas = [] // se estiver no Windows ou Linux, deixa a lista vazia para não dar erro
#endif

let package: Package = Package(
    name: nome, // Nome real do projeto extraído do properties
    platforms: plataformas,
    targets: [
        .executableTarget(
            name: nome,
            dependencies: [],
            path: "src",
            exclude: []
        ),
    ]
)