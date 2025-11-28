var tanqueModel = require("../models/tanqueModel")

function tanqueEmpresa(req, res) {
    var fkEmpresa = req.params.fkEmpresa
    if (fkEmpresa == undefined) {
        res.status(400).send("Empresa indefinida")
    } else {
        tanqueModel.tanquesEmpresa(fkEmpresa)
            .then(
                function (resultadotanque) {
                    console.log(`\nResultados encontrados: ${resultadotanque.length}`)
                    console.log(`Resultados: ${JSON.stringify(resultadotanque)}`)

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
    console.log('A: '+fkEmpresa, idTanque)
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


module.exports = {
    tanqueEmpresa,
    estatisticasTanque,
}