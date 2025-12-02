var tanqueModel = require("../models/tanqueModel")

function tanqueEmpresa(req, res) {
    var fkEmpresa = req.params.fkEmpresa
    if (fkEmpresa == undefined) {
        res.status(400).send("Empresa indefinida")
    } else {
        tanqueModel.tanquesEmpresa(fkEmpresa)
            .then(
                function (resultadotanque) {
                    res.status(200).json(resultadotanque)
                }
            )
            .catch(
                function (erro) {
                    console.log(erro)
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            )
    }
}

function estatisticasTanque(req, res) {
    var fkEmpresa = req.body.fkEmpresaServer
    var idTanque = req.body.idTanqueServer
    console.log('A: ' + fkEmpresa, idTanque)
    if (fkEmpresa == undefined) {
        res.status(400).send('Empresa não encontrada')
    } else if (idTanque == undefined) {
        res.status(400).send('Tanque não encontrado')
    } else {
        tanqueModel.estatisticasTanque(fkEmpresa, idTanque)
            .then(
                function (respostaEstatisticas) {
                    console.log(`\nRespostas encontrada: ${respostaEstatisticas.length}`)
                    console.log(JSON.stringify(respostaEstatisticas))
                    res.status(200).json(respostaEstatisticas)
                }
            )
            .catch(
                function (erro) {
                    console.log(erro)
                    console.log(
                        "\nHouve um erro ao realizar o cadastro! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            )
    }

}

function alterarConfigsTanque(req, res) {
    var idTanque = req.body.idTanqueServer
    var nomeTanque = req.body.nomeTanqueServer
    var max = req.body.tempMaxServer
    var min = req.body.tempMinServer
    var setortanque = req.body.setorTanqueServer
    var fkEmpresa = req.body.fkEmpresaServer
    console.log('Funcioton controller: \n\n\t\t', idTanque, nomeTanque, max, min, setortanque, fkEmpresa)
    if (idTanque == undefined) {
        res.status(401).send('Tanque não indentificado')
    } else if (nomeTanque == undefined) {
        res.status(400).send('Nome do tanque deve ser preenchido')
    } else if (max == undefined || min == undefined) {
        res.status(400).send('Temperaturas invalidas')
    } else if (setortanque == undefined) {
        res.status(400).send('Setor do tanque deve ser preenchido')
    } else if (fkEmpresa == undefined) {
        res.status(400).send('Empresa não identificada')
    } else {
        tanqueModel.alterarConfigsTanque(idTanque, nomeTanque, max, min, setortanque, fkEmpresa)
        .then((resultado) => {
            res.status(200).json(resultado)
        })
    }
}

function alertaTemp(req, res){
    var fkEmpresa = req.params.fkEmpresa

    if(fkEmpresa == undefined){
        res.status(400).send('Empresa não encontrada')
    }else{
        tanqueModel.alertaTemp(fkEmpresa)
        .then(function (resultado) {
            res.status(200).json(resultado)
        }).catch(function(erro){
            console.error(erro.sqlMessage)
            res.status(500).json(erro.sqlMessage)
        })
    }
}
function gerarGrafico(req, res) {
    var fkEmpresa = req.body.fkEmpresaServer
    var idTanque = req.body.idTanqueServer
    console.log('A: ' + fkEmpresa, idTanque)
    if (fkEmpresa == undefined) {
        res.status(400).send('Empresa não encontrada')
    } else if (idTanque == undefined) {
        res.status(400).send('Tanque não encontrado')
    } else {
        console.log('Entrei no controller')
        tanqueModel.gerarGrafico(fkEmpresa, idTanque)
            .then(
                function (resposta) {
                    console.log(`\nRespostas encontrada: ${resposta.length}`)
                    console.log(JSON.stringify(resposta))
                    res.status(200).json(resposta)
                }
            )
            .catch(
                function (erro) {
                    console.log(erro)
                    console.log(
                        "\nHouve um erro ao buscar os dados! Erro: ",
                        erro.sqlMessage
                    );
                    res.status(500).json(erro.sqlMessage);
                }
            )
    }

}


module.exports = {
    tanqueEmpresa,
    estatisticasTanque,
    alterarConfigsTanque,
    alertaTemp,
    gerarGrafico
}