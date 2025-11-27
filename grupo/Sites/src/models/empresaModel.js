var database = require("../database/config");

function buscarPorCnpj(cnpjEmpresa) {
  var instrucaoSql = `SELECT * FROM empresa WHERE cnpj = '${cnpjEmpresa}'`;

  return database.executar(instrucaoSql);
}

function cadastrarEmpresa(nomeFantasiaEmpresa, razaoSocialEmpresa, cnpjEmpresa, tellFixoEmpresa, tellCellEmpresa) {
  var instrucaoSql = `INSERT INTO empresa (nomeFantasia, razaoSocial, cnpj, tellFixo, cell) VALUES ('${nomeFantasiaEmpresa}', '${razaoSocialEmpresa}', '${cnpjEmpresa}', '${tellFixoEmpresa}', '${tellCellEmpresa}')`;

  return database.executar(instrucaoSql);
}

function cadastrarLogradouro(cepEmpresa, numEndeEmpresa, compEndeEmpresa, ruaEndeEmpresa, bairoEndeEmpresa, estadoEndeEmpresa) {
  var instrucaoSql = `INSERT INTO logradouro (cep, numero, complemento, rua, bairro, estado) VALUES ('${cepEmpresa}', '${numEndeEmpresa}', '${compEndeEmpresa}', '${ruaEndeEmpresa}', '${bairoEndeEmpresa}', '${estadoEndeEmpresa}')`;

  return database.executar(instrucaoSql);
}

module.exports = {
  buscarPorCnpj,
  cadastrarEmpresa, 
  cadastrarLogradouro
};
