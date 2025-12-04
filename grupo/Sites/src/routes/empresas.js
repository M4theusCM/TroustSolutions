var express = require("express");
var router = express.Router();

var empresaController = require("../controllers/empresaController");

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrarEmpresa", function (req, res) {
    empresaController.cadastrarEmpresa(req, res);
})

router.post("/buscarPorCnpj", function (req, res) {
    empresaController.buscarPorCnpj(req, res);
})

router.post("/cadastrarLogradouro", function (req, res) {
    empresaController.cadastrarLogradouro(req, res);
});


router.post("/cadastrarTanqueEmpresas", function(req, res){
    empresaController.cadastrarTanqueEmpresa(req, res)
})

router.get('/buscarEmpresasCad', function(req, res){
    empresaController.buscarEmpresas(req, res)
})

router.get(`/kpisEmpresa/:fkEmpresa`, function(req, res){
    empresaController.kpisEmpresa(req, res)
})

module.exports = router;