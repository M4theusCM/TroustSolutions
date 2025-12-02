var database = require("../database/config");

function buscarPorCnpj(cnpjEmpresa) {
  var instrucaoSql = `SELECT * FROM empresa WHERE cnpj = '${cnpjEmpresa}'`;

  return database.executar(instrucaoSql);
}

function cadastrarEmpresa(nomeFantasiaEmpresa, razaoSocialEmpresa, cnpjEmpresa, tellFixoEmpresa, tellCellEmpresa, codigoEmpresa) {
  var instrucaoSql = `INSERT INTO empresa (nomeFantasia, razaoSocial, cnpj, tellFixo, cell, codigo) VALUES ('${nomeFantasiaEmpresa}', '${razaoSocialEmpresa}', '${cnpjEmpresa}', '${tellFixoEmpresa}', '${tellCellEmpresa}', '${codigoEmpresa}')`;

  return database.executar(instrucaoSql);
}

function cadastrarLogradouro(cepEmpresa, numEndeEmpresa, compEndeEmpresa, ruaEndeEmpresa, bairoEndeEmpresa, estadoEndeEmpresa, cnpjEmpresa) {
  var instrucaoSql = `INSERT INTO logradouro (cep, numero, complemento, rua, bairro, estado, fkEmpresa) VALUES ('${cepEmpresa}', '${numEndeEmpresa}', '${compEndeEmpresa}', '${ruaEndeEmpresa}', '${bairoEndeEmpresa}', '${estadoEndeEmpresa}', (SELECT idEmpresa FROM empresa WHERE cnpj = '${cnpjEmpresa}'))`;

  return database.executar(instrucaoSql);
}

function cadastrarTanqueEmpresa(nomeTanque, setorTanque, metragem, litragem, tempMax, tempMin, codEmpresa) {
  var instrucaoSql = `INSERT INTO tanque (TempMax, TempMin, mts_quadrados, litragem, nome, setor, fkEmpresa) VALUES 
    (${tempMax}, ${tempMin}, ${metragem}, ${litragem}, '${nomeTanque}', '${setorTanque}', (SELECT idEmpresa FROM empresa WHERE codigo = '${codEmpresa}'))`;

  return database.executar(instrucaoSql);
}

function buscarEmpresas(){
  var instrucaoSql = `SELECT nomeFantasia, codigo FROM empresa;`
  return database.executar(instrucaoSql);
}

module.exports = {
  buscarPorCnpj,
  cadastrarEmpresa,
  cadastrarLogradouro,
  cadastrarTanqueEmpresa,
  buscarEmpresas
};
