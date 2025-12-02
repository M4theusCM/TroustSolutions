var empresaModel = require("../models/empresaModel");

function buscarPorCnpj(req, res) {
  var cnpjEmpresa = req.body.cnpjEmpresaServer;

  empresaModel.buscarPorCnpj(cnpjEmpresa).then((resultado) => {
    res.status(200).json(resultado)
  });
}

function cadastrarEmpresa(req, res) {
  var nomeFantasiaEmpresa = req.body.nomeFantasiaEmpresaServer;
  var cnpjEmpresa = req.body.cnpjEmpresaServer;
  var razaoSocialEmpresa = req.body.razaoSocialEmpresaServer;
  var tellFixoEmpresa = req.body.tellFixoEmpresaServer;
  var tellCellEmpresa = req.body.tellCellEmpresaServer;
  var codigoEmpresa = req.body.codigoEmpresaServer;

  empresaModel.cadastrarEmpresa(nomeFantasiaEmpresa, razaoSocialEmpresa, cnpjEmpresa, tellFixoEmpresa, tellCellEmpresa, codigoEmpresa)
    .then((resultado) => {
      res.status(201).json(resultado);
    });
}

function cadastrarLogradouro(req, res) {
  var cepEmpresa = req.body.cepEmpresaServer;
  var numEndeEmpresa = req.body.numEndeEmpresaServer;
  var compEndeEmpresa = req.body.compEndeEmpresaServer;
  var ruaEndeEmpresa = req.body.ruaEndeEmpresaServer;
  var bairoEndeEmpresa = req.body.bairoEndeEmpresaServer;
  var estadoEndeEmpresa = req.body.estadoEndeEmpresaServer;
  var cnpjEmpresa = req.body.cnpjEmpresaServer;

  empresaModel.cadastrarLogradouro(cepEmpresa, numEndeEmpresa, compEndeEmpresa, ruaEndeEmpresa, bairoEndeEmpresa, estadoEndeEmpresa, cnpjEmpresa)
    .then((resultado) => {
      res.status(201).json(resultado);
    });
}

function cadastrarTanqueEmpresa(req, res) {
  var nomeTanque = req.body.nomeTanqueServer
  var setorTanque = req.body.setorTanqueServer
  var metragem = req.body.metragemTanqueServer
  var litragem = req.body.litragemTanqueServer
  var tempMax = req.body.tempMaxTanqueServer
  var tempMin = req.body.tempMinTanqueServer
  var codEmpresa = req.body.codEmpresaServer

  empresaModel.cadastrarTanqueEmpresa(nomeTanque, setorTanque, metragem, litragem, tempMax, tempMin, codEmpresa)
    .then((resultado) => {
      res.status(201).json(resultado);
    });
}

function buscarEmpresas(req, res){
  empresaModel.buscarEmpresas()
  .then((resultado) => {
    res.status(201).json(resultado)
  })
}

module.exports = {
  buscarPorCnpj,
  cadastrarEmpresa,
  cadastrarLogradouro,
  cadastrarTanqueEmpresa,
  buscarEmpresas
};
