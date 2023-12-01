# BDD

O BDD (Behavior Driven Development ou Desenvolvimento Orientado ao Comportamento) é uma metodologia baseada em comportamento. Busca uma linguagem comum para conversar com pessoas que não são técnicas

# TDD
  Fluxo TDD: você faz o teste passar e depois está livre para fazer melhorias no código

## Test
  É criado o teste que descreve o funcionamento esperado do algoritmo (pequenos, abrangem partes individuais de código)

## Driven
  É desenvolvido o código mínimo (simples) que passe nesse teste

## Development
  Código é refatorado


# Clean Archtecture
## Domain
1. Onde ficam as regras de negócio
2. Não tem implementações de classes, apenas classes abstratas e entidades

## Data Layer 
1. Onde ficam as classes concretas definidas na camada de domínio (domain)
2. Onde são aplicadas as regras de negócio
3. Essa camada também define abstrações de serviços que precisa consumir que serão implementados na camada de infrestrutura 

## Infra
1. Onde ficam chamadas de funções/bibliotecas de terceiros ou APIs
2. Sua importância é assegurar uma interface à camada de dados, mesmo que as funções ou bibliotecas chamadas se alterem