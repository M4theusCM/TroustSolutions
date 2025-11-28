var express = require("express")
var router = express.Router()

var tanqueController = require("../controllers/tanqueController")

router.get("/tanquesEmpresa/:fkEmpresa", function(req, res){
    tanqueController.tanqueEmpresa(req, res)
})

router.post("/estatisticasTanques", function(req, res){
    tanqueController.estatisticasTanque(req, res)
})

module.exports = router