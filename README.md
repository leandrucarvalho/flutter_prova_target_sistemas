### Flutter Prova App

Este é um aplicativo Flutter de autenticação simples que inclui uma tela de login e uma tela de captura de informações. Ele demonstra o uso de campos de entrada de texto, validação de entrada, navegação entre telas, armazenamento de dados locais com `shared_preferences`, e a implementação do gerenciamento de estado com o pacote MobX.

### Funcionalidades

#### Tela de Login

1. Campo de senha com validação.
2. Campo de texto para inserção do login.
3. Verificação e alerta se os campos de login e senha não estiverem preenchidos corretamente.
4. Validação dos campos:
   - A senha deve ter pelo menos 2 caracteres.
   - A senha deve conter apenas letras maiúsculas e minúsculas e números.
   - Os campos de login e senha não podem ultrapassar 20 caracteres.
   - Os campos não podem terminar com espaços em branco.
5. Abertura de uma página web direcionada para `google.com.br` ao tocar no label "Política de Privacidade".

#### Tela de Captura de Informações

1. Armazenamento e listagem das informações digitadas pelo usuário em um card.
2. O foco da digitação deve permanecer no campo "Digite seu texto" o tempo todo.
3. Pressionar "Enter" para verificar se a informação foi preenchida.
4. Salvar e ler as informações usando a biblioteca `shared_preferences`.
5. Ícone de exclusão que abre um pop-up de confirmação.
6. Utilização do pacote MobX para o gerenciamento de estado.

### Screenshots

![tela_login](https://github.com/leandrucarvalho/flutter_prova_target_sistemas/assets/56963289/24133162-88ea-4ebe-9048-6c0b9a475bb4)
![tela_info](https://github.com/leandrucarvalho/flutter_prova_target_sistemas/assets/56963289/978ea7e8-5ae5-4a97-9d1e-a7c51a7fbe31)


### Como Executar

1. Certifique-se de ter o ambiente Flutter configurado corretamente no seu sistema.

2. Clone este repositório:

   ```bash
   git clone https://github.com/leandrucarvalho/flutter_prova_target_sistemas
   ```

3. Navegue até o diretório do projeto:

   ```bash
   cd flutter_authentication_app
   ```

4. Execute o aplicativo:

   ```bash
   flutter run
   ```

### Dependências

- `shared_preferences`: Para salvar e ler as informações do usuário.

### Autores

- [Leandro Carvalho](https://github.com/leandrucarvalho)

### Mock API (Diferencial)

Foi feita uma [api](https://github.com/leandrucarvalho/api_login_target_prova) com dados mockado em node.js para validar o login do usuário. 

### Agradecimentos

- Obrigado por experimentar o Flutter Prova App. Se você tiver alguma dúvida ou sugestão, sinta-se à vontade para entrar em contato conosco.

Aproveite o desenvolvimento com Flutter!
