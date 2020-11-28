# AppManutencao (Foo)

Projeto destinado à avaliação.

## Tecnologia

Delphi versão Tokyo 10.2.


## Instruções

## Correções

Corrija cada defeito descrito abaixo. Na descrição do defeito terá o problema e o objetivo da correção. Para cada defeito, preencher o campo "Solução" detalhando tecnicamente a causa do problema e a solução dada. 

`Defeito 1: na tela DatasetLoop, ao clicar no botão "Deletar pares" não deleta todos os pares do dataset. Objetivo: que todos os números pares sejam deletados`

- Solução:
Adicionado na verificação, se o número é par, a clausula ELSE. Na clausula ELSE, foi adicionado o método ClientDataSet.Next, pois da forma que estava sendo feito, sem o uso do else, estava pulando registros, pois quando realiza o "delete" de um determinado registro no clientdataset, o ponteiro do mesmo é passado para o próximo registro.