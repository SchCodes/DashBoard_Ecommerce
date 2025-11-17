# Dashboard de Vendas em Excel para E-commerce de Eletrônicos

Este projeto apresenta um dashboard de vendas desenvolvido em Excel para um e-commerce de eletrônicos, com base em um modelo relacional de banco de dados e em uma tabela analítica consolidada. O objetivo é disponibilizar uma visão clara da performance de vendas, clientes, produtos e entregas, utilizando uma base já preparada dentro da própria planilha para facilitar a reprodução e o uso em diferentes ambientes, inclusive no Excel Online.

A solução é composta por três camadas principais: scripts SQL de banco de dados, uma tabela analítica consolidada de vendas e o arquivo Excel com abas dedicadas a dados, cálculos e dashboard.

## Modelagem e dados

A modelagem do banco segue um contexto de e-commerce de eletrônicos, com entidades como:

- Cliente, ClientePF, ClientePJ
- Endereco
- FormaPagamento
- Produto
- Pedido
- ItemPedido
- Entrega

O script `02_DML_ecommerce.sql` popula o banco com um conjunto de clientes pessoa física e jurídica, endereços, formas de pagamento, um catálogo de produtos de tecnologia (notebooks, smartphones, periféricos, móveis de escritório, equipamentos de rede, áudio, etc.), além de 25 pedidos com múltiplos itens, valores de frete e registros de entrega em diferentes estados (entregue, em transporte, pendente, cancelado). Esses dados foram construídos para gerar volume e variedade suficientes para análise de KPIs de vendas e logística.

A partir dessas tabelas, é criada uma visão analítica que consolida as informações relevantes em uma única estrutura tabular, pronta para consumo no Excel. Essa visão é definida no arquivo `03_VIEW_base_vendas.sql` como `vw_base_vendas` e integra clientes, endereços, pedidos, itens, produtos, forma de pagamento e entregas.

## Estrutura analítica de vendas

A visão analítica `vw_base_vendas` é materializada na aba `Base_Vendas` do arquivo `excel/dashboard_vendas_ecommerce.xlsx`. Essa aba contém a base consolidada que o Excel utiliza para as tabelas dinâmicas e para o dashboard.

## Arquivo Excel e abas do projeto

O arquivo `excel/dashboard_vendas_ecommerce.xlsx` é organizado em três abas principais:

- **Base_Vendas**: contém a tabela analítica consolidada com todos os registros de vendas, já pronta para uso em tabelas dinâmicas. Não é necessário realizar importações adicionais ou conexões externas; todos os dados necessários estão incorporados nesta aba.
- **Calculos**: concentra as tabelas dinâmicas utilizadas para cálculo dos indicadores. A partir da `Base_Vendas`, são gerados KPIs como:
  - Faturamento total e faturamento por mês
  - Ticket médio por período
  - Top produtos e categorias por faturamento
  - Distribuição do faturamento por forma de pagamento
  - Ranking de clientes por valor comprado
  - Análise por estado e cidade
  - Acompanhamento de status de pedido e entrega
- **Dashboard**: aba destinada à montagem do painel visual, com gráficos e cartões de indicadores ligados às tabelas dinâmicas da aba `Calculos`. Esta aba agrupa os principais KPIs em uma visão executiva, com possibilidade de filtros por período, categoria, região e forma de pagamento.

## Scripts SQL

A pasta `/sql` contém os scripts necessários para recriar a base de dados:

- `01_DDL_ecommerce.sql`: definição das tabelas, chaves primárias e relacionamentos.
- `02_DML_ecommerce.sql`: carga dos dados de clientes, endereços, formas de pagamento, produtos, pedidos, itens de pedido e entregas.
- `03_VIEW_base_vendas.sql`: definição da visão analítica `vw_base_vendas`, que consolida as informações de vendas em um único conjunto de dados, alinhado à estrutura da aba `Base_Vendas`.
- `04_DQL_kpis.sql`: conjunto de consultas SQL exemplificando a obtenção dos principais KPIs diretamente no banco, utilizando a mesma lógica da camada analítica consumida pelo Excel.

Esses scripts permitem reproduzir a base em um banco MySQL, bem como validar os cálculos de negócio em nível de banco de dados, de forma consistente com o que é apresentado no dashboard.

## Requisitos

Para análise direta no Excel, basta utilizar o arquivo `excel/dashboard_vendas_ecommerce.xlsx`, que já traz a base consolidada na aba `Base_Vendas`. Para quem desejar reproduzir a camada de banco de dados, recomenda-se um ambiente com:

- MySQL Server e MySQL Workbench para execução dos scripts SQL
- Suporte a arquivos Excel (Excel desktop ou Excel Online)

A proposta do projeto é oferecer uma jornada completa de dados, da modelagem relacional até a visualização em dashboard, mantendo ao mesmo tempo uma experiência simples para quem apenas deseja abrir a planilha e explorar os indicadores de vendas do e-commerce de eletrônicos.
