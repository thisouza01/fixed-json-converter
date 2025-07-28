## 🛠️ Conversor de Dados JSON ⇄ Tamanho Fixo

**Fixon** é um projeto que realiza a conversão entre arquivos JSON e registros de tamanho fixo, integrando tecnologias modernas (**Java**) e legadas (**COBOL**). Ele facilita a comunicação entre sistemas modernos e aplicações baseadas em **mainframe**.

---

### 📌 Funcionalidades

- 🔄 **Java** → Geração de arquivos de tamanho fixo a partir de um arquivo `.json`.
- 🔁 **COBOL** → Leitura de arquivos de tamanho fixo e conversão de volta para JSON.
- 📄 Suporte a **múltiplos usuários** com campos como **nome**, **email** e **saldo**.

---

### 🧪 Tecnologias Utilizadas

| Linguagem | Uso |
|----------|-----|
| ☕ **Java (Gson)** | Leitura do JSON e criação do `.txt` de tamanho fixo |
| 💾 **COBOL** | Leitura do `.txt` fixo e reconstrução do JSON |
| 🐘 **Maven** | Gerenciamento de dependências (Java) |
| 📝 **GnuCOBOL** | Compilador COBOL utilizado no projeto |
