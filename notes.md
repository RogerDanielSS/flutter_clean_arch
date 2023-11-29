# BDD

O BDD (Behavior Driven Development ou Desenvolvimento Orientado ao Comportamento) é uma metodologia baseada em comportamento. Busca uma linguagem comum para conversar com pessoas que não são técnicas


# Clean Archtecture
## Domain
1. Onde ficam as regras de negócio
2. Não tem implementações de classes, apenas classes abstratas e entidades

## Data Layer 
1. Onde ficam as classes concretas definidas na camada de domínio (domain)
2. Onde são aplicadas as regras de negócio
3. Essa camada também define abstrações de serviços que precisa consumir que serão implementados na camada de infrestrutura 

## Infra
