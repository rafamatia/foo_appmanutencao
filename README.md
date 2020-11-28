# AppManutencao (Foo)

Projeto destinado à avaliação.

## Tecnologia

Delphi versão Tokyo 10.2.


## Instruções

## Correções

Corrija cada defeito descrito abaixo. Na descrição do defeito terá o problema e o objetivo da correção. Para cada defeito, preencher o campo "Solução" detalhando tecnicamente a causa do problema e a solução dada. 

`Defeito 1: na tela DatasetLoop, ao clicar no botão "Deletar pares" não deleta todos os pares do dataset. Objetivo: que todos os números pares sejam deletados`

- Solução: 
	- Adicionado na verificação, se o número é par, a cláusula ELSE. Na cláusula ELSE, foi adicionado o método ClientDataSet.Next, pois da forma que estava sendo feito, sem o uso do else, estava pulando registros, pois quando realiza o "delete" de um determinado registro no clientdataset, o ponteiro do mesmo é passado para o próximo registro.

`Defeito 2: na tela ClienteServidor, ocorre erro "Out of Memory" ao clicar no botão "Enviar sem erros". Objetivo: que não ocorra erro por falta de memória, e que todos os arquivos sejam enviados para a pasta Servidor normalmente.`

- Solução: 
	- Adicionado blocos protegidos (TRY FINALLY e TRY EXCEPT).
	- Adicionado campo "id" no ClientDataSet, para guardar o "código" do arquivo, pois depoois de realizar o post, dentro do laço de repetição (for), no click do botão "btnEnviarSemErros", passou a chamar rotina de SalvarArquivos, dentro de um bloco Try Finally, no qual quando entra no finally, é executado o comando cds.EmptyDataSet. Feito desta forma para corrigir uma parte do erro "Out of Memory".
	- Foi necessário corrigir também a rotina SalvarArquivos, pois nela era criado um ClientDataSet auxiliar, que recebia o ClientDataSet passado como parâmetro, porém o mesmo não estava sendo destruido ao final da execução da rotina.