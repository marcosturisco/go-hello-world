# Estágio de construção: usa a imagem 'golang' para compilar o binário
FROM golang:1.23.0 AS builder

# Setando o diretório raiz do projeto
WORKDIR /app

# Copiando o arquivo main para a imagem
COPY main.go .

# Compila o código Go como um binário estático
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-s -w" -o app main.go

# Estágio de execução: usa a imagem 'scratch' para a imagem final mínima
FROM scratch

# Entrando a raiz do projeto
WORKDIR /app

# Copia o binário compilado do estágio de construção
COPY --from=builder /app/app .

# Comando para rodar o binário
CMD ["/app/app"]
