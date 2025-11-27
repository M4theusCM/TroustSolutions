var empresaModel = require("../models/empresaModel");

function buscarPorCnpj(req, res) {
  var cnpjEmpresa = req.body.cnpjEmpresaServer;

  empresaModel.buscarPorCnpj(cnpjEmpresa).then((resultado) => {
    res.status(200).json(resultado);
  });
}

function cadastrarEmpresa(req, res) {
  var nomeFantasiaEmpresa = req.body.nomeFantasiaEmpresaServer;
  var cnpjEmpresa = req.body.cnpjEmpresaServer;
  var razaoSocialEmpresa = req.body.razaoSocialEmpresaServer;
  var tellFixoEmpresa = req.body.tellFixoEmpresaServer;
  var tellCellEmpresa = req.body.tellCellEmpresaServer;


  empresaModel.buscarPorCnpj(cnpjEmpresa).then((resultado) => {
    if (resultado.length > 0) {
      res.status(401).json({ mensagem: `a empresa com o cnpj ${cnpjEmpresa} já existe` });
    } else {
      empresaModel.cadastrarEmpresa(nomeFantasiaEmpresa, razaoSocialEmpresa, cnpjEmpresa, tellFixoEmpresa, tellCellEmpresa)
        .then((resultado) => {
          res.status(201).json(resultado);
        });
    }
  });
}

function cadastrarLogradouro(req, res) {
  var cepEmpresa = req.body.cepEmpresaServer;
  var numEndeEmpresa = req.body.numEndeEmpresaServer;
  var compEndeEmpresa = req.body.compEndeEmpresaServer;
  var ruaEndeEmpresa = req.body.ruaEndeEmpresaServer;
  var bairoEndeEmpresa = req.body.bairoEndeEmpresaServer;
  var estadoEndeEmpresa = req.body.estadoEndeEmpresaServer;

      empresaModel.cadastrarLogradouro(cepEmpresa, numEndeEmpresa, compEndeEmpresa, ruaEndeEmpresa, bairoEndeEmpresa, estadoEndeEmpresa)
        .then((resultado) => {
          res.status(201).json(resultado);
        });
}

module.exports = {
  buscarPorCnpj,
  cadastrarEmpresa,
  cadastrarLogradouro
};
